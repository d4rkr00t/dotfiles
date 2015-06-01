# GitHub URL for current repo.
function ghurl() {
    local remotename="${@:-origin}"
    local remote="$(git remote -v | awk '/^'"$remotename"'.*\(push\)$/ {print $2}')"
    [[ "$remote" ]] || return
    local user_repo="$(echo "$remote" | perl -pe 's/.*:\/\///;s/\.git$//;s/git@//;s/\:/\//')"
    echo "https://$user_repo"
}

# Change git origin and add upstream
function gitor() {
    local url=$1

    if [ -d .git ]; then
        if [[ $url != http* && $url != git@* && ! -z "$url" ]]; then
            local url="https://github.com/$1.git"
        fi

        if ! git remote | grep upstream > /dev/null; then
            git remote rename origin upstream
            git remote add origin $url
        fi

        git remote -v
    else
        echo "-=-=-=->> There isn't a git repo! <<-=-=-=-"
    fi;
}

# Resets origin to upstream
function gitores() {
    if [ -d .git ]; then
        if git remote | grep upstream > /dev/null; then
            git remote rm origin
            git remote rename upstream origin
        fi

        git remote -v
    else
        echo "-=-=-=->> There isn't a git repo! <<-=-=-=-"
    fi;
}
