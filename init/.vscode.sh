SRC_DIR=$( cd ~/Dropbox/Apps/vscode/ && pwd )
EXT_DIR=$( cd ~/.vscode-insiders/ && pwd )
SETTINGS_DIR=$( cd ~/Library/Application\ Support/Code\ -\ Insiders/User/ && pwd )

files=(
  keybindings.json
  settings.json
  snippets
)

echo ""
echo "Setup vscode symlinks"
echo ""

for file in "${files[@]}"; do
    echo "Symlinking file: $file"
    rm -rf "$SETTINGS_DIR/$file"
    ln -sfF "$SRC_DIR/$file" "$SETTINGS_DIR/$file"
done
unset file

echo "Symlinking extensions"
rm -rf "$EXT_DIR/extensions"
ln -sfF "$SRC_DIR/extensions" "$EXT_DIR/extensions"