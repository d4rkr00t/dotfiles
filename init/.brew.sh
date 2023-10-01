# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

pkgs=(
    bash
    bash_completion
    bat
    cloc
    coreutils
    exa
    fd
    ffmpeg
    findutils
    fnm
    git
    git-absorb
    git-lfs
    git-when-merged
    hh
    httpie
    imagemagick
    ncdu
    nvim
    pure
    rename
    ripgrep
    starship
    tree
    vim --override-system-vi
    wget --with-iri
    zoxide
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
