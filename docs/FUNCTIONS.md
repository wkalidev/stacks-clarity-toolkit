# 📖 Function Documentation

Complete reference for all Stacks Clarity Toolkit functions.

---

## toolkit-math.clar

### Error Codes
| Code | Constant | Description |
|------|----------|-------------|
| `u100` | `err-overflow` | Arithmetic overflow |
| `u101` | `err-divide-by-zero` | Division by zero |
| `u102` | `err-underflow` | Arithmetic underflow |

---

### `safe-add`
```clarity
(define-read-only (safe-add (a uint) (b uint)) (response uint uint))
```
Safe addition with overflow protection.
- **Returns**: `(ok uint)` or `(err u100)` on overflow
- **Example**: `(safe-add u100 u50)` → `(ok u150)`

### `safe-sub`
```clarity
(define-read-only (safe-sub (a uint) (b uint)) (response uint uint))
```
Safe subtraction, prevents underflow.
- **Returns**: `(ok uint)` or `(err u102)` if b > a
- **Example**: `(safe-sub u100 u30)` → `(ok u70)`

### `safe-mul`
```clarity
(define-read-only (safe-mul (a uint) (b uint)) (response uint uint))
```
Safe multiplication with overflow check. Returns `(ok u0)` if a = 0.
- **Returns**: `(ok uint)` or `(err u100)` on overflow

### `safe-div`
```clarity
(define-read-only (safe-div (a uint) (b uint)) (response uint uint))
```
Safe division, prevents divide-by-zero.
- **Returns**: `(ok uint)` or `(err u101)` if b = 0

### `percentage`
```clarity
(define-read-only (percentage (amount uint) (percent uint)) (response uint uint))
```
Calculates `amount * percent / 100`.
- **Example**: `(percentage u1000 u5)` → `(ok u50)`

### `basis-points`
```clarity
(define-read-only (basis-points (amount uint) (bps uint)) (response uint uint))
```
Calculates `amount * bps / 10000`. Useful for fee calculations (1 bps = 0.01%).
- **Example**: `(basis-points u10000 u30)` → `(ok u30)` (0.3% fee)

### `min`
```clarity
(define-read-only (min (a uint) (b uint)) uint)
```
Returns the smaller of two values.

### `max`
```clarity
(define-read-only (max (a uint) (b uint)) uint)
```
Returns the larger of two values.

### `abs-diff`
```clarity
(define-read-only (abs-diff (a uint) (b uint)) (response uint uint))
```
Returns the absolute difference `|a - b|`.
- **Example**: `(abs-diff u10 u15)` → `(ok u5)`

### `pow`
```clarity
(define-read-only (pow (base uint) (exponent uint)) (response uint uint))
```
Raises `base` to the power of `exponent` using fast exponentiation.
- **Returns**: `(ok u1)` if exponent = 0
- **Example**: `(pow u2 u10)` → `(ok u1024)`

### `average`
```clarity
(define-read-only (average (a uint) (b uint)) (response uint uint))
```
Returns `(a + b) / 2`.
- **Example**: `(average u10 u20)` → `(ok u15)`

### `is-even`
```clarity
(define-read-only (is-even (n uint)) bool)
```
Returns `true` if n is even.

### `is-odd`
```clarity
(define-read-only (is-odd (n uint)) bool)
```
Returns `true` if n is odd.

### `clamp`
```clarity
(define-read-only (clamp (value uint) (min-val uint) (max-val uint)) (response uint uint))
```
Clamps value between min-val and max-val.
- **Example**: `(clamp u150 u0 u100)` → `(ok u100)`

### `lerp`
```clarity
(define-read-only (lerp (a uint) (b uint) (t uint)) (response uint uint))
```
Linear interpolation between a and b. `t` is in range [0, 100] (represents 0% to 100%).
- **Returns**: `(err u100)` if t > 100
- **Example**: `(lerp u0 u100 u50)` → `(ok u50)` (midpoint)

### `arithmetic-sum`
```clarity
(define-read-only (arithmetic-sum (first uint) (last uint) (n uint)) (response uint uint))
```
Sum of arithmetic sequence: `n * (first + last) / 2`.
- **Example**: `(arithmetic-sum u1 u10 u10)` → `(ok u55)`

---

## toolkit-tokens.clar

### Error Codes
| Code | Constant | Description |
|------|----------|-------------|
| `u200` | `err-invalid-amount` | Amount is zero |
| `u201` | `err-length-mismatch` | Recipient/amount lists differ |
| `u202` | `err-insufficient-balance` | Sender balance too low |
| `u203` | `err-self-transfer` | Sender = recipient |

### `safe-transfer`
```clarity
(define-public (safe-transfer
  (amount uint)
  (sender principal)
  (recipient principal)
  (token-contract <ft-trait>)) (response bool uint))
```
Validates amount > 0 and sender ≠ recipient before transferring.

### `batch-transfer`
```clarity
(define-public (batch-transfer
  (recipients (list 50 principal))
  (amounts (list 50 uint))
  (token-contract <ft-trait>)) (response bool uint))
```
Transfers tokens to multiple recipients in one call. Lists must be equal length.

### `get-balance-safe`
```clarity
(define-read-only (get-balance-safe
  (who principal)
  (token-contract <ft-trait>)) (response uint uint))
```
Returns token balance, defaults to `u0` if not found.

### `has-balance`
```clarity
(define-read-only (has-balance
  (who principal)
  (amount uint)
  (token-contract <ft-trait>)) (response bool uint))
```
Returns `(ok true)` if `who` holds at least `amount` tokens.

---

## toolkit-access.clar

### `add-role` / `remove-role` / `has-role` / `is-admin`
See README for full signatures. Roles are `(string-ascii 20)` — e.g. `"admin"`, `"minter"`, `"pauser"`.

---

## toolkit-validation.clar

### `is-valid-address` / `is-in-range` / `is-valid-length` / `is-non-zero`
See README for full signatures.

---

## toolkit-lists.clar

### `sum-list` / `contains`
See README for full signatures.

---

**Last Updated**: March 11, 2026