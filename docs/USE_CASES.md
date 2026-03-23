# Real-World Use Cases

## DeFi AMM (b2s-liquidity-pool-v5)
- safe-mul for k = x * y calculation
- safe-div for price calculation
- safe-sub for reserve updates

## Staking Vault (b2s-staking-vault-v2)
- safe-add for accumulating stakes
- safe-mul for APY calculation
- basis-points for multiplier application

## Fee Router (b2s-fee-router)
- basis-points for fee calculation
- safe-sub for net amount after fee

## Rewards Distributor (b2s-rewards-distributor-v3)
- safe-mul for reward rate * elapsed blocks
- safe-div for per-block reward calculation
- safe-add for total rewards accumulation
