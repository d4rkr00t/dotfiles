# D4rkr00ts’s dotfiles

## Installation

```bash
git clone https://github.com/d4rkr00t/dotfiles.git && cd dotfiles
./init/.brew.sh   # Homebrew packages, casks and fonts from Brewfile
./setup.sh        # needs jq; safe to rerun
```

Optional:

```bash
./init/.osx.sh    # macOS defaults
./init/.npm.sh    # npm init defaults
```

Machine set up from the old layout (rc files in `link/`, workmux, tpm): after `git pull && ./setup.sh`, run once:

```bash
./init/.migrate.sh
```

## What `setup.sh` does

- Symlinks every file in `link/` into `$HOME` (tmux, wezterm, aerospace, readline, curl, wget, screen).
- Writes `~/.zshrc`, `~/.bashrc` and `~/.bash_profile` as untracked stubs that source `rc/*`, unless a regular file already exists. Machine-specific lines and anything appended by other tools belong in those stubs or in `~/.extra`, not in the repo.
- Symlinks `git/config` and `git/ignore` into `~/.config/git/`. `~/.gitconfig` is created as an empty untracked file if missing; git reads both and `git config --global` writes to `~/.gitconfig`.
- Symlinks `nvim/` to `~/.config/nvim`, `rex/init.lua` to `~/.config/rex/`, `skills/` to `~/.claude/skills` and `~/.codex/skills`, `misc/.claude.md` to `~/.claude/CLAUDE.md`.
- Registers `misc/claude-statusline.sh` as the Claude Code status line.

## Layout

- `rc/` — zsh and bash startup files.
- `source/` — aliases, exports, PATH, completion; sourced by both shells.
- `functions/` — shell functions, one per file; `dtlist` lists them, `ref <name>` shows help.
- `bin/git/` — extra git subcommands.
- `git/`, `link/`, `nvim/`, `rex/`, `skills/`, `misc/`, `init/` — as described above.
