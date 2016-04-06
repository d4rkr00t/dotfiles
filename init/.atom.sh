SRC_DIR=$( cd ~/Dropbox/Apps/atom/ && pwd )
DEST_DIR=$( cd ~/.atom/ && pwd )

files=(
  config.cson
  styles.less
  keymap.cson
)

pkgs=(
  static-snippets
)

echo ""
echo "Setup atom symlinks"
echo ""

for file in "${files[@]}"; do
    echo "Symlinking file: $file"
    ln -sfF "$SRC_DIR/$file" "$DEST_DIR/$file"
done
unset file

for pkg in "${pkgs[@]}"; do
    echo "Symlinking package: $pkg"
    ln -sfF "$SRC_DIR/packages/$pkg" "$DEST_DIR/packages/"
done
unset pkg
