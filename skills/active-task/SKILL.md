---
name: active-task
description: Drive work from an ACTIVE_TASK.md plan file - clarify, plan, implement, track. Use only when invoked explicitly.
---

Requires `ACTIVE_TASK.md` in repo root. Missing → say so and stop.

Apply `/ponytail` to every solution. Write plan prose through `/caveman` — file paths, code symbols, commands stay verbatim.

1. Read `ACTIVE_TASK.md`.
   - Has plan with unchecked tasks → summarize remaining, ask resume or replan.
   - Task description only → continue to 2.
2. Task ambiguous → `/grill-me` until decisions resolved. Clear → skip.
3. Write agreed plan back to `ACTIVE_TASK.md`: goal line + `- [ ]` subtasks, caveman prose. Each subtask must stay unambiguous — drop caveman for any step where order or condition could misread.
4. Ask confirmation before implementing.
5. Implement one subtask at a time. Check its box in `ACTIVE_TASK.md` right after it passes. Document must be in ready-to-handover state for another agent at all times.
6. All boxes checked → report result, suggest `/simplify` or `/code-review`.
7. After completion is confirmed, clear `ACTIVE_TASK.md`.
