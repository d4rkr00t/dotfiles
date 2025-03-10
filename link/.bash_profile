#
# WHERE MAGIC HAPPENS.
#
source ~/.dotfiles

# Tweak file globbing.
shopt -s dotglob

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
    shopt -s "$option" 2> /dev/null
done

if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
    export TERM='gnome-256color';
elif infocmp xterm-256color >/dev/null 2>&1; then
    export TERM='xterm-256color';
fi;

# SSH agent forwarding and tmux
if [[ -S "$SSH_AUTH_SOCK" && ! -h "$SSH_AUTH_SOCK" ]]; then
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock;
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock;

# Source all files in "source"
for file in $DOTFILES/source/*; do
    source "$file"
done
unset file

# Source all files in "functions"
for file in $DOTFILES/functions/*; do
    source "$file"
done
unset file

# Extra dotfiles
[ -r ~/.extra ] && [ -f ~/.extra ] && source ~/.extra

export PATH="$HOME/.cargo/bin:$HOME/go/bin:$PATH"
. "$HOME/.cargo/env"
