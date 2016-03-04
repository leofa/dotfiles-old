#
# ~/.bash_profile
#
[[ -f ~/.bashrc ]] && . ~/.bashrc
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx -- -keeptty -nolisten tcp > ~/.xorg.log 2>&1

if [ -f $GOPATH/src/github.com/zquestz/s/autocomplete/s-completion.bash ]; then
    . $GOPATH/src/github.com/zquestz/s/autocomplete/s-completion.bash
fi
