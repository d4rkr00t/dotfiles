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
./init/.osx
./init/.brew
./init/.cask
./init/.node-packages
./init/.npm
./init/.atom
```

To update, `cd` into your local `dotfiles` repository and then:

```bash
./sync.sh
```
