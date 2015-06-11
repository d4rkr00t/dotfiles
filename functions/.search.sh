# Find files and exec commands at them.
# $ find-exec .coffee cat | wc -l
function find-exec() {
  find . -type f -iname "*${1:-}*" -exec "${2:-file}" '{}' \;
}

# Better find(1)
function ff() {
  find . -iname "*${1:-}*"
}

# Find and replace
function fr() {
  sed -i '' -e 's/'$2'/'$3'/g' $(find . -type f -iname $1)
}
