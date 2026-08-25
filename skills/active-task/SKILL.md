---
name: active-task
description: Drive work from an ACTIVE_TASK.md plan file - clarify, plan, implement, track. Use only when invoked explicitly.
---

Requires `ACTIVE_TASK.md` in repo root. Missing → say so and stop.

Apply `/ponytail` to every solution. Write plan prose through `/caveman` — file paths, code symbols, commands stay verbatim.

User said 'continue' → plan already written in `ACTIVE_TASK.md`. Resume implementation from step 5. Else full process:

1. Read `ACTIVE_TASK.md`.
   - Has plan with unchecked tasks → summarize remaining, ask resume or replan.
   - Task description only → continue to 2.
2. Task ambiguous → `/grill-me` until decisions resolved. Clear → skip.
3. Plan tests refer to `/write-tests` skill
4. Write agreed plan back to `ACTIVE_TASK.md`: goal line + `- [ ]` subtasks, caveman prose. Each subtask must stay unambiguous — drop caveman for any step where order or condition could misread.
5. Ask confirmation before implementing.
6. Implement one subtask at a time. Check its box in `ACTIVE_TASK.md` right after it passes. Document must be in ready-to-handover state for another agent at all times.
7. After completion is confirmed, clear `ACTIVE_TASK.md`.
