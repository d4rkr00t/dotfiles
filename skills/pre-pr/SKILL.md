---
name: pre-pr
description: Quiz user on own change before PR, to find gaps in their understanding. Use when user asks to be quizzed, grilled, or checked before opening a PR.
---

Quiz user on their change. User talks, not you. Not a code review — /after-implementation do that. Plan or design instead of diff → /grill-me.

# Scope

Branch diff vs base + untracked files. Read changes, not memory of them.

# Quiz

Five questions. One at a time, wait for answer. Must cover:

- What breaks if change wrong
- Why this approach over obvious alternative
- Which part user least sure about

Other two: weakest spots in diff.

# Rules

No answers before user answer. No hint inside question, no leading question.
No follow-ups. Wrong or vague → say so straight, give correct answer, next question.
User say "skip" → give answer, next question.

# After

Each question: right, partial, or wrong. Correct wrong ones from diff, quote file:line.
Verdict: ready for PR, or list what user must check first.
