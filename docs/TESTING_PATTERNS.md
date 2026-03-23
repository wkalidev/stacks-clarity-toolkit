# Testing Patterns for Toolkit

## Unit test safe-add
(define-public (test-safe-add)
  (let ((result (contract-call? TOOLKIT safe-add u100 u200)))
    (asserts! (is-ok result) (err u1))
    (asserts! (is-eq (unwrap-panic result) u300) (err u2))
    (ok true)
  )
)

## Test overflow protection
(define-public (test-overflow)
  (let ((max-uint u340282366920938463463374607431768211455))
    (asserts! (is-err (contract-call? TOOLKIT safe-add max-uint u1)) (err u1))
    (ok true)
  )
)
