# NPM URL for current package.
function npmurl() {
    local package=`jsonval package.json name | tr -d ' '`
    [[ "$package" ]] || return
    echo "https://npmjs.com/package/$package"
}
