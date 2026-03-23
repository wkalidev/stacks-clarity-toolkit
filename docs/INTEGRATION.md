# Integration Guide

## Add to your project
(define-constant TOOLKIT
  'SP936YWJPST8GB8FFRCN7CC6P2YR5K6NNBAARQ96.toolkit-math)

## Safe addition
(define-public (add-tokens (a uint) (b uint))
  (contract-call? TOOLKIT safe-add a b)
)

## Fee calculation (2.5% = 250 bps)
(define-read-only (get-fee (amount uint))
  (contract-call? TOOLKIT basis-points amount u250)
)

## Safe subtraction with error handling
(define-public (subtract-safe (a uint) (b uint))
  (unwrap! (contract-call? TOOLKIT safe-sub a b) ERR-UNDERFLOW)
)
