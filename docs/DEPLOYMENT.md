# Deployment Guide

## Mainnet
Contract: SP1V72500C63KN9E348QDK9X879MASSTN0J3KBQ5N.toolkit-math

## Deploy your own instance
clarinet deploy --mainnet

## Verify deployment
clarinet check contracts/toolkit-math.clar

## Test after deployment
(contract-call? .toolkit-math safe-add u1 u1)
;; Expected: (ok u2)
