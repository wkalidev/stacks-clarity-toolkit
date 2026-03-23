# Error Handling

## Pattern 1: unwrap! with error code
(unwrap! (contract-call? TOOLKIT safe-add a b) ERR-OVERFLOW)

## Pattern 2: match
(match (contract-call? TOOLKIT safe-sub a b)
  result (ok result)
  err    (err err)
)

## Pattern 3: try!
(try! (contract-call? TOOLKIT safe-add a b))

## Never use unwrap-panic in public functions
It causes the transaction to abort without a useful error code.
