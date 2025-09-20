# Install native apps

pkgs=(
  wezterm
  numi
  obsidian

  # QuickLook plugins
  qlprettypatch
  quicklook-csv
  quicklook-json
  webpquicklook
)

for pkg in "${pkgs[@]}"; do
    echo "Installing $pkg"
    brew install $pkg --cask
done

brew cleanup
