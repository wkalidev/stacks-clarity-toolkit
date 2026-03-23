# Migration Guide

## From raw arithmetic to toolkit

### Before (unsafe)
(+ amount fee)
(* amount rate)

### After (safe)
(unwrap-panic (contract-call? TOOLKIT safe-add amount fee))
(unwrap-panic (contract-call? TOOLKIT safe-mul amount rate))

## Updating existing contracts
Since Clarity contracts are immutable, you need to:
1. Deploy new version with toolkit
2. Migrate any state if needed
3. Update frontend to new address
