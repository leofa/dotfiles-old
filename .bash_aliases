#mijn bash aliases
#
alias pauze='sudo pm-suspend'
alias U='echo "Pacman backup..."; pacbup; echo "done"; echo " "; echo "Read news/ Pacman update..."; pacupd; echo "done" ;echo " "' 
alias Us='echo "Pacman backup..."; pacbup; echo "done"; echo " ";echo "Pacman sync..."; pacaur -Syy; echo "done" ;echo " ";echo "Read news/ Pacman update..."; pacupd; echo "done" ;echo " "'
alias Un='pacaur -Su --noconfirm --noedit'
alias Ud='pacaur -Su --aur --devel'
alias S='pacaur -Ss'
alias Sy='pacaur -Syy'
alias I='pacaur -S'
alias Pi='pacaur -Si'
alias Pd='pacaur -d'
alias Pe='pacaur -e' 
alias Id='pacaur -S --asdeps'
alias In='pacaur -S --noedit --noconfirm --needed'
alias R='pacaur -Rns'
alias Rs='sudo pacaur -Rns $(pacaur -Qtdq)'
alias h='history'
alias c='clear'
alias r='reset'
alias refr='refl; sudo rm -r /var/lib/pacman/db.lck; sudo pacman-key --init; sudo pacman-key --populate archlinux; sudo pacman-key --refresh-keys; sudo pacman-optimize'
alias Cc='yaourt -C; sudo pkgcacheclean -v; pacaur -Scc --noconfirm'
alias disks='df -h; btrfs filesystem df /'
alias dd='dcfldd'
alias gksu='gksu-polkit'
alias refl='sudo reflector --verbose --country 'Netherlands' -l 200 -p http --sort rate --number 3 --save /etc/pacman.d/mirrorlist; cat /etc/pacman.d/mirrorlist'
alias Yl='yaourt -Qm' #lokale pakketen
alias Yf='yaourt -Qet' #niet standaard foreign
alias err='dmesg -l err; systemctl --failed'
alias warn='dmesg -l warn'
alias blame='systemd-analyze; systemd-analyze blame'
alias log='journalctl -f | ccze -A' #follow log
alias log0='journalctl -b -0 | ccze -A' #current log 
alias log1='journalctl -b -1 | ccze -A' #previous log
alias mirr='sudo vi /etc/pacman.d/mirrorlist'
alias mgrub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias egrub='sudo vi /boot/grub/grub.cfg'
alias dgrub='sudo vi /etc/default/grub'
alias cgrub='sudo vi /etc/grub.d/40_custom'
alias sysx='sudo vi /boot/syslinux/syslinux.cfg'
alias fstab='sudo vi /etc/fstab'
alias pacnf='sudo vi /etc/pacman.conf'
alias infi='sudo vi /etc/X11/xinit/xinitrc.d/infinality-settings.sh'
alias iotop='sudo iotop -oPa'
alias wlan='sudo vi /etc/modprobe.d/ath9k.conf'
alias bashrc='vi ~/.bashrc'
alias xinitrc='vi ~/.xinitrc'
alias aliases='vi ~/.bash_aliases'
alias pkgaur='pacman -Qemq'
alias scrot='scrot -d 3 -c -q 100 ~/Afbeeldingen/Schermafdruk/Schermafdruk_%d-%m-%y.png'
alias bat='acpi -bt'
alias x='exit'
alias vi='vim'
alias big='ncdu -x'
alias sysinfo='sudo inxi -Fflprxxxm'
alias pacdep='pacman -Qdt'
alias pacexp='pacman -Qet'
alias fixchrome='rm /home/faruk/.config/chromium/SingletonLock'
alias fixpulse='rm -rf /tmp/pulse* ~/.pulse* ~/.config/pulse; pulseaudio --kill; pulseaudio --start; echo Pulseaudio has been reset.'
alias i3cnf='vi ~/.i3/config'
alias i3stat='vi ~/.i3status.conf'
alias aeq='alsamixer -D equal'
alias mix='alsamixer -c 0'
alias lap='ssh faruk@192.168.1.114'
alias osmc='ssh osmc@192.168.1.113'
alias pi2='ssh faruk@192.168.1.112'
alias pi1='ssh faruk@192.168.1.111'
alias box='ssh faruk@192.168.1.110'
alias srv='ssh faruk@192.168.1.10'
alias keys='xmodmap -pke'
alias freemem='sudo /sbin/sysctl -w vm.drop_caches=3'
#alias startx='startx -- -keeptty -nolisten tcp > ~/.xorg.log 2>&1'
alias lan='sudo dhcpcd enp0s20u1'
alias mp3='parallel -j4 ffmpeg -i {} -qscale:a 0 {.}.mp3 ::: *.flac *.m4a'
alias i3blk='vim ~/.i3blocks.conf'
alias xp='xprop | grep "WM_WINDOW_ROLE\|WM_CLASS" && echo "WM_CLASS(STRING) = \"NAME\", \"CLASS\""'
alias flash_rom='cd; rm -f ~/flash_chromebook_rom.sh; curl -L -O https://johnlewis.ie/flash_chromebook_rom.sh; sudo -E bash flash_chromebook_rom.sh'
alias ws='wiki-search'
alias bin='cd ~/.local/bin'
alias blocks='cd ~/.i3blocks/scripts'
alias tetris='vitetris'
alias news='newsbeuter' 
alias dots='cd ~/dotfiles; git status'
alias scanwifi='sudo iw wlp1s0 interface add mon0 type monitor; sudo horst -i mon0 creset'
alias ct='colortheme'
alias twt='turses'

# Saves journal logs to file
getlog() { local file=~/logs/system/log-$(date +%Y%m%d-%H:%M).txt; sudo journalctl -b > "$file" && gvim "$file"; }

#cups
alias startprint="systemctl start org.cups.cupsd.service"
alias stopprint="systemctl stop org.cups.cupsd.service"

# Disk activity
alias diskact="sudo iotop -Po"

# Look for high priority errors in the systemd journal
alias errors="sudo journalctl -p 0..3 -xn"

## Make Bash error tollerant ## {{{
alias :q=' exit'
alias :Q=' exit'
alias :x=' exit'
alias cd..='cd ..'
# }}}

    #AUTOCOLOR
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'

    #MODIFIED COMMANDS
    alias ..='cd ..'
    alias df='df -h'
    alias diff='colordiff'              # requires colordiff package
    alias du='du -c -h'
    alias free='free -m'                # show sizes in MB
    alias grep='grep --color=auto'
    alias grep='grep --color=tty -d skip'
    alias mkdir='mkdir -p -v'
    alias more='less'
    alias nano='nano -w'
    alias ping='ping -c 5'
#
    #PACMAN ALIASES
    # we're on ARCH
    if $_isarch; then
      # we're not root
      if ! $_isroot; then
        alias pacman='sudo pacman'
      fi
      alias Iu='pacaur -U'              # Install specific local package(s)
      alias Pi='pacaur -Si'            # Display information about a given package in the repositories
      alias Upa='pacaur -Sy && sudo abs' # Update and refresh the local package and ABS databases against repositories
      alias Id='pacaur -S --asdeps'     # Install given package(s) as dependencies of another package
      alias Pm="makepkg -fcsi"         # Make package from PKGBUILD file in current directory
    fi
# 
    # LS
    alias ls='ls -hF --color=auto'
    alias lr='ls -R'                    # recursive ls
    alias ll='ls -alh'
    alias la='ll -A'
    alias lm='la | less'
##
