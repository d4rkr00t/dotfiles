---
name: pr-review
description: Use when user asks to review a PR or branch
---

Review PR with 2 independent reviewers. Show only findings both agree on. Never comment on the PR, only report to user.

# 1. Target

- Bitbucket PR URL/id → `twg bb prs get <id> -r <workspace>/<repo>` for source + destination branch and description. `git fetch origin <source> <destination>`. HEAD = `origin/<source>`, BASE = `git merge-base origin/<destination> origin/<source>`.
- No arg → HEAD = `HEAD`, BASE = `git merge-base HEAD origin/<default branch>`.
- Never switch the user's checkout. Read PR versions of files with `git show <HEAD>:<path>`.
- Changed files: `git diff --name-only --diff-filter=d <BASE> <HEAD>`.

# 2. Exclude generated files

Drop a file if any match. Reviewers never see dropped files.

- Path: `**/__generated__/**`, `**/generated/**`, `*.graphql.ts`, `*.codegen.*`, `*.gen.ts`, `*.boundary.d.ts`, `**/__snapshots__/**`, `*.snap`, `tsconfig.app.json`, `tsconfig.dev.json`, `yarn.lock`, `yarn.ap.lock`, `pnpm-lock.yaml`, `CHANGELOG.md`, `report.api.md`, `**/.changeset/**`.
- `git check-attr linguist-generated binary -- <path>` reports `set`/`true`.
- First 10 lines of `git show <HEAD>:<path>` match (case-insensitive) `@generated|SignedSource|@codegen|automatically generated|auto-generated|DO NOT EDIT|DO NOT MODIFY|DO NOT CHANGE IT BY HAND`.

# 3. Merge risk

Run `/merge-risk` on the target. Keep its output verbatim for the report.

# 4. Reviewers

Spawn 2 fresh agents in ONE message so they run in parallel. Same model, same prompt, no shared context. Prompt = block below + BASE, HEAD, PR description, filtered file list, all section 2 exclusion rules verbatim.

```
Review the diff `git diff <BASE> <HEAD> -- <files>`. Read full files with `git show <HEAD>:<path>`. Do not switch branches. Do not review files outside the list. Files matching the exclusion rules are generated: never report findings in them, and do not use them as evidence that hand-written code exists.

Assume the code is wrong. There is a high chance it is incorrect, sits at the wrong abstraction layer, or duplicates existing code. Your job is to find out where, not to confirm it works.

Check:
- Correctness (always): logic errors, unhandled edge cases, broken callers, async/state bugs.
- Wrong abstraction layer: logic in the wrong package, layer or component; concerns leaking across boundaries; generic code in product code or the reverse.
- Reinvented existing code: new helper, hook, component or type that already exists in the repo or platform packages. Search before claiming; cite the existing one.
- Feature flag hygiene: new behaviour leaks when the flag is off, flag-off path broken or changed, flag checked in the wrong place, old path not preserved for cleanup.
- Test quality: tests assert implementation not behaviour, new branches untested, over-mocking hides real behaviour, tests that cannot fail.
- Split: does the PR contain multiple independent changes or features that must be separate PRs? Name each group with its files.

Verify each claim in code before reporting: read callers, search for existing equivalents. Drop anything you cannot back with evidence. No style nits.

Severity:
- critical: breaks prod, data loss, security, or flag-off users get new behaviour.
- high: wrong behaviour in a real flow, or wrong layer/duplication that will spread.
- medium: edge case bug, weak or missing tests for new branches.
- low: real but contained issue, safe to fix in a follow-up.

Output only:
FINDING | <file>:<line> | <category> | <severity critical/high/medium/low> | <claim> | <evidence>
SPLIT | yes/no | <groups with files, if yes>
```

# 5. Consensus

- Keep a finding only when both reviewers flag the same file, overlapping lines (±5) or the same symbol, and the same root issue. Unsure → drop.
- Merge the pair into one finding: higher severity, best evidence.
- Split verdict shown only when both say yes; use groups both agree on.
- Count everything dropped.

# 6. Report

```
<merge-risk output>

**Split required:** <groups>   ← only if both reviewers agree

**Findings** (sorted critical → low)
1. [<severity>] <category> — <file>:<line>
   <claim>. <evidence>
...

Dropped: <N> single-reviewer findings
Excluded generated: <paths, comma-separated>
```

No findings → say `No agreed findings.`
