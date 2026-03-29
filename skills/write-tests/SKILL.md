---
name: write-tests
description: Use when user asks to write tests - integration, unit, visual, e2e.
---

# Philosophy

- **Core principle**: Tests should verify behavior through public interfaces, not implementation details. Code can change entirely; tests shouldn't.
- **Bad tests** are coupled to implementation. They mock internal collaborators, test private methods, or verify through external means (like querying a database directly instead of using the interface).
- **Too many tests**: focus on writing absolutely necessary tests, do not over-test, do not cover edge cases that type system is verifying
- **Appropriate testing layer**: select the lowest testing layer that still allows for a proper test coverage, if unsure what layer to use ask the user. Testing layers: unit -> integration -> visual -> e2e.

# Workflow

## Review

Check existing coverage, and make sure that code is not covered by existing tests before proceiding.

## Planning

Give a detailed plan on what tests you are about to write, and confirm with the user. Format:

- Describe: text of a describe block
  - should do this ...
  - should do that ...

## Implementation

Implement tests that were approved by the user.

## Verification

Run tests and make sure they are passing. In case of failure iterate on broken tests fixing issues.
