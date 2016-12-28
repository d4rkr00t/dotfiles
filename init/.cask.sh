# Install native apps

brew install caskroom/cask/brew-cask
brew tap caskroom/versions

pkgs=(
  dropbox
  firefox
  google-chrome
  imagealpha
  imageoptim
  iterm2
  macclean
  miro-video-converter
  numi
  opera
  skype
  spectacle
  transmission
  tunnelblick
  vlc

  # QuickLook plugins
  betterzipql
  qlcolorcode
  qlmarkdown
  qlprettypatch
  qlstephen
  quicklook-csv
  quicklook-json
  suspicious-package
  webp-quicklook
)

for pkg in "${pkgs[@]}"; do
    echo "Installing $pkg"
    brew cask install $pkg
done

brew cask cleanup
