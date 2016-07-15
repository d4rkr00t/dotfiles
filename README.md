# D4rkr00ts’s dotfiles

## Installation

### Using Git and the bootstrap script

You can clone the repository wherever you want.
The bootstrapper script will create symlinks for few needed files and also updates DOTFILES path in ~/.dotfiles.

```bash
git clone https://github.com/d4rkr00t/dotfiles.git && cd dotfiles && ./sync.sh
```

Install and init settings for some apps:
```bash
./init/.osx.sh
./init/.brew.sh
./init/.cask.sh
./init/.npm.sh
./init/.node-packages.sh
./init/.tmux.sh
./init/.bashmarks.sh
./init/.atom.sh
```

To update, `cd` into your local `dotfiles` repository and then:

```bash
./sync.sh
```
