
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source ~/.dotfiles

# Cache Homebrew's prefix — `brew --prefix` forks a subprocess, and it was
# previously called once per use site.
BREW_PREFIX="$(brew --prefix)"

#
# fpath
#

# As per `brew info zsh-completions`
fpath=("$BREW_PREFIX/share/zsh-completions" $fpath)
fpath+=("$BREW_PREFIX/share/zsh/site-functions")

#
# Prompt theme
# https://github.com/sindresorhus/pure
#
autoload -U promptinit; promptinit
prompt pure
PURE_PROMPT_SYMBOL=λ
PURE_GIT_PULL=0
PURE_GIT_UNTRACKED_DIRTY=0

# Navigate without cd
setopt AUTO_CD

#
# Word style: directory delimiter
# http://stackoverflow.com/a/1438523
#
autoload -U select-word-style
select-word-style bash

#
# Completion
#

# zsh.sourceforge.net/Doc/Release/Completion-System.html
autoload -Uz compinit
# -u: use completions from group-writable dirs (/opt/homebrew/share) without
#     prompting. Needed because share/zsh-completions' parent is group-writable.
# -C: always trust the cached dump — skips scanning fpath for new completions,
#     which costs ~0.16s vs ~0.01s. Run `compreload` after installing a tool
#     whose completions you want.
compinit -u -C

# case insensitive (all), partial-word and substring completion
# https://github.com/robbyrussell/oh-my-zsh/blob/e8aba1bf5912f89f408eaebd1bc74c25ba32a62c/lib/completion.zsh#L23
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

# Menu selection
# http://www.masterzen.fr/2009/04/19/in-love-with-zsh-part-one/
# Highlight
zstyle ':completion:*' menu select
# Tag name as group name
zstyle ':completion:*' group-name ''
# Format group names
zstyle ':completion:*' format '%B---- %d%b'


#
# zsh-history-substring-search
#

# Load from Brew
HISTORY_SUBSTRING_SEARCH="$BREW_PREFIX/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
if [ -f "$HISTORY_SUBSTRING_SEARCH" ]; then
  # As per `brew info zsh-history-substring-search`
  source "$HISTORY_SUBSTRING_SEARCH"
  # Bind UP and DOWN arrow keys
  # Copied from https://github.com/zsh-users/zsh-history-substring-search/tree/47a7d416c652a109f6e8856081abc042b50125f4#usage
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
fi

#
# History
# https://kevinjalbert.com/more-shell-history/
# https://unix.stackexchange.com/a/273863
#

# How many we load (?)
export HISTSIZE=100000
# How many we can hold (?)
export SAVEHIST=$HISTSIZE
# History won't be saved without the following command
# This isn't set by default.
export HISTFILE="$HOME/.zsh_history"

# Do not display a line previously found.
setopt HIST_FIND_NO_DUPS
# Delete old recorded entry if new entry is a duplicate.
setopt HIST_IGNORE_ALL_DUPS
# Write to the history file immediately, not when the shell exits.
setopt INC_APPEND_HISTORY
# Share history between all sessions.
setopt SHARE_HISTORY

#
# Navigation
#
# setopt autocd autopushd

# Source all files in "source"
for file in $DOTFILES/source/(.)*; do
    # .bash_prompt is bash-only; zsh uses `prompt pure` (above).
    [[ "${file:t}" == ".bash_prompt" ]] && continue
    source "$file"
done
unset file

# Source all files in "functions"
for file in $DOTFILES/functions/*; do
    source "$file"
done
unset file

# zoxide
eval "$(zoxide init zsh)"

# Extra dotfiles
[ -r ~/.extra ] && source ~/.extra

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export PATH="$HOME/.orbit/bin:$PATH"
