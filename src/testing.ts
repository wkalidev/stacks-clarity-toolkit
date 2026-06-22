/**
 * Testing utilities for Clarity contract development
 * Mock data, assertion helpers, and test principals
 */

export const MOCK_PRINCIPALS = {
  deployer: 'SP1V72500C63KN9E348QDK9X879MASSTN0J3KBQ5N',
  wallet1:  'SP1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM',
  wallet2:  'SP2CY5V39NHDPWSXMW9QDT3HC3GD6Q6XX4CFRK9AG',
  wallet3:  'SP2JHG361ZXG51QTKY2NQCVBPPRRE2KZB1HR05NNC',
  wallet4:  'SP3FBR2AGK5H9QBDH3EEN6DF8EK8JY7RX8QJ5SVTE',
} as const

export const MOCK_AMOUNTS = {
  dust:   1n,
  small:  1_000_000n,        // 1 B2S
  medium: 100_000_000n,      // 100 B2S
  large:  1_000_000_000n,    // 1000 B2S
  whale:  100_000_000_000n,  // 100,000 B2S
} as const

export function assertEq<T>(actual: T, expected: T, msg?: string): void {
  if (actual !== expected)
    throw new Error(`${msg ?? 'Assertion failed'}: expected ${expected}, got ${actual}`)
}

export function assertGt(actual: bigint, expected: bigint, msg?: string): void {
  if (actual <= expected)
    throw new Error(`${msg ?? 'Assertion failed'}: expected ${actual} > ${expected}`)
}

export function assertOk<T>(result: { ok: boolean; value?: T; error?: unknown }, msg?: string): T {
  if (!result.ok) throw new Error(`${msg ?? 'Expected ok result'}: ${result.error}`)
  return result.value as T
}

export function assertErr(result: { ok: boolean }, msg?: string): void {
  if (result.ok) throw new Error(msg ?? 'Expected error result but got ok')
}

export function mockBlock(height: number) {
  return { height, time: Date.now() }
}
