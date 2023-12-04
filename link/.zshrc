
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source ~/.dotfiles

#
# fpath
#

# As per `brew info zsh-completions`
fpath=(/usr/local/share/zsh-completions $fpath)
fpath+=("$(brew --prefix)/share/zsh/site-functions")

#
# Prompt theme
# https://github.com/sindresorhus/pure
#
autoload -U promptinit; promptinit
prompt pure
PURE_PROMPT_SYMBOL=λ
# eval "$(starship init zsh)"
# source $(brew --prefix)/opt/spaceship/spaceship.zsh

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
compinit

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


# Delete Git's official completions to allow Zsh's official Git completions to work.
# Git ships with really bad Zsh completions. Zsh provides its own completions
# for Git, and they are much better.
# https://github.com/Homebrew/homebrew-core/issues/33275#issuecomment-432528793
# https://twitter.com/OliverJAsh/status/1068483170578964480
# Unfortunately it's not possible to install Git without completions (since
# https://github.com/Homebrew/homebrew-core/commit/f710a1395f44224e4bcc3518ee9c13a0dc850be1#r30588883),
# so in order to use Zsh's own completions, we must delete Git's completions.
# This is also necessary for hub's Zsh completions to work:
# https://github.com/github/hub/issues/1956.
function () {
  GIT_ZSH_COMPLETIONS_FILE_PATH="$(brew --prefix)/share/zsh/site-functions/_git"
  if [ -f $GIT_ZSH_COMPLETIONS_FILE_PATH ]
  then
  rm $GIT_ZSH_COMPLETIONS_FILE_PATH
  fi
}


#
# zsh-history-substring-search
#

# Load from Brew
# As per `brew info zsh-history-substring-search`
source `brew --prefix`/share/zsh-history-substring-search/zsh-history-substring-search.zsh
# Bind UP and DOWN arrow keys
# Copied from https://github.com/zsh-users/zsh-history-substring-search/tree/47a7d416c652a109f6e8856081abc042b50125f4#usage
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

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
setopt autocd autopushd

# Source all files in "source"
for file in $DOTFILES/source/(.)*; do
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
[ -r ~/.extra ] && [ -f ~/.extra ] && source ~/.extra

# bun completions
[ -s "/Users/ssysoev/.bun/_bun" ] && source "/Users/ssysoev/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

source ~/.afm-git-configrc
