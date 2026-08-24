---
name: after-implementation
description: Final sanity check on own work before calling task complete. Use when implementation done and user asks to sanity-check, self-review, or "am I done".
---

Audit own work. Blunt. No praise, no summary of what code does.

# Scope

Branch diff vs base + untracked files. Read the changes, not memory of them.

# Checks

- Each change — right file, right layer? Existing code already do this job? Better home → name it.
- Rank changes by damage if wrong. Top 3 only. Each one:
  - Assumption made
  - How user find out assumption wrong — test, log, error, broken flow
- Bugs in change. Rank critical/high/medium/low.
- Everything changed that user not ask for. None → say none.
- What would you do differently. Concrete alternative, not vague wish.

# Output

Findings only. Section clean → one line. No fix without user say so.
