# Stacks Clarity Toolkit

Essential utilities and helper functions for Clarity smart contract development.

[![Clarity](https://img.shields.io/badge/Clarity-Toolkit-purple)](https://clarity-lang.org/)
[![Stacks](https://img.shields.io/badge/Stacks-Blockchain-orange)](https://stacks.co/)
[![License](https://img.shields.io/badge/License-MIT-blue)](./LICENSE)
[![Mainnet](https://img.shields.io/badge/Network-Stacks%20Mainnet-green)](https://explorer.hiro.so/?chain=mainnet)

## 📦 Overview

A collection of reusable Clarity functions, testing utilities, and development tools to accelerate smart contract development on Stacks. Battle-tested in the [Base2Stacks](https://base2stacks-tracker.vercel.app) DeFi platform with 11 contracts deployed on mainnet.

## ✨ Features

### Core Utilities

* 🔢 **Math Operations** — Safe arithmetic with overflow protection
* 🔐 **Access Control** — Role-based permission helpers
* 💰 **Token Helpers** — Common token operations
* 📝 **Data Validation** — Input sanitization functions
* 🔄 **List Operations** — Advanced list manipulation
* 📊 **Math Libraries** — Fixed-point math, percentages

### Testing Tools

* 🧪 **Test Helpers** — Simplified assertion functions
* 📋 **Mock Data** — Pre-built test scenarios
* ⚡ **Gas Profiling** — Measure contract costs
* 🎯 **Coverage Tools** — Track test coverage

### Development Aids

* 📚 **Code Templates** — Common contract patterns
* 🔍 **Debug Utilities** — Enhanced logging
* 📖 **Documentation** — Inline examples
* 🎨 **Style Guide** — Best practices

## 🚀 Quick Start

### Installation

```bash
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
(define-map roles principal (string-ascii 20))

(define-public (add-role (user principal) (role (string-ascii 20)))
  (begin
    (asserts! (is-contract-owner) err-not-authorized)
    (ok (map-set roles user role))
  )
)

(define-read-only (has-role (user principal) (role (string-ascii 20)))
  (match (map-get? roles user)
    user-role (is-eq user-role role)
    false
  )
)
```

### 3. Token Helpers (`toolkit-tokens.clar`)

Common token operations.

```clarity
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
```

### 4. Data Validation (`toolkit-validation.clar`)

Input validation utilities.

```clarity
(define-read-only (is-valid-address (addr principal))
  (is-standard addr)
)

(define-read-only (is-in-range (value uint) (min uint) (max uint))
  (and (>= value min) (<= value max))
)

(define-read-only (is-non-zero (value uint))
  (> value u0)
)
```

### 5. List Operations (`toolkit-lists.clar`)

Advanced list manipulation.

```clarity
(define-read-only (sum-list (numbers (list 100 uint)))
  (fold + numbers u0)
)

(define-read-only (contains (item uint) (items (list 100 uint)))
  (is-some (index-of items item))
)
```

## 🧪 Testing Utilities

```clarity
(define-public (assert-eq (actual uint) (expected uint) (message (string-ascii 100)))
  (begin
    (asserts! (is-eq actual expected) (err message))
    (ok true)
  )
)
```

```typescript
// tests/helpers.ts
export const mockPrincipals = {
  deployer: 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM',
  wallet1: 'ST2CY5V39NHDPWSXMW9QDT3HC3GD6Q6XX4CFRK9AG',
  wallet2: 'ST2JHG361ZXG51QTKY2NQCVBPPRRE2KZB1HR05NNC',
};

export const mockAmounts = {
  small: 1000000,    // 1 token
  medium: 100000000, // 100 tokens
  large: 1000000000, // 1000 tokens
};
```

## 🛠️ Development

```bash
clarinet check   # Verify syntax
clarinet test    # Run tests
clarinet deploy --mainnet  # Deploy (requires STX)
```

## 🔗 Projects Using This Toolkit

| Repo | Description |
|---|---|
| [base2stacks-tracker](https://github.com/wkalidev/base2stacks-tracker) | Full DeFi platform — 11 contracts mainnet |
| [b2s-token-contract](https://github.com/wkalidev/b2s-token-contract) | All Clarity smart contracts |
| [b2s-nft-badges](https://github.com/wkalidev/b2s-nft-badges) | NFT badge generation — 567 assets |
| [b2s-analytics-dashboard](https://github.com/wkalidev/b2s-analytics-dashboard) | On-chain analytics |
| [b2s-staking-interface](https://github.com/wkalidev/b2s-staking-interface) | Staking UI |

## 🤝 Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md) — areas we need help with: more math functions, security utilities, testing tools, documentation.

## 📜 License

MIT License

---

**Built for #StacksBuilderRewards 🏆 — wkalidev(zcodebase)**

**Live platform: [base2stacks-tracker.vercel.app](https://base2stacks-tracker.vercel.app)**