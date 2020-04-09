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
  miro-video-converter
  numi
  opera
  skype
  rectangle
  transmission

  # QuickLook plugins
  qlcolorcode
  qlmarkdown
  qlprettypatch
  qlstephen
  qlimagesize
  qlvideo
  quicklook-csv
  quicklook-json
  webpquicklook
)

for pkg in "${pkgs[@]}"; do
    echo "Installing $pkg"
    brew cask install $pkg
done

brew cask cleanup
