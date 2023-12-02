[ -n "$PS1" ] && source ~/.bash_profile

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Atlassian security config
shopt -s histappend
export HISTFILESIZE=1048576
export HISTSIZE=1048576
export HISTTIMEFORMAT="%s "
export PROMPT_COMMAND="history -a; history -c; history -r"


. "$HOME/.cargo/env"

source ~/.afm-git-configrc
