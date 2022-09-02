# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade --all

pkgs=(
    bash
    bash_completion
    bat
    coreutils
    exa
    fd
    ffmpeg
    findutils
    fnm
    git
    git-when-merged
    git-absorb
    hh
    httpie
    homebrew/dupes/grep
    homebrew/dupes/less
    imagemagick
    ncdu
    rename
    ripgrep
    tree
    vim --override-system-vi
    wget --with-iri
    zsh
    zsh-completions
    zsh-history-substring-search
)

for pkg in "${pkgs[@]}"; do
    echo "Installing $pkg"
    brew install $pkg
done

brew tap homebrew/services

# Remove outdated versions from the cellar
brew cleanup
