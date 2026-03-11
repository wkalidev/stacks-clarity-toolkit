// Stacks Clarity Toolkit - Constants

export const TOOLKIT_CONTRACT_ADDRESS = 'SP936YWJPST8GB8FFRCN7CC6P2YR5K6NNBAARQ96';

export const CONTRACTS = {
  math:       `${TOOLKIT_CONTRACT_ADDRESS}.toolkit-math`,
  tokens:     `${TOOLKIT_CONTRACT_ADDRESS}.toolkit-tokens`,
  access:     `${TOOLKIT_CONTRACT_ADDRESS}.toolkit-access`,
  validation: `${TOOLKIT_CONTRACT_ADDRESS}.toolkit-validation`,
  lists:      `${TOOLKIT_CONTRACT_ADDRESS}.toolkit-lists`,
} as const;

export const ERRORS = {
  OVERFLOW:          100,
  DIVIDE_BY_ZERO:    101,
  UNDERFLOW:         102,
  INVALID_AMOUNT:    200,
  LENGTH_MISMATCH:   201,
  INSUFFICIENT_BAL:  202,
  SELF_TRANSFER:     203,
  NOT_AUTHORIZED:    10,
} as const;

export const MOCK_PRINCIPALS = {
  deployer: 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM',
  wallet1:  'ST2CY5V39NHDPWSXMW9QDT3HC3GD6Q6XX4CFRK9AG',
  wallet2:  'ST2JHG361ZXG51QTKY2NQCVBPPRRE2KZB1HR05NNC',
} as const;

export const MOCK_AMOUNTS = {
  small:  1_000_000,      // 1 token
  medium: 100_000_000,    // 100 tokens
  large:  1_000_000_000,  // 1000 tokens
} as const;