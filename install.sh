#!/bin/bash

# Script will install dot-files based on input
#
# Example: ./install.sh vim zsh openbox tint2 conky
#
# jhazen532@gmail.com

### Variables

DOTFILES=~/Workspace/dot-files
BACKUP_DIR=~/.dot-files-bak

### Ensure correct usage

if [ $# -lt 1 ]; then
  echo "Usage: $0 <name> <name> ..."
  echo "Example: $0 vim zsh openbox"
  echo
  exit 1
fi

### Functions

function vimsetup() {
  echo "vim"
  if [ -f ~/.vimrc ]; then
    mv ~/.vimrc $BACKUP_DIR/vimrc
  fi
  if [ -d ~/.vim ]; then
    mv ~/.vim $BACKUP_DIR/vim
  fi
  git clone https://github.com/gmarik/vundle.vim ~/.vim/bundle/vundle
  ln -s $DOTFILES/vimrc ~/.vimrc
  vim +PluginInstall +qall
}

function zshsetup() {
  echo "zsh"
}

function openboxsetup() {
  echo "openbox"
}

function conkysetup() {
  echo "conky"
}

function wbarsetup() {
  echo "wbar"
}

function tint2setup() {
  echo "tint2"
}

function gtk2setup() {
  echo "gtk2"
}

function allsetup() {
  echo "all"
}

### Verify and run input selections

for i in $@; do
  case "$i" in
    vim) vimsetup;;
    zsh) zshsetup;;
    openbox) openboxsetup;;
    conky) conkysetup;;
    wbar) wbarsetup;;
    tint2) tint2setup;;
    gtk2) gtk2setup;;
    all) allsetup;;
    *) echo "Invalid name. Names: vim, zsh, openbox, conky, wbar, tint2, gtk2, all";;
  esac
done

### Clean exit
exit 0
