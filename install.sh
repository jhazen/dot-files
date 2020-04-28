#!/bin/bash

# Script will install dot-files based on input
#
# Example: ./install.sh vim bash i3
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
  echo "Example: $0 vim bash i3"
  echo
  exit 1
fi

### Functions


function i3setup() {
  echo "i3"
  if [ -f ~/.i3/config ]; then
    mv ~/.i3/config $BACKUP_DIR/i3-$(date +%s)
  fi
  if [ -L ~/.i3/config ]; then
    rm ~/.i3/config
  fi
  if [ ! -d ~/.i3 ]; then
    mkdir ~/.i3
  fi
  if [ ! -d ~/bin ]; then
      mkdir ~/bin
  fi
  if [ -f ~/bin/wallpaper.sh ]; then
    rm ~/bin/wallpaper.sh
  fi
  ln -s $DOTFILES/i3/config ~/.i3/config
  ln -s $DOTFILES/i3/wallpaper.sh ~/bin/wallpaper.sh
  ln -s $DOTFILES/i3/nordstart ~/bin/nordstart
  ln -s $DOTFILES/i3/nordstop ~/bin/nordstop
  if [ -f /usr/share/conky/conky_green ]; then
    sudo rm /usr/share/conky/conky_green
    sudo ln -s $DOTFILES/i3/conky_green /usr/share/conky/conky_green
  fi
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
  if [ ! -d /usr/local/go ]; then
      sudo mkdir /usr/local/go
      sudo chown $(whoami) /usr/local/go
  fi
  nvim -u ~/.vimrc +PluginInstall +qall
  #cd ~/.vim/bundle/YouCompleteMe
  #./install.py --clang-completer --java-completer --go-completer
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
  if [ -L ~/.radare2rc ]; then
    rm ~/.radare2rc
  fi
  if [ -f ~/.radare2rc ]; then
    mv ~/.radare2rc $BACKUPDIR/radare2rc-$(date +%s)
  fi
  ln -s $DOTFILES/radare2rc ~/.radare2rc
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
  if [ -L ~/bin/shot.sh ]; then
    rm ~/bin/shot.sh
  fi
  if [ -f ~/bin/shot.sh ]; then
    mv ~/shot.sh $BACKUP_DIR/shot.sh-$(date +%s)
  fi
  ln -s $DOTFILES/shot.sh ~/bin/shot.sh
}

function allsetup() {
  echo "all"
  vimsetup
  bashsetup
  i3setup
}

### Verify and run input selections

for i in $@; do
  case "$i" in
    vim) vimsetup;;
    bash) bashsetup;;
    i3) i3setup;;
    all) allsetup;;
    *) echo "Invalid name. Names: vim, bash, i3, all";;
  esac
done

### Clean exit
exit 0
