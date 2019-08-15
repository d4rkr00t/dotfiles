# making zsh default
# https://stackoverflow.com/questions/31034870/making-zsh-default-shell-in-macosx
sudo echo "$(which zsh)" >> /etc/shells
chsh -s /bin/zsh

# zsh compinit: insecure directories
# https://stackoverflow.com/questions/13762280/zsh-compinit-insecure-directories
compaudit | xargs chmod g-w
