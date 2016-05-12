# leofa's shell aliases
# vim: fdm=marker:noai:ts=4:sw=4

## Aliases

# Modified Commands {{{

alias ..='cd ..'
alias df='df -h'
alias diff='colordiff'  # requires colordiff package
alias du='du -c -h'
alias free='free -m'  # show sizes in MB
alias grep='grep --color=auto'
alias grep='grep --color=tty -d skip'
alias mkdir='mkdir -p -v'
alias more='less'
alias nano='nano -w'
alias vi='vim'
alias dd='dd status=progress'

# }}}

# LS {{{

alias ls='ls -hF --color=auto'
alias lr='ls -R'  # recursive ls
alias ll='ls -alh'
alias la='ll -A'
alias lm='la | less'

# }}}

# Autocolor {{{

alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# }}}

# Error Prevention {{{

alias :q=' exit'
alias :Q=' exit'
alias :x=' exit'
alias cd..='cd ..'
alias ..='cd ..'

# }}}

# Little Time Savers {{{

alias h='history'
alias c='clear'
alias r='reset'
alias x='exit'

# }}}

# System Admin Stuff {{{

alias sudo='sudo '
alias diskact="sudo iotop -Po"  # disk activity
alias big='ncdu -x'
alias freemem='sudo /sbin/sysctl -w vm.drop_caches=3'
alias disks='df -h; btrfs filesystem df /'
alias err='dmesg -l err; systemctl --failed'
alias warn='dmesg -l warn'
alias errors="sudo journalctl -p 0..3 -xn"  # high priority errors
alias blame='systemd-analyze; systemd-analyze blame'
alias log='journalctl -f | ccze -A'  # follow log
alias log0='journalctl -b -0 | ccze -A'  # current log 
alias log1='journalctl -b -1 | ccze -A'  # previous log

# Saves journal logs to file
getlog() { local file=~/logs/system/log-$(date +%Y%m%d-%H:%M).txt; sudo journalctl -b > "$file" && xdg-open "$file"; }

# Flash Coreboot ROM
alias flash_rom='cd; rm -f ~/flash_chromebook_rom.sh; curl -L -O https://johnlewis.ie/flash_chromebook_rom.sh; sudo -E bash flash_chromebook_rom.sh'

# }}}

# Pac-Man C o o o {{{

alias U='pacbup; pacupd'  # Pacman backup + upgrade scripts
alias Us="pacbup; echo 'Pacman sync...'; pacaur -Syy; echo 'done'; pacupd"   # Pacman sync + upgrade
alias I='pacaur -S' # install  
alias Iu='pacaur -U' #install local package
alias In='pacaur -S --noedit --noconfirm --needed' #install silently
alias Pi='pacaur -Si'
alias Upa='pacaur -Sy && sudo abs'
alias Id='pacaur -S --asdeps'
alias Pm='makepkg -fcsi' 
alias Un='pacaur -Su --noconfirm --noedit'
alias Ud='pacaur -Su --aur --noconfirm --noedit --devel --needed'
alias S='pacaur -Ss'
alias Sy='pacaur -Syy'
alias Pi='pacaur -Si'
alias Pd='pacaur -d'
alias Pe='pacaur -e' 
alias R='pacaur -Rns'
alias Rs='sudo pacaur -Rns $(pacaur -Qtdq)'
alias Yl='yaourt -Qm'  # local packages
alias Yf='yaourt -Qet'  # foreign packages
alias Cc='yaourt -C; sudo pkgcacheclean -v; pacaur -Scc --noconfirm'
alias pkgaur='pacman -Qemq'
alias pacdep='pacman -Qdt'
alias pacexp='pacman -Qet'
alias upd='pacaur -Qu'
alias refr='refl; sudo rm -r /var/lib/pacman/db.lck; sudo pacman-key --init; sudo pacman-key --populate archlinux; sudo pacman-key --refresh-keys; sudo pacman-optimize' # Refresh all the things
alias refl='sudo reflector --verbose --country 'Netherlands' -l 200 -p http --sort age --fastest 3 --save /etc/pacman.d/mirrorlist; cat /etc/pacman.d/mirrorlist'

# }}}

# SSH {{{

  alias osmc='ssh osmc'
  alias pi2='ssh pi2'
  alias pi1='ssh pi1'
  alias box='ssh box'
  alias srv='ssh srv'
  alias wrt='ssh wrt'
  alias home='ssh home'
  alias retro='ssh retropie'
  
# }}}

# Networking {{{

alias scanwifi='sudo iw wlp1s0 interface add mon0 type monitor; sudo horst -i mon0 creset'
alias lan='sudo dhcpcd enp0s20u1'
alias ping='ping -c 5'

# }}}

# Search {{{

alias aw='awman'
alias ws='awman'
alias g="s -p duckduckgo"
alias wi="s -p wikipedia"
alias yt="s -p youtube"

# }}}

# Get Info {{{

alias keys='xmodmap -pke'
alias xev="xev | grep -A2 --line-buffered '^KeyRelease' | sed -n '/keycode /s/^.*keycode \([0-9]*\).* (.*, \(.*\)).*$/\1 \2/p'"
alias xp='xprop | grep "WM_WINDOW_ROLE\|WM_CLASS" && echo "WM_CLASS(STRING) = \"NAME\", \"CLASS\""'
alias batt='acpi -bt'
alias sysinfo='sudo inxi -Fflprxxxm'
alias weather='curl -4 wttr.in/epe,netherlands'

# https://github.com/dylanaraps/neofetch
alias nf="neofetch"
alias nfs="nf --image ~/pics/neofetch/"
alias nfa="nf --image ascii; echo"
alias nfn="c; nf --image off; echo"

# }}}

# Quick Edit Config Files {{{

alias mlist='sudo vi /etc/pacman.d/mirrorlist'
alias mgrub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias egrub='sudo vi /boot/grub/grub.cfg'
alias dgrub='sudo vi /etc/default/grub'
alias cgrub='sudo vi /etc/grub.d/40_custom'
alias sysx='sudo vi /boot/syslinux/syslinux.cfg'
alias fstab='sudo vi /etc/fstab'
alias pacnf='sudo vi /etc/pacman.conf'
alias infi='sudo vi /etc/X11/xinit/xinitrc.d/infinality-settings.sh'
alias wlan='sudo vi /etc/modprobe.d/ath9k.conf'
alias bashrc='vi ~/.bashrc'
alias profile='vi ~/.bash_profile'
alias xinitrc='vi ~/.xinitrc'
alias aliases='vi ~/.bash_aliases'
alias i3cnf='vi ~/.i3/config'
alias i3stat='vi ~/.i3status.conf'
alias i3blk='vim ~/.i3blocks.conf'

# }}}

# Jump to Directory {{{

alias blocks='cd ~/.i3/blocklets'
alias dots='cd ~/dotfiles; git status'
alias bin='cd ~/bin'
alias lbin='cd ~/.local/bin'

# }}}

# Quick Fix {{{

alias fixchrome='rm ~/.config/chromium/SingletonLock'
alias fixpulse='rm -rf /tmp/pulse* ~/.pulse* ~/.config/pulse; pulseaudio --kill'

# }}}

# Sound Control {{{

alias aeq='alsamixer -D equal'
alias mix='alsamixer -c 0'

# }}}

# Multimedia {{{

alias bctl="bluetoothctl"
alias gl="glxinfo | grep -i opengl && glxgears"
alias drm="dmesg | grep drm"
alias mp3='parallel -j4 ffmpeg -i {} -qscale:a 0 {.}.mp3 ::: *.flac *.m4a'

# }}}

# Other Stuff/ Fun {{{
alias gitlog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias nb='newsbeuter'
alias starwars='telnet towel.blinkenlights.nl'
alias matrix='echo -e "\e[32m"; while :; do for i in {1..16}; do r="$(($RANDOM % 2))"; if [[ $(($RANDOM % 5)) == 1 ]]; then if [[ $(($RANDOM % 4)) == 1 ]]; then v+="\e[1m $r   "; else v+="\e[2m $r   "; fi; else v+="     "; fi; done; echo -e "$v"; v=""; done'

# }}}

