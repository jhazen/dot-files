#!/bin/bash

# Script will install dot-files based on input
#
# Example: ./install.sh vim bash
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
  echo "Example: $0 vim bash"
  echo
  exit 1
fi

### Functions

function vimsetup() {
  echo "vim"
  if [ -f ~/.vimrc ]; then
    mv ~/.vimrc $BACKUP_DIR/vimrc-$(date +%s)
  fi
  if [ -L ~/.vimrc ]; then
    rm ~/.vimrc
  fi
  if [ -d ~/.vim ]; then
    mv ~/.vim $BACKUP_DIR/vim-$(date +%s)
  fi
  git clone https://github.com/gmarik/vundle.vim ~/.vim/bundle/vundle
  ln -s $DOTFILES/vimrc ~/.vimrc
  if [ ! -d /usr/local/go ]; then
      sudo mkdir /usr/local/go
      sudo chown $(whoami) /usr/local/go
  fi
  vim +PluginInstall +qall
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
  if [ ! -d ~/go ]; then
      mkdir ~/go
  fi
  if [ ! -d ~/go/src ]; then
      mkdir ~/go/src
  fi
  if [ ! -d ~/go/bin ]; then
      mkdir ~/go/bin
  fi
  if [ -L ~/bin/vimserver.py ]; then
    rm ~/bin/vimserver.py
  fi
  if [ -f ~/bin/vimserver.py ]; then
    mv ~/vimserver.py $BACKUP_DIR/vimserver.py-$(date +%s)
  fi
  ln -s $DOTFILES/vimserver.py ~/bin/vimserver.py
  if [ -L ~/bin/startVM.sh ]; then
    rm ~/bin/startVM.sh
  fi
  if [ -f ~/bin/startVM.sh ]; then
    mv ~/startVM.sh $BACKUP_DIR/startVM.sh-$(date +%s)
  fi
  ln -s $DOTFILES/startVM.sh ~/bin/startVM.sh
}

function allsetup() {
  echo "all"
  vimsetup
  bashsetup
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
