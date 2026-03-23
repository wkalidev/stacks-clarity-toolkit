# Gas Optimization Tips

## Cache contract-call results
Store toolkit results in let bindings,
never call the same function twice.

## Batch operations
Use single let block with multiple bindings
instead of nested contract calls.

## Prefer read-only when possible
Read-only functions cost no gas for off-chain calls.

## Example optimized pattern
(let (
  (fee    (unwrap-panic (contract-call? TOOLKIT basis-points amount u250)))
  (net    (unwrap-panic (contract-call? TOOLKIT safe-sub amount fee)))
  (split  (unwrap-panic (contract-call? TOOLKIT safe-div fee u2)))
)
  ;; use fee, net, split without re-calling toolkit
)
