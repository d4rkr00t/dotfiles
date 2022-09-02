# Install native apps

brew install caskroom/cask/brew-cask
brew tap caskroom/versions

pkgs=(
  dropbox
  firefox
  google-chrome
  numi
  rectangle

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
    brew install $pkg --cask
done

brew cleanup
