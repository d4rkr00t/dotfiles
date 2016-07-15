# Install native apps

brew install caskroom/cask/brew-cask
brew tap caskroom/versions

pkgs=(
  dropbox
  firefox
  firefoxdeveloperedition
  google-chrome
  google-chrome-canary
  imagealpha
  imageoptim
  iterm2-nightly
  macclean
  miro-video-converter
  numi
  opera
  opera-developer
  skype
  transmission
  tunnelblick
  vlc
  xmind

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
