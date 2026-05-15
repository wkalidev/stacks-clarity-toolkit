;; Stacks Clarity Toolkit - Token Helpers
;; Common SIP-010 token operations

;; Traits
(use-trait ft-trait 'SP3FBR2AGK5H9QBDH3EEN6DF8EK8JY7RX8QJ5SVTE.sip-010-trait-ft-standard.sip-010-trait)


(define-constant max-batch-size u25)

;; Constants
(define-constant err-invalid-amount (err u200))
(define-constant err-length-mismatch (err u201))
(define-constant err-insufficient-balance (err u202))
(define-constant err-self-transfer (err u203))
(define-constant err-duplicate-recipient (err u204))
(define-constant err-too-many-transfers (err u205))


;; Safe Transfer
;; Validates amount > 0 and sender != recipient before calling transfer
(define-public (safe-transfer
  (amount uint)
  (sender principal)
  (recipient principal)
  (token-contract <ft-trait>))
  (begin
    (asserts! (> amount u0) err-invalid-amount)
    (asserts! (not (is-eq sender recipient)) err-self-transfer)
    (contract-call? token-contract transfer amount sender recipient none)
  )
)

;; Batch Transfer
;; Transfer tokens to multiple recipients in one call
;; Both lists must be the same length (max 50 entries)
(define-public (batch-transfer
  (recipients (list 50 principal))
  (amounts (list 50 uint))
  (token-contract <ft-trait>))
  (begin
    (asserts! (is-eq (len recipients) (len amounts)) err-length-mismatch)
    (ok (map transfer-one recipients amounts))
  )
)



;; Internal helper for batch-transfer
(define-private (transfer-one (recipient principal) (amount uint))
  (if (> amount u0)
    (unwrap-panic (as-contract (stx-transfer? amount tx-sender recipient)))
    false
  )
)

(define-private (contains-recipient
  (who principal)
  (recipients (list 50 principal)))

  (fold
    (lambda (item found)
      (or found (is-eq item who)))
    recipients
    false)
)

;; Get Balance Safe
;; Returns token balance, defaults to u0 if account not found
(define-read-only (get-balance-safe
  (who principal)
  (token-contract <ft-trait>))
  (match (contract-call? token-contract get-balance who)
    balance (ok balance)
    err (ok u0)
  )
)

;; Has Balance
;; Returns (ok true) if `who` holds at least `amount` tokens
(define-read-only (has-balance
  (who principal)
  (amount uint)
  (token-contract <ft-trait>))
  (match (contract-call? token-contract get-balance who)
    balance (ok (>= balance amount))
    err (ok false)
  )
)

;; Validate batch inputs before execution
(define-read-only (validate-batch-transfer
  (recipients (list 50 principal))
  (amounts (list 50 uint)))

  (begin
    ;; Lengths must match
    (asserts!
      (is-eq (len recipients) (len amounts))
      err-length-mismatch)

    ;; Enforce safer batch limit
    (asserts!
      (<= (len recipients) max-batch-size)
      err-too-many-transfers)

    ;; Ensure all amounts > 0
    (try!
      (fold
        (lambda (amount success)
          (begin
            (asserts! success err-invalid-amount)
            (asserts! (> amount u0) err-invalid-amount)
            (ok true)))
        amounts
        (ok true)))

    (ok true)
  )
)

;; Calculate Transfer Amount After Fee
;; Returns the net amount after deducting a basis-point fee
;; fee-bps: fee in basis points (e.g. u30 = 0.3%)
(define-read-only (amount-after-fee (amount uint) (fee-bps uint))
  (let ((fee (/ (* amount fee-bps) u10000)))
    (ok {
      net: (- amount fee),
      fee: fee
    })
  )
)

;; Validate Transfer Params
;; Quick check before executing a transfer
(define-read-only (validate-transfer
  (amount uint)
  (sender principal)
  (recipient principal))
  (begin
    (asserts! (> amount u0) err-invalid-amount)
    (asserts! (not (is-eq sender recipient)) err-self-transfer)
    (ok true)
  )
)
