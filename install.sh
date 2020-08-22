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
  if [ ! -d ~/.config ]; then
    mkdir ~/.config
  fi
  if [ ! -d ~/.config/i3 ]; then
    mkdir ~/.config/i3
  fi
  if [ ! -d ~/.config/i3status ]; then
    mkdir ~/.config/i3status
  fi
  if [ ! -d ~/.config/terminator ]; then
    mkdir ~/.config/terminator
  fi
  if [ -f ~/.config/i3/config ]; then
    mv ~/.config/i3/config $BACKUP_DIR/i3-$(date +%s)
  fi
  if [ -L ~/.config/i3/config ]; then
    rm ~/.config/i3/config
  fi
  if [ -f ~/.config/i3status/config ]; then
    mv ~/.config/i3status/config $BACKUP_DIR/i3status-$(date +%s)
  fi
  if [ -L ~/.config/i3status/config ]; then
    rm ~/.config/i3status/config
  fi
  if [ -f ~/.config/terminator/config ]; then
    mv ~/.config/terminator/config $BACKUP_DIR/terminator-$(date +%s)
  fi
  if [ -L ~/.config/terminator/config ]; then
    rm ~/.config/terminator/config
  fi
  if [ -f ~/.config/compton/compton.conf ]; then
    mv ~/.config/compton/compton.conf $BACKUP_DIR/compton-$(date +%s)
  fi
  if [ -L ~/.config/compton/compton.conf ]; then
    rm ~/.config/compton/compton.conf
  fi
  if [ ! -d ~/bin ]; then
      mkdir ~/bin
  fi
  if [ -f ~/bin/spotify_wrap.sh ]; then
    rm ~/bin/spotify_wrap.sh
  fi
  if [ -f ~/bin/wallpaper.sh ]; then
    rm ~/bin/wallpaper.sh
  fi
  ln -s $DOTFILES/i3/config ~/.config/i3/config
  ln -s $DOTFILES/i3status/config ~/.config/i3status/config
  ln -s $DOTFILES/terminator/config ~/.config/terminator/config
  ln -s $DOTFILES/i3/compton.conf ~/.config/compton/compton.conf
  ln -s $DOTFILES/i3/wallpaper.sh ~/bin/wallpaper.sh
  ln -s $DOTFILES/spotify_wrap.sh ~/bin/spotify_wrap.sh
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
  if [ ! -d ~/Workspace/go ]; then
      mkdir ~/Workspace/go
  fi
  if [ ! -d ~/Workspace/go/src ]; then
      mkdir ~/Workspace/go/src
  fi
  if [ ! -d ~/Workspace/go/bin ]; then
      mkdir ~/Workspace/go/bin
  fi
  if [ ! -d ~/Workspace/go/pkg ]; then
      mkdir ~/Workspace/go/pkg
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
