# Compare original and gzipped file size
function gz() {
    local origsize=$(wc -c < "$1")
    local gzipsize=$(gzip -c "$1" | wc -c)
    local ratio=$(echo "$gzipsize * 100/ $origsize" | bc -l)
    printf "orig: %d bytes\n" "$origsize"
    printf "gzip: %d bytes (%2.2f%%)\n" "$gzipsize" "$ratio"
}

# Quickly get image dimensions from the command line
function imgsize() {
  local width height
  if [[ -f $1 ]]; then
    height=$(sips -g pixelHeight "$1"|tail -n 1|awk '{print $2}')
    width=$(sips -g pixelWidth "$1"|tail -n 1|awk '{print $2}')
    echo "${width} x ${height}"
  else
    echo "File not found"
  fi
}

# Count files
cf() {
    local dir

    # Specify directory to check
    dir=${1:-$PWD}

    # Error conditions
    if [[ ! -e $dir ]] ; then
        printf 'bash: %s: %s does not exist\n' \
            "$FUNCNAME" "$dir" >&2
        return 1
    elif [[ ! -d $dir ]] ; then
        printf 'bash: %s: %s is not a directory\n' \
            "$FUNCNAME" "$dir" >&2
        return 1
    elif [[ ! -r $dir ]] ; then
        printf 'bash: %s: %s is not readable\n' \
            "$FUNCNAME" "$dir" >&2
        return 1
    fi

    # Count files and print; use a subshell so options are unaffected
    (
        shopt -s dotglob nullglob
        declare -a files=("$dir"/*)
        printf '%d\t%s\n' "${#files[@]}" "$dir"
    )
}
