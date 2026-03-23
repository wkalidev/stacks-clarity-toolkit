# Common Clarity Patterns with Toolkit

## Safe fee deduction
(let (
  (fee (unwrap! (contract-call? TOOLKIT basis-points amount u250) ERR-MATH))
  (net (unwrap! (contract-call? TOOLKIT safe-sub amount fee) ERR-MATH))
)
  (try! (ft-transfer? token net sender recipient))
  (try! (ft-transfer? token fee sender treasury))
  (ok net)
)

## Safe reward distribution
(let (
  (total    (unwrap! (contract-call? TOOLKIT safe-mul rate blocks) ERR-MATH))
  (reward   (unwrap! (contract-call? TOOLKIT safe-div total u52560) ERR-MATH))
)
  (ft-mint? token reward recipient)
)
