# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade --all

pkgs=(
    bash
    bash_completion
    coreutils
    fd
    ffmpeg
    findutils
    gifsicle
    git
    git-when-merged
    hh
    httpie
    homebrew/dupes/grep
    homebrew/dupes/less
    imagemagick --with-webp
    ncdu
    nvm
    rename
    ripgrep
    speedtest-cli
    tmux
    tree
    vim --override-system-vi
    wget --with-iri
)

for pkg in "${pkgs[@]}"; do
    echo "Installing $pkg"
    brew install $pkg
done

brew tap homebrew/services

# Remove outdated versions from the cellar
brew cleanup
