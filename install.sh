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
  echo "Example: $0 vim zsh python bash flask dynamodb"
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
  echo "TODO - install pip modules"
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
  cd ~/.vim/bundle/YouCompleteMe && ./install.py
  mkdir ~/.vim/syntax
  cd ~/.vim/syntax && wget https://raw.githubusercontent.com/ClockworkNet/vim-junos-syntax/master/syntax/junos.vim
}

function zshsetup() {
  echo "zsh"
  if [ -L ~/.zshrc ]; then
    rm ~/.zshrc
  fi
  if [ -L ~/.zshenv ]; then
    rm ~/.zshenv
  fi
  if [ -L ~/.aliases ]; then
    rm ~/.aliases
  fi
  if [ -f ~/.zshrc ]; then
    mv ~/.zshrc $BACKUP_DIR/zshrc-$(date +%s)
  fi
  if [ -f ~/.zshenv ]; then
    mv ~/.zshenv $BACKUPDIR/zshenv-$(date +%s)
  fi
  if [ -f ~/.aliases ]; then
    mv ~/.aliases $BACKUPDIR/aliases-$(date +%s)
  fi
  ln -s $DOTFILES/aliases ~/.aliases
  ln -s $DOTFILES/zshrc ~/.zshrc
  ln -s $DOTFILES/zshenv ~/.zshenv
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
}

function flasksetup() {
    echo "flask"
    if [ -L ~/.flask ]; then
        rm ~/.flask
    fi
    if [ -d ~/.flask ]; then
        mv ~/.flask $BACKUP_DIR/flask-$(date +%s)
    fi
    if [ ! -d ~/Workspace/bin ]; then
        mkdir -p ~/Workspace/bin
    fi
    cp -r $DOTFILES/flask ~/.flask
    echo "TODO - put nginx-proxy.conf into /etc/nginx/conf.d"
}

function dynamodbsetup() {
    echo "dynamodb"
    if [ -L ~/.dynamodb ]; then
        rm ~/.dynamodb
    fi
    if [ -d ~/.dynamodb ]; then
        mv ~/.dynamodb $BACKUP_DIR/dynamodb-$(date +%s)
    fi
    mkdir ~/.dynamodb
    cd ~/.dynamodb
    wget https://s3-us-west-2.amazonaws.com/dynamodb-local/dynamodb_local_latest.zip
    unzip dynamodb_local_latest.zip
    echo "TODO - ensure java 1.8 is installed and on path"
}

function allsetup() {
  echo "all"
  vimsetup
  pysetup
  zshsetup
  bashsetup
  flasksetup
  dynamodbsetup
}

### Verify and run input selections

for i in $@; do
  case "$i" in
    vim) vimsetup;;
    python) pysetup;;
    zsh) zshsetup;;
    bash) bashsetup;;
    flask) flasksetup;;
    dynamodb) dynamodbsetup;;
    all) allsetup;;
    *) echo "Invalid name. Names: vim, zsh, bash, python, flask, dynamodb, all";;
  esac
done

### Clean exit
exit 0
