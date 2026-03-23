# Detailed Changelog

## v1.1.0 (March 2026)
### Added
- basis-points: Calculate percentages safely
- Used in b2s-fee-router for dynamic fee tiers
- Used in b2s-staking-vault-v2 for APY calculation

### Changed
- Improved error messages for safe-div

### Fixed
- Edge case in safe-mul with zero values

## v1.0.0 (February 2026)
### Added
- safe-add: Overflow-protected addition
- safe-sub: Underflow-protected subtraction
- safe-mul: Overflow-protected multiplication
- safe-div: Division with zero-check
- Initial deployment on Stacks mainnet
