#!/usr/bin/env bash
# vim: fdm=marker:noai:ts=4:sw=4

## MAIN CONFIG

## OVERALL CONDITIONALS {{{
_islinux=false
[[ "$(uname -s)" =~ Linux|GNU|GNU/* ]] && _islinux=true

_isarch=false
[[ -f /etc/arch-release ]] && _isarch=true

_isxrunning=false
[[ -n "$DISPLAY" ]] && _isxrunning=true

_isroot=false
[[ $UID -eq 0 ]] && _isroot=true
#}}}

## LINUX tty colors {{{
if [ "$TERM" = "linux" ]; then
    _SEDCMD='s/.*\*color\([0-9]\{1,\}\).*#\([0-9a-fA-F]\{6\}\).*/\1 \2/p'
    for i in $(sed -n "$_SEDCMD" $HOME/.Xresources | \
               awk '$1 < 16 {printf "\\e]P%X%s", $1, $2}'); do
        echo -en "$i"
    done
    clear
fi
#}}}

## PS1 CONFIG {{{

  # Vim-promptline 
  # https://github.com/edkolev/promptline.vim
  source ~/.shell_prompt.sh

  [[ -f $HOME/.dircolors ]] && eval $(dircolors -b $HOME/.dircolors)
  if $_isxrunning; then
      
      [[ -f $HOME/.dircolors_256 ]] && eval $(dircolors -b $HOME/.dircolors_256)

    export TERM='xterm-termite'

     if [[ $TERM == xterm-termite ]]; then
      . /etc/profile.d/vte.sh
         __vte_prompt_command
    fi

#}}}

## BASH OPTIONS {{{
  shopt -s cdspell                 # Correct cd typos
  shopt -s checkwinsize            # Update windows size on command
  shopt -s histappend              # Append History instead of overwriting file
  shopt -s cmdhist                 # Bash attempts to save all lines of a multiple-line command in the same history entry
  shopt -s extglob                 # Extended pattern
  shopt -s no_empty_cmd_completion # No empty completion
  
  ## ALIASES {{{
    if [ -f ~/.bash_aliases ]; then
      . ~/.bash_aliases
    fi
  #}}} 

  ## COMPLETION {{{
    complete -cf sudo
    if [[ -f /etc/bash_completion ]]; then
      . /etc/bash_completion
    fi
  #}}}
#}}}

## EXPORTS {{{  
  export PATH=/usr/local/bin:$PATH
  #Ruby support
  if which ruby &>/dev/null; then
    GEM_DIR=$(ruby -rubygems -e 'puts Gem.user_dir')/bin
    if [[ -d "$GEM_DIR" ]]; then
      export PATH=$GEM_DIR:$PATH
    fi
  fi
  if [[ -d "$HOME/bin" ]] ; then
      export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
  fi

# Wrap output of journalctl 
  export SYSTEMD_LESS=FRXMK journalctl
    
# Use gtk for java apps
  export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

# Webbrowser
  export BROWSER=/usr/bin/chromium

# Steam native runtime
  export STEAM_RUNTIME=0

# Ranger
  export RANGER_LOAD_DEFAULT_RC=FALSE
#}}}

## EDITOR {{{
    if which vim &>/dev/null; then
      export EDITOR="vim"
    elif which emacs &>/dev/null; then
      export EDITOR="emacs -nw"
    else
      export EDITOR="nano -w"
    fi
#}}}

  ## BASH HISTORY #{{{
    # make multiple shells share the same history file
    export HISTSIZE=10000           # bash history will save N commands
    export HISTFILESIZE=${HISTSIZE} # bash will remember N commands
    export HISTCONTROL=ignoreboth   # ingore duplicates and spaces
    export HISTIGNORE='&:ls:ll:la:cd:exit:x:clear:c:history:h'
  #}}}

  ## COLORED MANUAL PAGES #{{{
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
  #}}}

## FUNCTIONS

  # PRIVILEGED ACCESS {{{
    if ! $_isroot; then
      alias sudo='sudo '
      alias scat='sudo cat'
      alias svim='sudo vim'
      alias svi='sudo vi'
      alias root='sudo su'
      alias reboot='sudo reboot'
      alias halt='sudo halt'
    fi
    #}}}

  # TOP 10 COMMANDS {{{
    # copyright 2007 - 2010 Christopher Bratusek
    top10() { history | awk '{a[$2]++ } END{for(i in a){print a[i] " " i}}' | sort -rn | head; }
  #}}}

  # UP {{{
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
  #}}}

  # ARCHIVE EXTRACTOR {{{
    extract() {
      clrstart="\033[1;34m"  #color codes
      clrend="\033[0m"

      if [[ "$#" -lt 1 ]]; then
        echo -e "${clrstart}Pass a filename. Optionally a destination folder. You can also append a v for verbose output.${clrend}"
        exit 1 #not enough args
      fi

      if [[ ! -e "$1" ]]; then
        echo -e "${clrstart}File does not exist!${clrend}"
        exit 2 #file not found
      fi

      if [[ -z "$2" ]]; then
        DESTDIR="." #set destdir to current dir
      elif [[ ! -d "$2" ]]; then
        echo -e -n "${clrstart}Destination folder doesn't exist or isnt a directory. Create? (y/n): ${clrend}"
        read response
        #echo -e "\n"
        if [[ $response == y || $response == Y ]]; then
          mkdir -p "$2"
          if [ $? -eq 0 ]; then
            DESTDIR="$2"
          else
            exit 6 #Write perms error
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
          exit 4 #wrong arg 3
        fi
      fi

      filename=`basename "$1"`

      #echo "${filename##*.}" debug

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
  #}}}

  # ARCHIVE COMPRESS {{{
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
  #}}}

  # CONVERT TO ISO {{{
    to_iso () {
      if [[ $# == 0 || $1 == "--help" || $1 == "-h" ]]; then
        echo -e "Converts raw, bin, cue, ccd, img, mdf, nrg cd/dvd image files to ISO image file.\nUsage: to_iso file1 file2..."
      fi
      for i in $*; do
        if [[ ! -f "$i" ]]; then
          echo "'$i' is not a valid file; jumping it"
        else
          echo -n "converting $i..."
          OUT=`echo $i | cut -d '.' -f 1`
          case $i in
                *.raw ) bchunk -v $i $OUT.iso;; #raw=bin #*.cue #*.bin
          *.bin|*.cue ) bin2iso $i $OUT.iso;;
          *.ccd|*.img ) ccd2iso $i $OUT.iso;; #Clone CD images
                *.mdf ) mdf2iso $i $OUT.iso;; #Alcohol images
                *.nrg ) nrg2iso $i $OUT.iso;; #nero images
                    * ) echo "to_iso don't know de extension of '$i'";;
          esac
          if [[ $? != 0 ]]; then
            echo -e "${R}ERROR!${W}"
          else
            echo -e "${G}done!${W}"
          fi
        fi
      done
    }
  #}}}

  # REMIND ME, ITS IMPORTANT! {{{
    # usage: remindme <time> <text>
    # e.g.: remind 10m "omg, the pizza"
    remindme() { sleep $1 && zenity --info --text "$2" & }
  #}}}

  # SIMPLE CALCULATOR #{{{
    # usage: calc <equation>
    calc() {
      if which bc &>/dev/null; then
        echo "scale=3; $*" | bc -l
      else
        awk "BEGIN { print $* }"
      fi
    }
  #}}}

  # FILE & STRINGS RELATED FUNCTIONS {{{
    ## FIND A FILE WITH A PATTERN IN NAME {{{
      ff() { find . -type f -iname '*'$*'*' -ls ; }
    #}}}
    ## FIND A FILE WITH PATTERN $1 IN NAME AND EXECUTE $2 ON IT {{{
      fe() { find . -type f -iname '*'$1'*' -exec "${2:-file}" {} \;  ; }
    #}}}
    ## MOVE FILENAMES TO LOWERCASE {{{
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
  #}}}

    ## SWAP 2 FILENAMES AROUND, IF THEY EXIST {{{
      swap() {
        local TMPFILE=tmp.$$

        [[ $# -ne 2 ]] && echo "swap: 2 arguments needed" && return 1
        [[ ! -e $1 ]] && echo "swap: $1 does not exist" && return 1
        [[ ! -e $2 ]] && echo "swap: $2 does not exist" && return 1

        mv "$1" $TMPFILE
        mv "$2" "$1"
        mv $TMPFILE "$2"
      }
    #}}}

    ## FINDS DIRECTORY SIZES AND LISTS THEM FOR THE CURRENT DIRECTORY {{{
      dirsize () {
        du -shx * .[a-zA-Z0-9_]* 2> /dev/null | egrep '^ *[0-9.]*[MG]' | sort -n > /tmp/list
        egrep '^ *[0-9.]*M' /tmp/list
        egrep '^ *[0-9.]*G' /tmp/list
        rm -rf /tmp/list
      }
    #}}}

    ## FIND AND REMOVED EMPTY DIRECTORIES {{{
      fared() {
        read -p "Delete all empty folders recursively [y/N]: " OPT
        [[ $OPT == y ]] && find . -type d -empty -exec rm -fr {} \; &> /dev/null
      }
    #}}}

    ## FIND AND REMOVED ALL DOTFILES {{{
      farad () {
        read -p "Delete all dotfiles recursively [y/N]: " OPT
        [[ $OPT == y ]] && find . -name '.*' -type f -exec rm -rf {} \;
      }
    #}}}


  # ENTER AND LIST DIRECTORY{{{
    function cd() { builtin cd -- "$@" && { [ "$PS1" = "" ] || ls -hrt --color; }; }
  #}}}

  # SYSTEMD SUPPORT {{{
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
      status() {
        sudo systemctl status $1.service
      }
      disable() {
        sudo systemctl disable $1.service
      }
    fi
  #}}}

# DOCKER SUPPORT {{{
if [ -f ~/.docker.func ]; then
  . ~/.docker.func
fi
#}}}
