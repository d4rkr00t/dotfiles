---
name: active-task
description: Drive work from a per-task plan file in `.active-tasks/` - clarify, plan, implement, track. Use only when invoked explicitly.
---

Task file: `.active-tasks/<slug>.md` in repo root. Resolve `<slug>` once, at start:
1. Arg given (`/active-task <slug>`, `continue <slug>`) → use it.
2. Else `git branch --show-current`, `/` → `-`, unless `main`/`master`.
3. Else list `.active-tasks/*.md`, ask user to pick one or name new.

Missing → create from user request. Tell user resolved path before any work. Touch only own task file — never edit other files in `.active-tasks/`.

Apply `/ponytail` to every solution. Write plan prose through `/caveman` — file paths, code symbols, commands stay verbatim.

User said 'continue' → plan already in task file. Resume from step 5. Else full process:

1. Read task file.
   - Has plan with unchecked tasks → summarize remaining, ask resume or replan.
   - Task description only → continue to 2.
2. Task ambiguous → `/grill-me` until decisions resolved. Clear → skip.
3. Plan tests refer to `/write-tests` skill
4. Write agreed plan to task file: goal line + `- [ ]` subtasks, caveman prose. Each subtask must stay unambiguous — drop caveman for any step where order or condition could misread.
5. Ask confirmation before implementing.
6. Implement one subtask at a time. Check its box right after it passes. Task file must be ready to hand over to another agent at all times.
7. After completion confirmed, delete task file.
