# Create a new directory
function mkd() {
    mkdir -p "$@"
}

# Create a new directory and enter it
function mkdc() {
    mkd "$@" && cd "$_"
}

# `up` is a convenient way to navigate back up a file tree, and is a general-use
# replacement for `cd ..`.
# if no arguments are passed, up is simply an alias for `cd ..`.
# with any integer argument n, `cd ..` will be performed n times
function up() {
    # number of times to move up in the directory tree
    TIMES=$1

    if [ -z ${TIMES} ]; then
        TIMES=1
    fi
    while [ ${TIMES} -gt 0 ]; do
        cd ..
        TIMES=$((${TIMES} - 1))
    done
}

# If given two arguments to cd, replace the first with the second in $PWD,
# emulating a Zsh function that I often find useful; preserves options too
cd() {
    local arg
    local -a opts
    for arg in "$@" ; do
        case $arg in
            --)
                shift
                break
                ;;
            -*)
                shift
                opts=("${opts[@]}" "$arg")
                ;;
            *)
                break
                ;;
        esac
    done
    if (($# == 2)) ; then
        if [[ $PWD == *"$1"* ]] ; then
            builtin cd "${opts[@]}" -- "${PWD/$1/$2}"
        else
            printf 'bash: %s: could not replace substring\n' \
                "$FUNCNAME" >&2
            return 2
        fi
    else
        builtin cd "${opts[@]}" -- "$@"
    fi
}

# cd into whatever is the forefront Finder window.
function cdf() {
	cd "`osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)'`"
}

# cd into whatever is the forefront Finder window.
function cdgr() {
	cd `git root`
}
