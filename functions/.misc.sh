# Show man page in Preview.app.
# $ manp cd
function manp {
  local page
  if (( $# > 0 )); then
    for page in "$@"; do
      man -t "$page" | open -f -a Preview
    done
  else
    print 'What manual page do you want?' >&2
  fi
}

# Returns random number betwean 1 and given param
function rndnum {
  echo $RANDOM % "$1" + 1 | bc
}

# Mesure execution time
function exectime() {
  start_time=`date +%s`

  eval '$@'
  hr
  echo ${yellow}run time is $(expr `date +%s` - $start_time)s${reset}
  hr
}

# Get random string from file
function rndstr(){
  local count=$2
  : ${count:=-1}
  f=$1; n=$(expr $RANDOM \* `cat $f | wc -l` \/ 32768 + 1); head -n $n $f | tail $count
}

# Search upwards till found
function upsearch () {
  slashes=${PWD//[^\/]/}
  directory="$PWD"
  for (( n=${#slashes}; n>0; --n ))
  do
    test -e "$directory/$1" && echo "$directory/$1" && return
    directory="$directory/.."
  done
}

# SSHFS mount
function sshfsmount() {
  local mountPath="/Volumes/sshfs"

  mkdir -p $mountPath

  sshfs -o Ciphers=arcfour -o Compression=yes -o auto_cache,reconnect,defer_permissions,noappledouble -o workaround=nodelaysrv -o cache_stat_timeout=600 -o IdentityFile=~/.ssh/id_rsa $1 $mountPath
}

# Print all 256 colors
function aa_256()
{
  ( x=`tput op` y=`printf %$((${COLUMNS}-6))s`;
  for i in {0..256};
  do
  o=00$i;
  echo -e ${o:${#o}-3:3} `tput setaf $i;tput setab $i`${y// /=}$x;
  done )
}

# Sanitize all filenames in current dir: lowercase, no other characters than letters, digits, dash, underscore and dot
function sanitize() {
    for file in *; do
       file_clean=`echo $file | tr '[:upper:]' '[:lower:]' | tr -cd "[:alnum:]-_."`
       if [ "${file}" != "${file_clean}" ]; then
           echo "$file > $file_clean"
           mv "$file" "$file_clean"
       fi
    done
}

# Get value of property from json file
function jsonval() {
  KEY=$2
  num=$3
  cat $1 | awk -F"[,:}]" '{for(i=1;i<=NF;i++){if($i~/\042'$KEY'\042/){print $(i+1)}}}' | tr -d '"' | sed -n ${num}p
}
