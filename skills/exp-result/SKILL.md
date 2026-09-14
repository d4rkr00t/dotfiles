---
name: exp-result
description: Write up an A/B experiment readout in the standard Results format. Use when the user shares an experiment scorecard (screenshot, Statsig/analytics table, or pasted metric deltas) and asks for the result, write-up, summary, or readout.
---

Scorecard in, write-up out. Nothing else. No ship recommendation unless asked.

# Format

```
Results: <significant movements, primary first>. <one clause on what stayed flat>.
```

Three lines, ~100 words total. Prose. No bullets, no headings. Line labels exact — `Results:`, `Impact to KR:`, `Learnings:`.

# Read scorecard

Significant = CI exclude 0. `−2.84% ±0.78%` yes. `−0.70% ±0.80%` no. Scorecards colour these green — trust arithmetic, not colour.

Sort every metric first:

- **Moved** — significant primaries. These are Results.
- **Flat** — CI straddle 0, however good point estimate look. One clause, named flat. Never report non-significant delta as win.
- **Unavailable** — cohort-window metrics (D28 retention, M1 PEU/MAU) need longer runtime. Mention only if headline metric missing.

Guardrails checked separate: errors, task fails, engagement (DAU/DCU/dwell), SLA. Clean = one clause. Significant guardrail regression outrank primary win — lead with it.

Significant secondary metrics give mechanism, not headline. TBT win next to INP win explain _why_ INP moved.
