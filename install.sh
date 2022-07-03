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


function i3setup() {
  echo "i3"
  if [ ! -d ~/.config ]; then
    mkdir ~/.config
  fi
  if [ ! -d ~/.config/i3 ]; then
    mkdir ~/.config/i3
  fi
  if [ ! -d ~/.config/compton ]; then
    mkdir ~/.config/compton
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
  if [ -f ~/bin/packet-loss.sh ]; then
    rm ~/bin/packet-loss.sh
  fi
  if [ -f ~/bin/wallpaper.sh ]; then
    rm ~/bin/wallpaper.sh
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
  ln -s $DOTFILES/packet-loss.sh ~/bin/packet-loss.sh
}

function vimsetup() {
  echo "vim"
  if [ -f ~/.vimrc ]; then
    mv ~/.vimrc $BACKUP_DIR/vimrc-$(date +%s)
  fi
  if [ -L ~/.vimrc ]; then
    rm ~/.vimrc
  fi
  if [ -f ~/.vimspector.json ]; then
    mv ~/.vimspector.json $BACKUP_DIR/vimspector.json-$(date +%s)
  fi
  if [ -L ~/.vimspector.json ]; then
    rm ~/.vimspector.json
  fi
  if [ -d ~/.vim ]; then
    mv ~/.vim $BACKUP_DIR/vim-$(date +%s)
  fi
  git clone https://github.com/gmarik/vundle.vim ~/.vim/bundle/vundle
  ln -s $DOTFILES/vimrc ~/.vimrc
  ln -s $DOTFILES/.vimspector.json ~/.vimspector.json
  nvim -u ~/.vimrc +PluginInstall +qall
  cd ~/.vim/bundle/vundle/syntax
  wget https://raw.githubusercontent.com/Leandros/dotfiles/master/.vim/syntax/rgbds.vim
  cd - &> /dev/null
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
  if [ -L ~/bin/build_wrap.sh ]; then
    rm ~/bin/build_wrap.sh
  fi
  if [ -f ~/bin/build_wrap.sh ]; then
    mv ~/build_wrap.sh $BACKUP_DIR/build_wrap.sh-$(date +%s)
  fi
  ln -s $DOTFILES/build_wrap.sh ~/bin/build_wrap.sh
  if [ -L ~/bin/startVM.sh ]; then
    rm ~/bin/startVM.sh
  fi
  if [ -f ~/bin/startVM.sh ]; then
    mv ~/startVM.sh $BACKUP_DIR/startVM.sh-$(date +%s)
  fi
  ln -s $DOTFILES/startVM.sh ~/bin/startVM.sh
  if [ -L ~/bin/task.py ]; then
    rm ~/bin/task.py
  fi
  if [ -f ~/bin/task.py ]; then
    mv ~/task.py $BACKUP_DIR/task.py-$(date +%s)
  fi
  ln -s $DOTFILES/task.py ~/bin/task.py
  if [ -L ~/bin/shot.sh ]; then
    rm ~/bin/shot.sh
  fi
  if [ -f ~/bin/shot.sh ]; then
    mv ~/shot.sh $BACKUP_DIR/shot.sh-$(date +%s)
  fi
  ln -s $DOTFILES/shot.sh ~/bin/shot.sh
  mkdir -p ~/.config/xfce4/xfconf/xfce-perchannel-xml/
  if [ -L ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml ]; then
    rm ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml
  fi
  if [ -f ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml ]; then
    mv ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml $BACKUP_DIR/xfce4-power-manager.xml-$(date +%s)
  fi
  ln -s $DOTFILES/xfc4/xfce4-power-manager.xml ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml
  if [ -f /etc/os-release ]; then
    source /etc/os-release
    if [[ $NAME = "Ubuntu" ]]; then
      sudo add-apt-repository ppa:neovim-ppa/stable
      sudo apt update
      sudo apt install neovim cmake exuberant-ctags python3.9 terminator imagemagick pandoc texlive-latex-extra neofetch feh
      pip3 install neovim
    elif [[ $NAME = "Arch Linux" || $NAME = "Manjaro Linux" ]]; then
      sudo pacman -Syyu
      sudo pacman -S neovim wget cmake ctags i3-gaps terminator compton networkmanager-openvpn network-manager-applet xfce4-power-manager thunar chromium lxappearance imagemagick pandoc texlive-latexextra neofetch feh i3status dmenu openssh
      pip3 install neovim
    elif [[ $NAME = "openSUSE Tumbleweed" ]]; then
      sudo zypper install neovim cmake ctags i3-gaps terminator compton NetworkManager-applet vlc discord virtualbox python3-virtualbox xfce4-power-manager clipit blueman spotify-easyrpm thunar chromium lxappearance ImageMagick pandoc texlive-latex neofetch playerctl feh go gcc gcc-c++ kernel-source kernel-syms make pasystray clamav thunar-sendto-clamtk clamtk rkhunter cronie-anacron remmina gimp grafx2
      sudo systemctl enable bluetooth
      sudo systemctl enable clamav
      sudo systemctl enable freshclam.timer
      sudo cp $DOTFILES/rkup.sh /etc/cron.daily/
      pip3 install neovim
    else
      sudo apt update
      sudo apt install neovim cmake exuberant-ctags python3.9 i3-gaps terminator imagemagick pandoc texlive-latex-extra neofetch i3lock feh lxappearance chromium-bsu clipit golang python3-pip remmina
      pip3 install neovim
    fi
  fi
}

function devsetup() {
    # Install Mesen-S and Mesen
    sudo apt install -y mono-complete wine &> /dev/null
    curl -s -L https://github.com/SourMesen/Mesen-S/releases/download/0.4.0/Mesen-S.0.4.0.zip -o ~/Downloads/Mesen-S.zip
    cd ~/Downloads &> /dev/null
    unzip Mesen-S.zip &> /dev/null
    curl -s -L https://github.com/SourMesen/Mesen/releases/download/0.9.9/Mesen.0.9.9.zip -o ~/Downloads/Mesen.zip
    unzip Mesen.zip &> /dev/null
    cd - &> /dev/null
    cp $DOTFILES/shortcuts/mesen* ~/.local/share/applications/ &> /dev/null
    # Install bsnes
    sudo apt install -y gnome-software-plugin-flatpak &> /dev/null
    sudo apt install -y flatpak &> /dev/null
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    sudo flatpak install -y bsnes &> /dev/null
    # Install snes9x
    sudo flatpak install -y snes9x &> /dev/null
    cp /var/lib/flatpak/exports/share/applications/*.desktop ~/.local/share/applications/
    # Install gb studio
    sudo apt install -y gb-studio &> /dev/null
    # Install tilemap studio
    sudo apt install -y make g++ git autoconf &> /dev/null
    sudo apt install -y zlib1g-dev libpng-dev libxpm-dev libx11-dev libxft-dev libxinerama-dev libfontconfig1-dev x11proto-xext-dev libxrender-dev libxfixes-dev &> /dev/null
    cd ~/Workspace &> /dev/null
    git clone https://github.com/Rangi42/tilemap-studio.git &> /dev/null
    cd tilemap-studio &> /dev/null
    git clone --branch release-1.3.7 --depth 1 https://github.com/fltk/fltk.git &> /dev/null
    pushd fltk &> /dev/null
    ./autogen.sh --prefix="$PWD/.." --with-abiversion=10307 &> /dev/null
    make &> /dev/null
    make install &> /dev/null
    popd &> /dev/null
    export PATH="$PWD/bin:$PATH" &> /dev/null
    make &> /dev/null
    sudo make install &> /dev/null
    cd - &> /dev/null
    # Install gb tile designer
    cd ~/Workspace &> /dev/null
    unzip $DOTFILES/binaries/gbtd.zip &> /dev/null
    cp $DOTFILES/shortcuts/GBTD* ~/.local/share/applications/ &> /dev/null
    cd - &> /dev/null
    # Install gb map builder
    cd ~/Workspace &> /dev/null
    unzip $DOTFILES/binaries/gbmb.zip &> /dev/null
    cp $DOTFILES/shortcuts/GBMB* ~/.local/share/applications/ &> /dev/null
    cd - &> /dev/null
    # Install bgb
    cd ~/Workspace &> /dev/null
    unzip $DOTFILES/binaries/bgb.zip &> /dev/null
    cp $DOTFILES/shortcuts/bgb* ~/.local/share/applications/ &> /dev/null
    ln -s $DOTFILES/bgb ~/bin/bgb &> /dev/null
    ln -s ~/bin/bgb64 ~/bin/bgb &> /dev/null
    chmod +x ~/bin/bgb* &> /dev/null
    cd - &> /dev/null
    # Install ca65
    cd ~/Workspace &> /dev/null
    git clone https://github.com/cc65/cc65.git &> /dev/null
    cd cc65/ &> /dev/null
    make &> /dev/null
    sudo make install &> /dev/null
    cd - &> /dev/null
    # Install wla-65816
    cd ~/Workspace &> /dev/null
    git clone https://github.com/vhelin/wla-dx &> /dev/null
    cd wla-dx/ &> /dev/null
    mkdir build &> /dev/null
    cd build/ &> /dev/null
    cmake .. &> /dev/null
    cmake --build . --config Release &> /dev/null
    sudo cmake -P cmake_install.cmake -DCMAKE_INSTALL_PREFIX=/usr/local &> /dev/null
    cd - &> /dev/null
    # Install rbgasm
    cd ~/Workspace &> /dev/null
    sudo apt install -y bison libpng-dev libpng-tools libpng-tools &> /dev/null
    git clone https://github.com/gbdev/rgbds &> /dev/null
    cd rgbds/ &> /dev/null
    make clean &> /dev/null
    make &> /dev/null
    sudo make install &> /dev/null
    cd - &> /dev/null
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
    i3) i3setup;;
    dev) devsetup;;
    all) allsetup;;
    *) echo "Invalid name. Names: vim, bash, i3, dev, all";;
  esac
done

### Clean exit
exit 0
