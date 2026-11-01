---
name: notes
description: Work with the user's Obsidian vault at ~/Development/obsidian. Use when the user wants to add/file a note (article, video, book, idea, leetcode task…), search their notes or ask what their notes say about a topic, or tidy/audit the vault. Also use proactively when the user's own prior notes could inform the task — researching a topic, comparing approaches, design decisions in CS, build tools/Bazel/monorepos, browser internals, web performance, JS/TS, compilers, or developer productivity.
---

# Notes (Obsidian vault)

Vault: `~/Development/obsidian` (git, synced via GitHub; obsidian-git auto commits/pulls every 10 min). Paths below are relative to it.

Vault is outside the Bash sandbox: reads work, writes and `git` need `dangerouslyDisableSandbox: true`.

## Layout

| Type     | Folder            | Filename                         | Type hub        |
| -------- | ----------------- | -------------------------------- | --------------- |
| Article  | `Notes/Articles/` | `Article – <Title>.md`           | `[[Article]]`   |
| Video    | `Notes/Video/`    | `Video – <Title>.md`             | `[[Video]]`     |
| Book     | `Notes/Books/`    | `Book – <Title>.md`              | `[[Book]]`      |
| Course   | `Notes/Courses/`  | `Course – <Title>.md`            | `[[Course]]`    |
| Paper    | `Notes/Papers/`   | `Paper – <Title>.md`             | `[[Papers]]`    |
| Idea     | `Notes/Ideas/`    | `Idea – <Title>.md`              | `[[Idea]]`      |
| Research | `Notes/Research/` | `Research – <Title>.md`          | `[[Research]]`  |
| Writing  | `Notes/Writings/` | `Writings – <Title>.md`          | `[[Writings]]`  |
| Leetcode | `Leetcode/Tasks/` | `Leetcode <N> – <Title>.md`      | `[[Leetcode]]`  |
| Concept  | `Notes/Default/`  | `<Concept>.md` (no prefix)       | —               |

- Separator is an en dash `–` with spaces, never `-`.
- Images: `Notes/Assets/`, embedded as `![[file.png]]`.
- Daily notes: `Journal/YYYY-MM-DD.md`. Templates: `Templates/` (use the matching one verbatim as the skeleton).

Every note starts with:

```
Reference:
* Source: <url>
* Keywords: [[<Type hub>]] [[<Topic>]] [[<Topic>]]
```

Type hub first. Articles/Research usually add the year hub (`[[2024]]`). Topic keywords are wikilinks used as tags — most have no file. Reuse existing ones; find them with:

```bash
rg --no-filename -o '\[\[[^]]+\]\]' -g '*.md' ~/Development/obsidian --glob '!Templates' | sort | uniq -c | sort -rn
```

Propose a new keyword only when nothing existing fits, and say it is new.

## Sync

Before writing: `git -C ~/Development/obsidian pull --rebase`. After writing: commit (`notes: <what>`) and push. Obsidian may also auto-commit; that's fine.

## Add a note

1. Pick type → folder, filename, template from the table. Ask if unclear.
2. Check it doesn't exist: `rg --files ~/Development/obsidian | rg -i '<title words>'`.
3. Fill header: Source, Keywords (type hub + year hub if applicable + 2–6 existing topics).
4. Article/Video → takeaways (below). Other types → body from the user's input, keep their wording.
5. Show the final path and content, write, sync.

### Takeaways (Article/Video)

1. Get content. Article: `WebFetch` the URL. Video: if `yt-dlp` exists, `yt-dlp --write-auto-subs --sub-langs en --skip-download -o "$TMPDIR/v" <url>` and read the `.vtt`; otherwise ask the user to paste a transcript or their notes. Never invent content you couldn't read.
2. Propose 5–8 numbered takeaways, one line each. Each is a concrete claim, technique, number, or decision — not "the article discusses X".
3. Wait for the user's pick (`1 3 5`, edits, own additions). Do not write before they answer.
4. Write only picked items, verbatim as proposed (or as the user edited them), as a bullet list under `## Takeaways`, right after the header block. Nothing picked → no section.

## Search / answer from notes

1. Titles: `rg --files ~/Development/obsidian -g '*.md' | rg -i '<term>'`
2. Keywords: `rg -l -i '^\* Keywords:.*\[\[<term>' ~/Development/obsidian`
3. Body: `rg -i -l '<term|synonym>' ~/Development/obsidian -g '*.md'`, then read the best hits.
4. Follow `[[links]]` from hits and other notes sharing their keywords when they add context.
5. Answer from the notes only, citing each claim with the note path. Say plainly what the notes don't cover; mark anything from outside the vault as such.

## Audit

Report findings grouped; change nothing until the user approves specific fixes. Run from the vault root. Unresolved `[[links]]` are intentional (used as tags) — don't report them.

```bash
# notes missing a Keywords line
rg --files-without-match '^\* Keywords:' -g '*.md' Notes Leetcode/Tasks

# filename prefix doesn't match folder (catches `-`/`—` instead of `–`)
for p in Articles:Article Video:Video Books:Book Courses:Course Papers:Paper Ideas:Idea Research:Research Writings:Writings; do rg --files "Notes/${p%%:*}" | grep -v "/${p#*:} – "; done
rg --files Leetcode/Tasks | grep -vE '/Leetcode [0-9]+ – '

# unused assets
for f in Notes/Assets/*; do rg -qF "${f##*/}" -g '*.md' . || echo "$f"; done
```
