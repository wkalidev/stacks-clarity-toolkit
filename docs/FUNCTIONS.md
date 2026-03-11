# 📖 Function Documentation

Complete reference for all Stacks Clarity Toolkit functions.

---

## toolkit-math.clar

### `safe-add`
```clarity
(define-read-only (safe-add (a uint) (b uint)) (response uint uint))
```
Safe addition with overflow protection.
- **Params**: `a` uint, `b` uint
- **Returns**: `(ok uint)` or `(err u1)` on overflow
- **Gas**: ~150

### `safe-sub`
```clarity
(define-read-only (safe-sub (a uint) (b uint)) (response uint uint))
```
Safe subtraction, prevents underflow.
- **Returns**: `(ok uint)` or `(err u2)` if b > a

### `safe-mul`
```clarity
(define-read-only (safe-mul (a uint) (b uint)) (response uint uint))
```
Safe multiplication with overflow check.
- **Returns**: `(ok uint)` or `(err u1)` on overflow

### `percentage`
```clarity
(define-read-only (percentage (amount uint) (percent uint)) (response uint uint))
```
Calculates `amount * percent / 100`.
- **Example**: `(percentage u1000 u5)` → `(ok u50)`

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

---

## toolkit-access.clar

### `add-role`
```clarity
(define-public (add-role (user principal) (role (string-ascii 20))) (response bool uint))
```
Assigns a role to a principal. Contract owner only.
- **Roles**: `"admin"`, `"minter"`, `"pauser"`, or custom

### `remove-role`
```clarity
(define-public (remove-role (user principal)) (response bool uint))
```
Removes all roles from a principal.

### `has-role`
```clarity
(define-read-only (has-role (user principal) (role (string-ascii 20))) bool)
```
Checks if a principal has a specific role.

### `is-admin`
```clarity
(define-read-only (is-admin (user principal)) bool)
```
Shorthand check for `"admin"` role.

---

## toolkit-tokens.clar

### `safe-transfer`
```clarity
(define-public (safe-transfer
  (amount uint)
  (sender principal)
  (recipient principal)
  (token-contract <ft-trait>)) (response bool uint))
```
Validates amount > 0 before transferring.
- **Errors**: `err-invalid-amount (u100)` if amount is 0

### `batch-transfer`
```clarity
(define-public (batch-transfer
  (recipients (list 50 principal))
  (amounts (list 50 uint))
  (token-contract <ft-trait>)) (response bool uint))
```
Transfers tokens to multiple recipients in one call.
- **Errors**: `err-length-mismatch (u101)` if lists differ in length

---

## toolkit-validation.clar

### `is-valid-address`
```clarity
(define-read-only (is-valid-address (addr principal)) bool)
```
Returns `true` if the principal is a standard address (not a contract).

### `is-in-range`
```clarity
(define-read-only (is-in-range (value uint) (min uint) (max uint)) bool)
```
Returns `true` if `min <= value <= max`.

### `is-valid-length`
```clarity
(define-read-only (is-valid-length (str (string-ascii 100)) (max-len uint)) bool)
```
Returns `true` if string length ≤ max-len.

### `is-non-zero`
```clarity
(define-read-only (is-non-zero (value uint)) bool)
```
Returns `true` if value > 0.

---

## toolkit-lists.clar

### `sum-list`
```clarity
(define-read-only (sum-list (numbers (list 100 uint))) uint)
```
Returns the sum of all elements.
- **Example**: `(sum-list (list u1 u2 u3))` → `u6`

### `contains`
```clarity
(define-read-only (contains (item uint) (items (list 100 uint))) bool)
```
Returns `true` if item is present in the list.

---

## Error Codes

| Code | Constant | Description |
|------|----------|-------------|
| `u1` | `err-overflow` | Arithmetic overflow |
| `u2` | `err-underflow` | Arithmetic underflow |
| `u10` | `err-not-authorized` | Caller lacks permission |
| `u100` | `err-invalid-amount` | Amount is zero or invalid |
| `u101` | `err-length-mismatch` | List lengths don't match |

---

**Last Updated**: March 11, 2026