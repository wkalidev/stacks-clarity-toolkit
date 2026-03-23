# Integration Checklist

## Before using toolkit
- [ ] Deploy toolkit to same network (mainnet/testnet)
- [ ] Add TOOLKIT constant to your contract
- [ ] Import toolkit address correctly

## Replace all raw arithmetic
- [ ] Replace + with safe-add
- [ ] Replace - with safe-sub
- [ ] Replace * with safe-mul
- [ ] Replace / with safe-div
- [ ] Use basis-points for percentage calculations

## Error handling
- [ ] Handle (err ...) returns from toolkit
- [ ] Define error constants for math failures
- [ ] Use unwrap! not unwrap-panic

## Testing
- [ ] Test with boundary values (0, max-uint)
- [ ] Test overflow scenarios
- [ ] Test underflow scenarios
