# Deployment Guide

## Mainnet
Contract: SP936YWJPST8GB8FFRCN7CC6P2YR5K6NNBAARQ96.toolkit-math

## Deploy your own instance
clarinet deploy --mainnet

## Verify deployment
clarinet check contracts/toolkit-math.clar

## Test after deployment
(contract-call? .toolkit-math safe-add u1 u1)
;; Expected: (ok u2)
