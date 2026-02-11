#!/bin/bash

# Script will install dot-files based on input
#
# Example: ./install.sh vim bash i3 dev
#
# jhazen532@gmail.com

### Variables

DOTFILES=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
BACKUP_DIR=~/.dot-files-bak

### Ensure backup dir exists so it doesn't complain
if [ ! -d $BACKUP_DIR ]; then
  mkdir $BACKUP_DIR
fi

### Ensure correct usage

if [ $# -lt 1 ]; then
  echo "Usage: $0 <name> <name> ..."
  echo "Example: $0 vim bash i3 dev"
  echo
  exit 1
fi

### Functions



function vimsetup() {
  echo "vim"
  rm -rf ~/.config/nvim
  rm -rf ~/.vim
  rm -rf ~/.vimrc
  ln -s $DOTFILES/nvim ~/.config/nvim
}

function bashsetup() {
  echo "bash"
  if [ -L ~/.bashrc ]; then
    rm ~/.bashrc
  fi
  if [ -L ~/.aliases ]; then
    rm ~/.aliases
  fi
  if [ -f ~/.bashrc ]; then
    mv ~/.bashrc $BACKUP_DIR/bashrc-$(date +%s)
  fi
  if [ -f ~/.aliases ]; then
    mv ~/.aliases $BACKUPDIR/aliases-$(date +%s)
  fi
  ln -s $DOTFILES/aliases ~/.aliases
  ln -s $DOTFILES/bashrc ~/.bashrc
  if [ ! -d ~/bin ]; then
      mkdir ~/bin
  fi
  if [ ! -d ~/.bin ]; then
      mkdir ~/.bin
  fi
  if [ -f ~/bin/shot.sh ]; then
    mv ~/shot.sh $BACKUP_DIR/shot.sh-$(date +%s)
  fi
  ln -s $DOTFILES/shot.sh ~/bin/shot.sh
  if [ -f /etc/os-release ]; then
    source /etc/os-release
    if [[ $NAME = "Ubuntu" ]]; then
      sudo add-apt-repository ppa:neovim-ppa/stable
      sudo apt update
      sudo apt install neovim cmake exuberant-ctags python3 terminator imagemagick pandoc texlive-latex-extra neofetch feh
      pip3 install neovim debugpy --break-system-packages
    fi
  fi
}

function allsetup() {
  echo "all"
  bashsetup
  vimsetup
  i3setup
  devsetup
}

### Verify and run input selections

for i in $@; do
  case "$i" in
    vim) vimsetup;;
    bash) bashsetup;;
    all) allsetup;;
    *) echo "Invalid name. Names: vim, bash, all";;
  esac
done

### Clean exit
exit 0
