---
name: write-tests
description: Use when user asks to write tests - integration, unit, visual, e2e.
---

Load /ponytail skill.

# Philosophy

- **Core principle**: Test behavior through public interfaces, not implementation details. Code can change entirely; tests shouldn't.
- **Bad tests** couple to implementation: mock internal collaborators, test private methods, or verify by external means (querying DB directly instead of through the interface).
- **Too many tests**: write only necessary tests. No over-testing. Skip edge cases the type system already guarantees.
- **Testing layer**: pick lowest layer that still gives proper coverage. Layers: unit → integration → visual → e2e. Unsure → ask user.

# Workflow

## Review

Check existing coverage. Code already covered → say so, stop before writing duplicates.

## Planning

Detailed plan of tests to write, confirm with user. Format:

- Describe: text of a describe block
  - should do this ...
  - should do that ...

## Implementation

Implement approved tests only.

## Verification

Run tests. Failing → iterate on broken tests until green.
