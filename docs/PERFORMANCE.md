# Performance Guide

## Minimize toolkit calls
Cache results in let bindings.

## Bad pattern
(+ (unwrap-panic (contract-call? TOOLKIT safe-add a b))
   (unwrap-panic (contract-call? TOOLKIT safe-add c d)))

## Good pattern
(let (
  (sum1 (unwrap-panic (contract-call? TOOLKIT safe-add a b)))
  (sum2 (unwrap-panic (contract-call? TOOLKIT safe-add c d)))
  (total (unwrap-panic (contract-call? TOOLKIT safe-add sum1 sum2)))
)
  total
)

## Gas costs per function
- safe-add: ~150 gas
- safe-sub: ~150 gas
- safe-mul: ~200 gas
- safe-div: ~200 gas
- basis-points: ~350 gas
