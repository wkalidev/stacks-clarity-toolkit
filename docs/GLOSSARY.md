# Glossary

## Basis Points (bps)
1 bps = 0.01%. 100 bps = 1%. 10000 bps = 100%.
Used for precise percentage calculations without decimals.

## Overflow
When a number exceeds MAX_UINT, it wraps around to 0.
safe-mul and safe-add prevent this.

## Underflow
When subtracting a larger number from a smaller one.
safe-sub returns an error instead of wrapping.

## uint
Unsigned integer. Range: 0 to 2^128-1.
All Clarity math uses uints.

## unwrap!
Extracts value from (ok ...) or returns error.
Safer than unwrap-panic for production code.
