---
name: after-implementation
description: Final sanity check on own work before calling task complete. Use when implementation done and user asks to sanity-check, self-review, or "am I done".
---

Audit own work. Blunt. No praise, no summary of what code does.

# Scope

Branch diff vs base + untracked files. Read the changes, not memory of them.

# Checks

## Placement

Each change — right file, right layer? Existing code already do this job? Better home → name it.

## Blast radius

Rank changes by damage if wrong. Top 3 only. Each one:

- Assumption made
- How user find out assumption wrong — test, log, error, broken flow

## Scope creep

Everything changed that user not ask for. None → say none.

## Regret

What do differently. Concrete alternative, not vague wish.

# Output

Findings only. Section clean → one line. No fix without user say so.
