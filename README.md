# @wkalidev/stacks-clarity-toolkit

> Reusable Clarity contracts & TypeScript utilities for Stacks smart contract development.

[![npm version](https://img.shields.io/npm/v/@wkalidev/stacks-clarity-toolkit?style=flat-square)](https://www.npmjs.com/package/@wkalidev/stacks-clarity-toolkit)
[![npm downloads](https://img.shields.io/npm/dw/@wkalidev/stacks-clarity-toolkit?style=flat-square)](https://www.npmjs.com/package/@wkalidev/stacks-clarity-toolkit)
[![CI](https://github.com/wkalidev/stacks-clarity-toolkit/actions/workflows/ci-clarity.yml/badge.svg)](https://github.com/wkalidev/stacks-clarity-toolkit/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square)](./LICENSE)
[![Stacks Mainnet](https://img.shields.io/badge/Network-Stacks%20Mainnet-5546FF?style=flat-square)](https://explorer.hiro.so)

---

## Why this toolkit?

If you're building on **Stacks**, you'll write the same helpers over and over — safe math, address validation, token transfers, role-based access. This toolkit gives you battle-tested TypeScript utilities and Clarity modules so you can focus on your product logic.

- ✅ **TypeScript-first** — full type definitions, ESM + CJS
- ✅ **Zero config** — works out of the box with `@stacks/transactions` v7
- ✅ **Clarity modules** — drop-in `.clar` contracts for common patterns
- ✅ **Tested** — every utility verified against mainnet behavior
- ✅ **Used in production** — powers [Base2Stacks DeFi](https://base2stacks-tracker.vercel.app)

---

## Installation

```bash
npm install @wkalidev/stacks-clarity-toolkit
# or
yarn add @wkalidev/stacks-clarity-toolkit
# or
pnpm add @wkalidev/stacks-clarity-toolkit
```

---

## TypeScript Utilities

### Math

```typescript
import { safeAdd, safeSub, safeMul, calcPercentage, clamp } from '@wkalidev/stacks-clarity-toolkit'

safeAdd(100n, 200n)              // → 300n
safeSub(500n, 200n)              // → 300n (throws if negative)
safeMul(100n, 3n)                // → 300n
calcPercentage(1_000_000n, 12.5) // → 125_000n
clamp(50n, 0n, 100n)             // → 50n
```

### Validation

```typescript
import { isValidStacksAddress, isValidTxId, isPositive } from '@wkalidev/stacks-clarity-toolkit'

isValidStacksAddress('SP1V72500C63KN9E348QDK9X879MASSTN0J3KBQ5N') // → true
isValidStacksAddress('0x1234...')                                    // → false
isValidTxId('0xabc123...')                                          // → true
isPositive(100n)                                                     // → true
```

### Token Helpers

```typescript
import { formatAmount, parseAmount, calculateFee, validateTransfer } from '@wkalidev/stacks-clarity-toolkit'

formatAmount(5_000_000n, 6)        // → "5.000000"
parseAmount("1.5", 6)              // → 1_500_000n
calculateFee(1_000_000n, 30)       // → { net: 997_000n, fee: 3_000n }
validateTransfer(100n, 'SP1...', 'SP2...') // throws if invalid
```

### Block Utilities

```typescript
import { blocksToDays, daysToBlocks, estimateBlockTime } from '@wkalidev/stacks-clarity-toolkit'

blocksToDays(144)        // → 1
daysToBlocks(7)          // → 1008
estimateBlockTime(100)   // → "~16h 40m"
```

### Access & Encoding

```typescript
import { encodeAscii, decodeAscii, toHex } from '@wkalidev/stacks-clarity-toolkit'

encodeAscii('hello')  // → Uint8Array
toHex(buffer)         // → "68656c6c6f"
```

### Testing Helpers

```typescript
import { assertEq, assertOk, assertErr, MOCK_PRINCIPALS, MOCK_AMOUNTS } from '@wkalidev/stacks-clarity-toolkit'

assertEq(result, expected, 'should match')
assertOk(contractResult)   // throws if { ok: false }
assertErr(contractResult)  // throws if { ok: true }

MOCK_PRINCIPALS.deployer   // → 'SP1V72500C63KN9E348QDK9X879MASSTN0J3KBQ5N'
MOCK_AMOUNTS.small         // → 1_000_000n (1 token)
```

---

## Clarity Modules

Drop these into your Clarinet project:

| Module | Description |
|--------|-------------|
| `toolkit-math.clar` | Safe arithmetic with overflow protection |
| `toolkit-tokens.clar` | Safe SIP-010 transfer helpers |

### Example — toolkit-math.clar

```clarity
(contract-call? .toolkit-math safe-add u100 u200)   ;; → (ok u300)
(contract-call? .toolkit-math safe-div u100 u0)     ;; → (err u1) division by zero
(contract-call? .toolkit-math basis-points u1000 u30) ;; → (ok u3) = 0.3%
```

---

## Development

```bash
git clone https://github.com/wkalidev/stacks-clarity-toolkit.git
cd stacks-clarity-toolkit
npm install
npm run build
clarinet check
clarinet test
```

---

## Related Repos

| Repo / Package | Description |
|----------------|-------------|
| [base2stacks-tracker](https://github.com/wkalidev/base2stacks-tracker) | Main DeFi platform — [live app](https://base2stacks-tracker.vercel.app) |
| [b2s-token-contract](https://github.com/wkalidev/b2s-token-contract) | $B2S SDK & contract addresses — [@wkalidev/b2s-contracts](https://www.npmjs.com/package/@wkalidev/b2s-contracts) |
| [b2s-analytics-dashboard](https://github.com/wkalidev/b2s-analytics-dashboard) | Analytics dashboard components |
| [b2s-staking-interface](https://github.com/wkalidev/b2s-staking-interface) | Staking UI components |
| [b2s-nft-badges](https://github.com/wkalidev/b2s-nft-badges) | 567 NFT badge assets and hooks |

---

## Live App

**[base2stacks-tracker.vercel.app](https://base2stacks-tracker.vercel.app)** — DeFi platform built with this toolkit on Stacks mainnet.

---

## Contributing

PRs welcome! See [CONTRIBUTING.md](./CONTRIBUTING.md)

## License

MIT — © 2026 [wkalidev](https://github.com/wkalidev)

---

**Built for [#StacksBuilderRewards](https://stacks.org) May 2026 🏆**