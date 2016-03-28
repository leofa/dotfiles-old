#!/usr/bin/env bash
# vim: fdm=marker:noai:ts=4:sw=4

## Main Config 

## Overall Conditionals {{{

_islinux=false
[[ "$(uname -s)" =~ Linux|GNU|GNU/* ]] && _islinux=true

_isarch=false
[[ -f /etc/arch-release ]] && _isarch=true

_isxrunning=false
[[ -n "$DISPLAY" ]] && _isxrunning=true

_isroot=false
[[ $UID -eq 0 ]] && _isroot=true

# }}}

## Linux TTY colors {{{

if [ "$TERM" = "linux" ]; then
    _sedcmd='s/.*\*color\([0-9]\{1,\}\).*#\([0-9a-fA-F]\{6\}\).*/\1 \2/p'
    for i in $(sed -n "$_sedcmd" $HOME/.Xdefaults | \
        awk '$1 < 16 {printf "\\e]P%X%s", $1, $2}'); do
    echo -en "$i"; done
    clear
fi

# }}}

## Exports {{{

# set PATH variable
export PATH="/usr/local/bin:$HOME/bin:$HOME/bin:$HOME/.local/bin:$PATH"

# Default browser
export BROWSER="qutebrowser"

# Default terminal emulator
export TERMINAL="termite"

# Default text editor
export EDITOR="vim"

# SSH Askpass
#export SSH_ASKPASS=/usr/lib/ssh/x11-ssh-askpass
unset SSH_ASKPASS

# Wrap output of journal
export SYSTEMD_LESS=FRXMK journalctl

# XFT fonts
export GDK_USE_XFT=1

# JAVA look and feel
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

# QT5 style
export QT_STYLE_OVERRIDE=GTK+

# Ruby support
if which ruby &>/dev/null; then
    GEM_DIR=$(ruby -rubygems -e 'puts Gem.user_dir')/bin
    if [[ -d "$GEM_DIR" ]]; then
        export PATH=$GEM_DIR:$PATH
    fi
fi

# Steam native runtime
export STEAM_RUNTIME=0

# Ranger
export RANGER_LOAD_DEFAULT_RC=FALSE

# Golang Support 
if [ -f $GOPATH/src/github.com/zquestz/s/autocomplete/s-completion.bash ]; then
    . $GOPATH/src/github.com/zquestz/s/autocomplete/s-completion.bash
fi

# }}}

## PS1 Config {{{

# Use vim promptline as PS1 
source $HOME/.shell_prompt.sh

# Default PS1 {{{

[[ -f $HOME/.dircolors ]] && eval $(dircolors -b $HOME/.dircolors)
if $_isxrunning; then
    [[ -f $HOME/.dircolors_256 ]] && eval $(dircolors -b $HOME/.dircolors_256)
   
    export TERM='xterm-256color'

     B='\[\e[1;34m\]'
    LB='\[\e[34m\]'
    GY='\[\e[1;30m\]'
     G='\[\e[30m\]'
     P='\[\e[36m\]'
    PP='\[\e[37m\]'
     R='\[\e[35m\]'
     Y='\[\e[0m\]'
     W='\[\e[0m\]'
    
     get_prompt_symbol() {
      [[ $UID == 0 ]] && echo "#" || echo "\$"
    }

    if [[ $PS1 && -f /usr/share/git/git-prompt.sh ]]; then
      source /usr/share/git/completion/git-completion.bash
      source /usr/share/git/git-prompt.sh

      export GIT_PS1_SHOWDIRTYSTATE=1
      export GIT_PS1_SHOWSTASHSTATE=1
      export GIT_PS1_SHOWUNTRACKEDFILES=0
      
      export PS1="$GY[$Y\u$GY@$P\h$GY:$B\W\$(__git_ps1 \"$GY|$LB%s\")$GY]$W\$(get_prompt_symbol) "
  else
      export PS1="$GY[$Y\u$GY@$P\h$GY:$B\W$GY]$W\$(get_prompt_symbol) "
  fi
else
    export TERM='xterm-256color'
fi

  # Automatically trim long paths in the prompt (requires Bash 4.x)
  PROMPT_DIRTRIM=2
  
  # }}}
# }}}

## BASH Options {{{
 
  shopt -s cdspell                 # Correct cd typos
  shopt -s checkwinsize            # Update windows size on command
  shopt -s histappend              # Append History instead of overwriting
  shopt -s cmdhist                 # Save multi-line commands as one
  shopt -s extglob                 # Extended pattern
  shopt -s no_empty_cmd_completion # No empty completion
  
  set -o noclobber
  # Prevent file overwrite on stdout redirection
  # Use `>|` to force redirection to an existing file

  # }}}

## Completion {{{

complete -cf sudo
if [[ -f /etc/bash_completion ]]; then
    . /etc/bash_completion
fi

# Perform file completion in a case insensitive fashion
bind "set completion-ignore-case on"

# Treat hyphens and underscores as equivalent
bind "set completion-map-case on"

# Display matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"

# }}}

## BASH History {{{

# make multiple shells share the same history file
export HISTSIZE=500000 # bash history will save N commands
export HISTFILESIZE=100000 # bash will remember N commands
export HISTCONTROL="erasedups:ignoreboth" # ingore duplicates and spaces
export HISTIGNORE='&:[ ]*:bg:fg:ls:ll:la:cd:exit:x:clear:c:history:h' # Don't record some commands
HISTTIMEFORMAT='%D %a %T  ' # Useful timestamp format    

# Enable incremental history search with up/down arrows
# Learn more about this here: http://codeinthehole.com/writing/the-most-important-command-line-tip-incremental-history-searching-with-inputrc/
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'

# }}}

## Colored MAN Pages {{{

# @see http://www.tuxarena.com/?p=508
# For colourful man pages (CLUG-Wiki style)
if $_isxrunning; then
    export PAGER=less
    export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
    export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
    export LESS_TERMCAP_me=$'\E[0m'           # end mode
    export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
    export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
    export LESS_TERMCAP_ue=$'\E[0m'           # end underline
    export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline
fi

# }}}

## Aliases {{{

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# }}}

## Functions

## Priviliged Acces {{{

if ! $_isroot; then
      alias sudo='sudo '
      alias scat='sudo cat'
      alias svim='sudo vim'
      alias svi='sudo vi'
      alias root='sudo su'
      alias reboot='sudo reboot'
      alias halt='sudo halt'
  fi
  
  # }}}

## Top 10 Commands {{{

# copyright 2007 - 2010 Christopher Bratusek
top10() { history | awk '{a[$2]++ } END{for(i in a){print a[i] " " i}}' | sort -rn | head; }

# }}}

## Up {{{

# Goes up many dirs as the number passed as argument, if none goes up by 1 by default

up() {
    local d=""
    limit=$1
    for ((i=1 ; i <= limit ; i++)); do
        d=$d/..
    done
    d=$(echo $d | sed 's/^\///')
    if [[ -z "$d" ]]; then
        d=..
    fi
    cd $d
}

# }}}

## Archive Extractor {{{
    
  extract() {
      clrstart="\033[1;34m"  # color codes
      clrend="\033[0m"

      if [[ "$#" -lt 1 ]]; then
        echo -e "${clrstart}Pass a filename. Optionally a destination folder. You can also append a v for verbose output.${clrend}"
        exit 1 # not enough args
      fi

      if [[ ! -e "$1" ]]; then
        echo -e "${clrstart}File does not exist!${clrend}"
        exit 2 # file not found
      fi

      if [[ -z "$2" ]]; then
        DESTDIR="." # set destdir to current dir
      elif [[ ! -d "$2" ]]; then
        echo -e -n "${clrstart}Destination folder doesn't exist or isnt a directory. Create? (y/n): ${clrend}"
        read response
        #echo -e "\n"
        if [[ $response == y || $response == Y ]]; then
          mkdir -p "$2"
          if [ $? -eq 0 ]; then
            DESTDIR="$2"
          else
            exit 6 # Write perms error
          fi
        else
          echo -e "${clrstart}Closing.${clrend}"; exit 3 # n/wrong response
        fi
      else
        DESTDIR="$2"
      fi

      if [[ ! -z "$3" ]]; then
        if [[ "$3" != "v" ]]; then
          echo -e "${clrstart}Wrong argument $3 !${clrend}"
          exit 4 # wrong arg 3
        fi
      fi

      filename=`basename "$1"`

      # echo "${filename##*.}" debug

      case "${filename##*.}" in
        tar)
          echo -e "${clrstart}Extracting $1 to $DESTDIR: (uncompressed tar)${clrend}"
          tar x${3}f "$1" -C "$DESTDIR"
          ;;
        gz)
          echo -e "${clrstart}Extracting $1 to $DESTDIR: (gip compressed tar)${clrend}"
          tar x${3}fz "$1" -C "$DESTDIR"
          ;;
        tgz)
          echo -e "${clrstart}Extracting $1 to $DESTDIR: (gip compressed tar)${clrend}"
          tar x${3}fz "$1" -C "$DESTDIR"
          ;;
        xz)
          echo -e "${clrstart}Extracting  $1 to $DESTDIR: (gip compressed tar)${clrend}"
          tar x${3}f -J "$1" -C "$DESTDIR"
          ;;
        bz2)
          echo -e "${clrstart}Extracting $1 to $DESTDIR: (bzip compressed tar)${clrend}"
          tar x${3}fj "$1" -C "$DESTDIR"
          ;;
        zip)
          echo -e "${clrstart}Extracting $1 to $DESTDIR: (zipp compressed file)${clrend}"
          unzip "$1" -d "$DESTDIR"
          ;;
        rar)
          echo -e "${clrstart}Extracting $1 to $DESTDIR: (rar compressed file)${clrend}"
          unrar x "$1" "$DESTDIR"
          ;;
        7z)
          echo -e  "${clrstart}Extracting $1 to $DESTDIR: (7zip compressed file)${clrend}"
          7za e "$1" -o"$DESTDIR"
          ;;
        *)
          echo -e "${clrstart}Unknown archieve format!"
          exit 5
          ;;
      esac
    }
    
# }}}

## Archive Compress {{{
    
  compress() {
      if [[ -n "$1" ]]; then
        FILE=$1
        case $FILE in
        *.tar ) shift && tar cf $FILE $* ;;
    *.tar.bz2 ) shift && tar cjf $FILE $* ;;
     *.tar.gz ) shift && tar czf $FILE $* ;;
        *.tgz ) shift && tar czf $FILE $* ;;
        *.zip ) shift && zip $FILE $* ;;
        *.rar ) shift && rar $FILE $* ;;
        esac
      else
        echo "usage: compress <foo.tar.gz> ./foo ./bar"
      fi
    }
    
# }}}

## Remind Me {{{
    
  # usage: remindme <time> <text>
  # e.g.: remind 10m "omg, the pizza"
  remindme() { sleep $1 && zenity --info --text "$2" & }
  
# }}}

## Simple Calculator {{{
    
  # usage: calc <equation>
  calc() {
      if which bc &>/dev/null; then
          echo "scale=3; $*" | bc -l
      else
          awk "BEGIN { print $* }"
      fi
    }
    
# }}}

## File & Strings Related Functions {{{

## Find a file with a pattern in name {{{
      
    ff() { find . -type f -iname '*'$*'*' -ls ; }
    
# }}}

## Find a file with pattern $1 in name and execute $2 on it {{{
    
    fe() { find . -type f -iname '*'$1'*' -exec "${2:-file}" {} \;  ; }
    
# }}}

## Move filenames to lowercase {{{
    
    lowercase() {
        for file ; do
          filename=${file##*/}
          case "$filename" in
          */* ) dirname==${file%/*} ;;
            * ) dirname=.;;
          esac
          nf=$(echo $filename | tr A-Z a-z)
          newname="${dirname}/${nf}"
          if [[ "$nf" != "$filename" ]]; then
            mv "$file" "$newname"
            echo "lowercase: $file --> $newname"
          else
            echo "lowercase: $file not changed."
          fi
        done
      }
      
      # }}}

## Swap 2 filenames around, If they exist {{{
    
    #(from Uzi's bashrc).
    swap() {
        local TMPFILE=tmp.$$

        [[ $# -ne 2 ]] && echo "swap: 2 arguments needed" && return 1
        [[ ! -e $1 ]] && echo "swap: $1 does not exist" && return 1
        [[ ! -e $2 ]] && echo "swap: $2 does not exist" && return 1

        mv "$1" $TMPFILE
        mv "$2" "$1"
        mv $TMPFILE "$2"
      }
      
      # }}}

    ## Finds directory sizes Fand lists them for the current directory {{{
    
    dirsize () {
        du -shx * .[a-zA-Z0-9_]* 2> /dev/null | egrep '^ *[0-9.]*[MG]' | sort -n > /tmp/list
        egrep '^ *[0-9.]*M' /tmp/list
        egrep '^ *[0-9.]*G' /tmp/list
        rm -rf /tmp/list
      }
      
      # }}}

    ## Find and remove empty directories {{{
    
    fared() {
        read -p "Delete all empty folders recursively [y/N]: " OPT
        [[ $OPT == y ]] && find . -type d -empty -exec rm -fr {} \; &> /dev/null
      }
      
      # }}}

    ## Find and remove all dotfiles {{{
    
    farad () {
        read -p "Delete all dotfiles recursively [y/N]: " OPT
        [[ $OPT == y ]] && find . -name '.*' -type f -exec rm -rf {} \;
      }
      
      # }}}
# }}}

## Enter and list directory {{{
  
  function cd() { builtin cd -- "$@" && { [ "$PS1" = "" ] || ls -hrt --color; }; }
  
  # }}}
  
## Better directory navigation {{{

# Prepend cd to directory names automatically
shopt -s autocd 2> /dev/null
# Correct spelling errors during tab-completion
shopt -s dirspell 
# Correct spelling errors in arguments supplied to cd
shopt -s cdspell 2> /dev/null

# This defines where cd looks for targets
# Add the directories you want to have fast access to, separated by colon
# Ex: CDPATH=".:~:~/projects" will look for targets in the current working directory, in home and in the ~/projects folder
CDPATH=".:~:~/projects:/srv/archsrv/media"

# This allows you to bookmark your favorite places across the file system
# Define a variable containing a path and you will be able to cd into it regardless of the directory you're in
shopt -s cdable_vars

export  dot="$HOME/dotfiles"
export   sh="$HOME/scripts"
export   i3="$HOME/.i3"
export  i3b="$HOME/.i3/blocklets"
export  bin="$HOME/bin"
export lbin="$HOME/.local/bin"
export proj="$HOME/projects"
export  doc="$HOME/docs"
export sync="$HOME/sync"

# }}}

## Systemd Support {{{
    
if which systemctl &>/dev/null; then
    start() {
        sudo systemctl start $1.service
    }
    restart() {
        sudo systemctl restart $1.service
    }
    stop() {
        sudo systemctl stop $1.service
    }
    enable() {
        sudo systemctl enable $1.service
    }
    enable_now() {
        sudo systemctl enable --now $1.service
    }
    status() {
        sudo systemctl status $1.service
    }
    status_long() {
        sudo systemctl status -l $1.service
    }
    disable() {
        sudo systemctl disable $1.service
    }
    disable_now() {
        sudo systemctl disable --now $1.service
    }
    mask() {
        sudo systemctl mask $1.service
    }
    unmask() {
        sudo systemctl unmask $1.service
    }
    reload() {
        sudo systemctl daemon-reload
    }
fi
    
# }}}

## Docker Support {{{

alias dfunc='vi ~/.docker.func'

if [ -f ~/.docker.func ]; then
    . $HOME/.docker.func
fi

# }}}

## HTTP Server {{{

# Start an HTTP server from a directory, optionally specifying the port
server() {
	local port="${1:-8000}"
	sleep 1 && $BROWSER "http://localhost:${port}/" &
	# Set the default Content-Type to `text/plain` instead of `application/octet-stream`
	# And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
	python2 -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}

# }}}
