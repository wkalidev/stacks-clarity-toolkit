# Stacks Clarity Toolkit

Essential utilities and helper functions for Clarity smart contract development.

[![Clarity](https://img.shields.io/badge/Clarity-Toolkit-purple)](https://clarity-lang.org/)
[![Stacks](https://img.shields.io/badge/Stacks-Blockchain-orange)](https://stacks.co/)

## 📦 Overview

A collection of reusable Clarity functions, testing utilities, and development tools to accelerate smart contract development on Stacks.

## ✨ Features

### Core Utilities
- 🔢 **Math Operations** - Safe arithmetic with overflow protection
- 🔐 **Access Control** - Role-based permission helpers
- 💰 **Token Helpers** - Common token operations
- 📝 **Data Validation** - Input sanitization functions
- 🔄 **List Operations** - Advanced list manipulation
- 📊 **Math Libraries** - Fixed-point math, percentages

### Testing Tools
- 🧪 **Test Helpers** - Simplified assertion functions
- 📋 **Mock Data** - Pre-built test scenarios
- ⚡ **Gas Profiling** - Measure contract costs
- 🎯 **Coverage Tools** - Track test coverage

### Development Aids
- 📚 **Code Templates** - Common contract patterns
- 🔍 **Debug Utilities** - Enhanced logging
- 📖 **Documentation** - Inline examples
- 🎨 **Style Guide** - Best practices

## 🚀 Quick Start

### Installation

Add to your Clarinet project:
```bash
# Clone into your project
git clone https://github.com/wkalidev/stacks-clarity-toolkit.git libs/toolkit
```

### Import in Your Contract
```clarity
;; Import math utilities
(use-trait math-trait .toolkit-math.math-operations)

;; Use safe addition
(define-public (safe-add (a uint) (b uint))
  (contract-call? .toolkit-math safe-add a b)
)
```

## 📚 Modules

### 1. Math Operations (`toolkit-math.clar`)

Safe arithmetic operations with overflow protection.
```clarity
;; Safe addition
(define-read-only (safe-add (a uint) (b uint))
  (let ((result (+ a b)))
    (asserts! (>= result a) err-overflow)
    (ok result)
  )
)

;; Safe multiplication
(define-read-only (safe-mul (a uint) (b uint))
  (if (is-eq a u0)
    (ok u0)
    (let ((result (* a b)))
      (asserts! (is-eq (/ result a) b) err-overflow)
      (ok result)
    )
  )
)

;; Calculate percentage
(define-read-only (percentage (amount uint) (percent uint))
  (ok (/ (* amount percent) u100))
)

;; Min/Max
(define-read-only (min (a uint) (b uint))
  (if (<= a b) a b)
)

(define-read-only (max (a uint) (b uint))
  (if (>= a b) a b)
)
```

### 2. Access Control (`toolkit-access.clar`)

Role-based permission system.
```clarity
;; Define roles map
(define-map roles principal (string-ascii 20))

;; Add role
(define-public (add-role (user principal) (role (string-ascii 20)))
  (begin
    (asserts! (is-contract-owner) err-not-authorized)
    (ok (map-set roles user role))
  )
)

;; Check role
(define-read-only (has-role (user principal) (role (string-ascii 20)))
  (match (map-get? roles user)
    user-role (is-eq user-role role)
    false
  )
)

;; Admin check
(define-read-only (is-admin (user principal))
  (has-role user "admin")
)
```

### 3. Token Helpers (`toolkit-tokens.clar`)

Common token operations.
```clarity
;; Transfer tokens safely
(define-public (safe-transfer 
  (amount uint) 
  (sender principal) 
  (recipient principal)
  (token-contract <ft-trait>))
  (begin
    (asserts! (> amount u0) err-invalid-amount)
    (contract-call? token-contract transfer amount sender recipient none)
  )
)

;; Batch transfer
(define-public (batch-transfer 
  (recipients (list 50 principal)) 
  (amounts (list 50 uint))
  (token-contract <ft-trait>))
  (begin
    (asserts! (is-eq (len recipients) (len amounts)) err-length-mismatch)
    ;; Implementation here
    (ok true)
  )
)
```

### 4. Data Validation (`toolkit-validation.clar`)

Input validation utilities.
```clarity
;; Validate address
(define-read-only (is-valid-address (addr principal))
  (is-standard addr)
)

;; Validate amount range
(define-read-only (is-in-range (value uint) (min uint) (max uint))
  (and (>= value min) (<= value max))
)

;; Validate string length
(define-read-only (is-valid-length (str (string-ascii 100)) (max-len uint))
  (<= (len str) max-len)
)

;; Check non-zero
(define-read-only (is-non-zero (value uint))
  (> value u0)
)
```

### 5. List Operations (`toolkit-lists.clar`)

Advanced list manipulation.
```clarity
;; Sum list
(define-read-only (sum-list (numbers (list 100 uint)))
  (fold + numbers u0)
)

;; Find in list
(define-read-only (contains (item uint) (items (list 100 uint)))
  (is-some (index-of items item))
)

;; Filter list (helper)
(define-private (filter-helper 
  (item uint) 
  (state {pred: (uint -> bool), result: (list 100 uint)}))
  ;; Implementation
  state
)
```

## 🧪 Testing Utilities

### Test Helpers
```clarity
;; Assert equals
(define-public (assert-eq (actual uint) (expected uint) (message (string-ascii 100)))
  (begin
    (asserts! (is-eq actual expected) (err message))
    (ok true)
  )
)

;; Assert greater than
(define-public (assert-gt (actual uint) (expected uint) (message (string-ascii 100)))
  (begin
    (asserts! (> actual expected) (err message))
    (ok true)
  )
)
```

### Mock Data
```typescript
// In tests/helpers.ts
export const mockPrincipals = {
  deployer: 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM',
  wallet1: 'ST2CY5V39NHDPWSXMW9QDT3HC3GD6Q6XX4CFRK9AG',
  wallet2: 'ST2JHG361ZXG51QTKY2NQCVBPPRRE2KZB1HR05NNC',
};

export const mockAmounts = {
  small: 1000000, // 1 token
  medium: 100000000, // 100 tokens
  large: 1000000000, // 1000 tokens
};
```

## 📖 Usage Examples

### Safe Math in Token Contract
```clarity
(define-public (transfer-with-fee (amount uint) (recipient principal))
  (let (
    (fee-amount (unwrap! (contract-call? .toolkit-math percentage amount u5) err-calculation))
    (transfer-amount (unwrap! (contract-call? .toolkit-math safe-sub amount fee-amount) err-calculation))
  )
    ;; Transfer logic
    (ok true)
  )
)
```

### Access Control in Admin Functions
```clarity
(define-public (admin-function)
  (begin
    (asserts! (contract-call? .toolkit-access is-admin tx-sender) err-not-authorized)
    ;; Admin logic
    (ok true)
  )
)
```

### Input Validation
```clarity
(define-public (create-proposal (title (string-ascii 100)) (amount uint))
  (begin
    (asserts! (contract-call? .toolkit-validation is-valid-length title u100) err-invalid-title)
    (asserts! (contract-call? .toolkit-validation is-in-range amount u1 u1000000) err-invalid-amount)
    ;; Create proposal
    (ok true)
  )
)
```

## 🛠️ Development
```bash
# Check contracts
clarinet check

# Run tests
clarinet test

# Deploy
clarinet deploy --testnet
```

## 📚 Documentation

Each module includes:
- ✅ Function signatures
- ✅ Parameter descriptions
- ✅ Return types
- ✅ Error codes
- ✅ Usage examples
- ✅ Gas cost estimates

## 🤝 Contributing

We welcome contributions! Areas we need help with:
- 🔢 More math functions
- 🔐 Security utilities
- 🧪 Testing tools
- 📖 Documentation
- 💡 Feature ideas

See [CONTRIBUTING.md](../base2stacks-tracker/CONTRIBUTING.md)

## 🔗 Projects Using This Toolkit

- [Base2Stacks Tracker](https://github.com/wkalidev/base2stacks-tracker)
- [B2S Token Contract](https://github.com/wkalidev/b2s-token-contract)
- [B2S NFT Badges](https://github.com/wkalidev/b2s-nft-badges)

## 📜 License

MIT License

## 🏆 Credits

Built for the Stacks community by wkalidev (zcodebase)

---

**Built for #StacksBuilderRewards 🏆**

**Make Clarity development easier! 🛠️**