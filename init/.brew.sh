# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade --all

pkgs=(
    coreutils
    findutils
    bash
    wget --with-iri
    vim --override-system-vi
    homebrew/dupes/grep
    ag
    hh
    git
    imagemagick --with-webp
    rename
    webkit2png
    mongodb
    speedtest_cli
    tmux
    tree
    bash_completion
    nvm
    the_silver_searcher
    ffmpeg
    gifsicle
)

for pkg in "${pkgs[@]}"; do
    echo "Installing $pkg"
    brew install $pkg
done

brew tap homebrew/services

# Remove outdated versions from the cellar
brew cleanup