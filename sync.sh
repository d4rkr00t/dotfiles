#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE}")"
git pull origin master
function doIt() {
	chmod +x .node-packages.sh

	rsync --exclude ".git/" --exclude ".DS_Store" --exclude "sync.sh" \
        --exclude "SolarizedDark.terminal" \
        --exclude "SolarizedDark.itermcolors" \
        --exclude ".node-packages.sh" \
        --exclude ".idea" \
        --exclude ".atom" \
		--exclude "README.md" --exclude "LICENSE-MIT.txt" -avh --no-perms . ~
	source ~/.bash_profile
}
if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt
	fi
fi
unset doIt
