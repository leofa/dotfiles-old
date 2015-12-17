#!/usr/bin/env bash
set -e

ask() {
  # http://djm.me/ask
  while true; do

    if [ "${2:-}" = "Y" ]; then
      prompt="Y/n"
      default=Y
    elif [ "${2:-}" = "N" ]; then
      prompt="y/N"
      default=N
    else
      prompt="y/n"
      default=
    fi

    # ask the question
    read -p "$1 [$prompt] " REPLY

    # default?
    if [ -z "$REPLY" ]; then
       REPLY=$default
    fi

    # check if the reply is valid
    case "$REPLY" in
      Y*|y*) return 0 ;;
      N*|n*) return 1 ;;
    esac

  done
}

dir=`pwd`
if [ ! -e "${dir}/${0}" ]; then
  echo "Script not called from within repository directory. Aborting."
  exit 2
fi
dir="${dir}/.."

# install dependencies / restore backup

ask "Restore a backup?" Y && bash ./restore-backup

ask "Install base dependencies?" Y && bash ./install-arch-base

ask "Install Xorg, Chromium, i3WM and a small set of GUI apps?" Y && bash ./i3-environment 

ask "Install Acer c720p chromebook fixes?" Y && bash ./c720p-config

ask "Install Numix-Slate theme + Flattr icon mod by leofa?" Y && mkdir -p ~/.local/share/icons/Flattr-mod; tar -xvC ~/.local/share/icons/Flattr-mod/ -zxvf ~/dotfiles/resources/flattr-icon-mod.tar.gz; sudo tar -xvC /usr/share/themes -zxvf ~/dotfiles/resources/numix-slate-gtk-mod.tar.gz 

# symlink dotfiles

ask "Install symlinks for bash?" Y && ln -sfn ${dir}/.bashrc ${HOME}/.bashrc; ln -sfn ${dir}/.bash_aliases ${HOME}/.bash_aliases; ln -sfn ${dir}/.bash_profile ${HOME}/.bash_profile; ln -sfn ${dir}/.shell_prompt.sh ${HOME}/.shell_prompt.sh
# TODO reorganize to .bash.d/
#ask "Install symlink for .bash.d/?" Y && ln -sfn ${dir}/.bash.d ${HOME}/.bash.d

# use /bin/cp to avoid an alias like "cp -i"
ask "Copy all .config files?" Y && mkdir -p ${HOME}/.config; /bin/cp -ur ${dir}/.config/* ${HOME}/.config/

ask "Install symlinks for .gitconfig?" Y && ln -sfn ${dir}/.gitconfig ${HOME}/.gitconfig 

ask "Install symlink for .gtkrc-2.0?" Y && ln -sfn ${dir}/.gtkrc-2.0 ${HOME}/.gtkrc-2.0

ask "Install symlink for .i3/?" Y && ln -sfn ${dir}/.i3 ${HOME}/.i3

ask "Install symlinks for i3blocks?" Y && ln -sfn ${dir}/.i3blocks.conf ${HOME}/.i3blocks.conf; ln -sfn ${dir}/.i3blocks ${HOME}/.i3blocks

ask "Install symlink for .local/bin/?" Y && mkdir -p ${HOME}/.local; ln -sfn ${dir}/.local/bin ${HOME}/.local/bin

ask "Install symlinks for tmux?" Y && ln -sfn ${dir}/.tmux.conf ${HOME}/.tmux.conf; ln -sfn ${dir}/.tmux_prompt.sh ${HOME}/.tmux_prompt.sh

ask "Install symlinks for .vim?" Y && ln -sfn ${dir}/.vimrc ${HOME}/.vimrc; ln -sfn ${dir}/.vim ${HOME}/.vim; ln -sfn ${dir}/.gvimrc ${HOME}/.gvimrc 

ask "Install symlink for .xinitrc?" Y && ln -sfn ${dir}/.xinitrc ${HOME}/.xinitrc

ask "Install symlink for .Xresources, .dircolors?" Y && ln -sfn ${dir}/.Xresources ${HOME}/.Xresources; ln -sfn ${dir}/.dircolors ${HOME}/.dircolors

echo "Finished... read post-install.txt" 
