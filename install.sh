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
    mv ~/.vimrc $BACKUP_DIR/vimrc-$(date +%s)
  fi
  if [ -d ~/.vim ]; then
    mv ~/.vim $BACKUP_DIR/vim-$(date +%s)
  fi
  git clone https://github.com/gmarik/vundle.vim ~/.vim/bundle/vundle
  ln -s $DOTFILES/vimrc ~/.vimrc
  vim +PluginInstall +qall
}

function zshsetup() {
  echo "zsh"
  if [ -L ~/.zshrc ]; then
    rm ~/.zshrc
  fi
  if [ -L ~/.zshenv ]; then
    rm ~/.zshenv
  fi
  if [ -f ~/.zshrc ]; then
    mv ~/.zshrc $BACKUP_DIR/zshrc-$(date +%s)
  fi
  if [ -f ~/.zshenv ]; then
    mv ~/.zshenv $BACKUPDIR/zshenv-$(date +%s)
  fi
  ln -s $DOTFILES/zshrc ~/.zshrc
  ln -s $DOTFILES/zshenv ~/.zshenv
}

function openboxsetup() {
  echo "openbox"
}

function conkysetup() {
  echo "conky"
  if [ -L ~/.conkyrc ]; then
    rm ~/.conkyrc
  fi
  if [ -f ~/.conkyrc ]; then
    mv ~/.conkyrc $BACKUP_DIR/conkyrc-$(date +%s)
  fi
  ln -s $DOTFILES/conkyrc ~/.conkyrc
}

function wbarsetup() {
  echo "wbar"
  if [ -L ~/.wbar ]; then
    rm ~/.wbar
  fi
  if [ -f ~/.wbar ]; then
    mv ~/.wbar $BACKUP_DIR/wbar-$(date +%s)
  fi
  ln -s $DOTFILES/wbar ~/.wbar
}

function tint2setup() {
  echo "tint2"
  if [ -L ~/.config/tint2/tint2rc ]; then
    rm ~/.config/tint2/tint2rc
  fi
  if [ -f ~/.config/tint2/tint2rc ]; then
    mv ~/.config/tint2/tint2rc $BACKUP_DIR/tint2rc-$(date +%s)
  fi
  ln -s $DOTFILES/tint2rc ~/.config/tint2/tint2rc
}

function gtk2setup() {
  echo "gtk2"
  if [ -L ~/.gtkrc-2.0 ]; then
    rm ~/.gtkrc-2.0
  fi
  if [ -f ~/.gtkrc-2.0 ]; then
    mv ~/.gtkrc-2.0 $BACKUP_DIR/gtkrc-2.0-$(date +%s)
  fi
  ln -s $DOTFILES/gtkrc-2.0 ~/.gtkrc-2.0
}

function allsetup() {
  echo "all"
  vimsetup
  zshsetup
  openboxsetup
  conkysetup
  wbarsetup
  tint2setup
  gtk2setup
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
