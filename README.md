# Stacks Clarity Toolkit

Reusable Clarity contracts and TypeScript utilities for Stacks smart contract development.

[![CI](https://github.com/wkalidev/stacks-clarity-toolkit/actions/workflows/ci-clarity.yml/badge.svg)](https://github.com/wkalidev/stacks-clarity-toolkit/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](./LICENSE)

## Installation
```bash
npm install @wkalidev/stacks-clarity-toolkit
```

## Clarity Modules

- `toolkit-math.clar` — Safe arithmetic with overflow protection
- `toolkit-access.clar` — Role-based permissions
- `toolkit-tokens.clar` — Safe transfer helpers
- `toolkit-validation.clar` — Input validation

## TypeScript API
```typescript
import { safeAdd, calcPercentage, isValidStacksAddress } from '@wkalidev/stacks-clarity-toolkit'

safeAdd(100n, 200n)           // 300n
calcPercentage(1000n, 12.5)   // 125n
isValidStacksAddress('SP...') // true
```

## Development
```bash
clarinet check && clarinet test
npm install && npm run build
```

## License

MIT — Built for #StacksBuilderRewards March 2026 🏆
