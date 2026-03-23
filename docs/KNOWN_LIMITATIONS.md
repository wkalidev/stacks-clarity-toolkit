# Known Limitations

## No Float Support
Clarity only supports unsigned integers.
Use micro-units (multiply by 10^6) for decimals.

## No Negative Numbers
All values must be non-negative.
For signed math, use two separate variables.

## Gas Overhead
Each toolkit call adds ~100-200 gas units.
Acceptable for security benefits.

## Max Value
MAX_UINT = 340282366920938463463374607431768211455
Plan your math to stay within this range.

## No Square Root
sqrt-newton was removed due to recursion restriction.
Use fixed-iteration approximation instead.
