# Get a character’s Unicode code point: £ → \x00A3
function codepoint() {
    perl -e "use utf8; print sprintf('\x%04X', ord(\"$@\"))"
    echo
}

# Print nyan cat
# https://github.com/steckel/Git-Nyan-Graph/blob/master/nyan.sh
# If you want big animated version: `telnet miku.acm.uiuc.edu`
function nyan() {
    echo
    echo -en $RED'-_-_-_-_-_-_-_'
    echo -e $NOCOLOR$BOLD',------,'$NOCOLOR
    echo -en $YELLOW'_-_-_-_-_-_-_-'
    echo -e $NOCOLOR$BOLD'|   /\_/\\'$NOCOLOR
    echo -en $GREEN'-_-_-_-_-_-_-'
    echo -e $NOCOLOR$BOLD'~|__( ^ .^)'$NOCOLOR
    echo -en $CYAN'-_-_-_-_-_-_-'
    echo -e $NOCOLOR$BOLD'""  ""'$NOCOLOR
    echo
}
