# Why use toolkit vs raw Clarity?

## Raw Clarity (dangerous)
(+ u100 u200) ;; can overflow on large numbers

## With toolkit (safe)
(unwrap-panic (contract-call? TOOLKIT safe-add u100 u200))

## Performance tradeoff
- Extra contract call: ~100-150 gas units
- Benefit: No overflow/underflow vulnerabilities
- Recommendation: Always use toolkit in production
