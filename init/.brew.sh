# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade --all

pkgs=(
    bash
    bash_completion
    coreutils
    docker
    docker-machine
    docker-compose
    ffmpeg
    findutils
    fpp
    gifsicle
    git
    hh
    homebrew/dupes/grep
    imagemagick --with-webp
    mongodb
    ncdu
    nvm
    rename
    speedtest_cli
    the_silver_searcher
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
