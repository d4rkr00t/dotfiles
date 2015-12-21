mkdir -p $DOTFILES/.tmux-plugins

plugins=(
    tmux-sensible
    tmux-prefix-highlight
    tmux-copycat
    tmux-resurrect
    tmux-yank
)

for pkg in "${plugins[@]}"; do
    echo "Installing $pkg"
    if [ -d $DOTFILES/.tmux-plugins/$pkg ]; then
        echo "Plugin $pkg alredy exists. Updating $pkg"
        cd $DOTFILES/.tmux-plugins/$pkg && git pull --ff
    else
        git clone git@github.com:tmux-plugins/$pkg.git $DOTFILES/.tmux-plugins/$pkg
    fi
done
