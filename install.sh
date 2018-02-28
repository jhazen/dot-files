#!/bin/bash

# Script will install dot-files based on input
#
# Example: ./install.sh vim bash python
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
  echo "Example: $0 vim python bash"
  echo
  exit 1
fi

### Functions

function pysetup() {
  echo "python"
  if [ -f ~/.pythonrc.py ]; then
    mv ~/.pythonrc.py $BACKUP_DIR/pythonrc.py-$(date +%s)
  fi
  if [ -L ~/.pythonrc.py ]; then
    rm ~/.pythonrc.py
  fi
  ln -s $DOTFILES/pythonrc.py ~/.pythonrc.py
  sudo pip3 install numpy scapy-python3 paramiko boto3 urllib3 netaddr PyYaml requests flask django jedi virtualenv unqlite neovim flake8
  sudo pip2 install neovim flake8
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
  # No more YCM
  #cd ~/.vim/bundle/YouCompleteMe && ./install.py
  mkdir ~/.vim/syntax
  cd ~/.vim/syntax && wget https://raw.githubusercontent.com/ClockworkNet/vim-junos-syntax/master/syntax/junos.vim
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
  if [ -d ~/.autoenv ]; then
    rm -Rf ~/.autoenv
  fi
  git clone git://github.com/kennethreitz/autoenv.git ~/.autoenv
  if [ ! -d ~/bin ]; then
      mkdir ~/bin
  fi
  if [ ! -d ~/.bin ]; then
      mkdir ~/.bin
  fi
  if [ -L ~/bin/vimrun.sh ]; then
    rm ~/bin/vimrun.sh
  fi
  if [ -f ~/bin/vimrun.sh ]; then
    mv ~/vimrun.sh $BACKUP_DIR/vimrun.sh-$(date +%s)
  fi
  ln -s $DOTFILES/vimrun.sh ~/bin/vimrun.sh
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
  pysetup
  bashsetup
}

### Verify and run input selections

for i in $@; do
  case "$i" in
    vim) vimsetup;;
    python) pysetup;;
    bash) bashsetup;;
    all) allsetup;;
    *) echo "Invalid name. Names: vim, bash, python, all";;
  esac
done

### Clean exit
exit 0
