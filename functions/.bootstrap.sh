# Copy default .eslintrc to current folder
function bootstrap-eslint() {
    cp "$DOTFILES/link/.eslintrc" ./
}

# Copy default .csscomb.json to current folder
function bootstrap-csscomb() {
    cp "$DOTFILES/link/.csscomb.json" ./
}

# Copy default .editorconfig to current folder
function bootstrap-editorconfig() {
    cp "$DOTFILES/misc/.editorconfig" ./
}

# Copy default .cz.json to current folder
function bootstrap-cz() {
    cp "$DOTFILES/misc/.cz.json" ./
}
