;; Stacks Clarity Toolkit - Token Helpers
;; SIP-010 trait definition + read-only wrappers
;; Use this when you need to interact with any SIP-010 token generically

;; ============================================================
;; SIP-010 Trait Definition
;; ============================================================

(define-trait sip-010-trait
  (
    ;; Transfer tokens
    (transfer (uint principal principal (optional (buff 34))) (response bool uint))

    ;; Get token name
    (get-name () (response (string-ascii 32) uint))

    ;; Get token symbol
    (get-symbol () (response (string-ascii 32) uint))

    ;; Get number of decimals
    (get-decimals () (response uint uint))

    ;; Get balance of a principal
    (get-balance (principal) (response uint uint))

    ;; Get total supply
    (get-total-supply () (response uint uint))

    ;; Get token URI (metadata)
    (get-token-uri () (response (optional (string-utf8 256)) uint))
  )
)

;; ============================================================
;; Constants
;; ============================================================

(define-constant err-token-not-found (err u300))
(define-constant err-invalid-token   (err u301))
(define-constant err-no-balance      (err u302))

;; ============================================================
;; Read-only Wrappers
;; ============================================================

;; Get token name safely
(define-read-only (get-name-safe (token <sip-010-trait>))
  (match (contract-call? token get-name)
    name (ok name)
    e    (err u300)
  )
)

;; Get token symbol safely
(define-read-only (get-symbol-safe (token <sip-010-trait>))
  (match (contract-call? token get-symbol)
    symbol (ok symbol)
    e      (err u300)
  )
)

;; Get decimals safely
(define-read-only (get-decimals-safe (token <sip-010-trait>))
  (match (contract-call? token get-decimals)
    decimals (ok decimals)
    e        (err u300)
  )
)

;; Get balance safely — returns u0 if not found
(define-read-only (get-balance-safe (who principal) (token <sip-010-trait>))
  (match (contract-call? token get-balance who)
    balance (ok balance)
    e       (ok u0)
  )
)

;; Get total supply safely
(define-read-only (get-supply-safe (token <sip-010-trait>))
  (match (contract-call? token get-total-supply)
    supply (ok supply)
    e      (err u300)
  )
)

;; Get token URI safely
(define-read-only (get-uri-safe (token <sip-010-trait>))
  (match (contract-call? token get-token-uri)
    uri (ok uri)
    e   (ok none)
  )
)

;; ============================================================
;; Utility Functions
;; ============================================================

;; Check if an address holds at least `amount` of a token
(define-read-only (has-enough-balance
  (who principal)
  (amount uint)
  (token <sip-010-trait>))
  (match (contract-call? token get-balance who)
    balance (ok (>= balance amount))
    e       (ok false)
  )
)

;; Get full token info in one call
(define-read-only (get-token-info (token <sip-010-trait>))
  (ok {
    name:   (unwrap-panic (contract-call? token get-name)),
    symbol: (unwrap-panic (contract-call? token get-symbol)),
    decimals: (unwrap-panic (contract-call? token get-decimals)),
    supply: (unwrap-panic (contract-call? token get-total-supply))
  })
)

;; Calculate human-readable balance from raw amount
;; e.g. raw=1000000, decimals=6 -> display u1
(define-read-only (to-display-amount (raw uint) (decimals uint))
  (ok (/ raw (pow u10 decimals)))
)

;; Calculate raw amount from human-readable
;; e.g. display=1, decimals=6 -> raw u1000000
(define-read-only (to-raw-amount (display uint) (decimals uint))
  (ok (* display (pow u10 decimals)))
)
