#!/bin/bash

# Script will install dot-files based on input
#
# Example: ./install.sh vim zsh python
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
  echo "Example: $0 vim zsh python"
  echo
  exit 1
fi

### Functions

function pysetup() {
  echo "python"
  if [ -f ~/.pythonrc ]; then
    mv ~/.pythonrc $BACKUP_DIR/pythonrc-$(date +%s)
  fi
  if [ -L ~/.pythonrc ]; then
    rm ~/.pythonrc
  fi
  ln -s $DOTFILES/pythonrc ~/.pythonrc
}

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

function allsetup() {
  echo "all"
  vimsetup
  pysetup
  zshsetup
}

### Verify and run input selections

for i in $@; do
  case "$i" in
    vim) vimsetup;;
    python) pysetup;;
    zsh) zshsetup;;
    all) allsetup;;
    *) echo "Invalid name. Names: vim, zsh, python, all";;
  esac
done

### Clean exit
exit 0
