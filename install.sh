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
  rm -rf ~/.config/nvim
  rm -rf ~/.vim
  mkdir -p ~/.config/nvim/lua
  ln -s ~/.config/nvim ~/.vim
  git clone https://github.com/VundleVim/Vundle.vim ~/.config/nvim/bundle/Vundle.vim
  ln -s $DOTFILES/vimrc ~/.config/nvim/main.vim
  ln -s $DOTFILES/init.lua ~/.config/nvim/init.lua
  ln -s ~/.local.vim ~/.config/nvim/local.vim
  ln -s ~/.local.lua ~/.config/nvim/lua/local.lua
  nvim +PluginInstall +qall
  cd ~/.vim/bundle/YouCompleteMe
  ./install.py
  cd - &> /dev/null
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
  if [ -L ~/bin/takeaways ]; then
    rm ~/bin/takeaways
  fi
  if [ -f ~/bin/takeaways ]; then
    mv ~/takeaways $BACKUP_DIR/takeaways-$(date +%s)
  fi
  ln -s $DOTFILES/takeaways ~/bin/takeaways
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
      pip3 install neovim --break-system-packages
    elif [[ $NAME = "Arch Linux" || $NAME = "Manjaro Linux" ]]; then
      sudo pacman -Syyu
      sudo pacman -S neovim wget cmake ctags i3-gaps terminator compton networkmanager-openvpn network-manager-applet xfce4-power-manager thunar chromium lxappearance imagemagick pandoc texlive-latexextra neofetch feh i3status dmenu openssh
      pip3 install neovim --break-system-packages

    elif [[ $NAME = "openSUSE Tumbleweed" ]]; then
      sudo zypper install neovim cmake ctags i3-gaps terminator compton NetworkManager-applet vlc discord virtualbox python3-virtualbox xfce4-power-manager clipit blueman spotify-easyrpm thunar chromium lxappearance ImageMagick pandoc texlive-latex neofetch playerctl feh go gcc gcc-c++ kernel-source kernel-syms make pasystray clamav thunar-sendto-clamtk clamtk rkhunter cronie-anacron gimp grafx2
      sudo systemctl enable bluetooth
      sudo systemctl enable clamav
      sudo systemctl enable freshclam.timer
      sudo cp $DOTFILES/rkup.sh /etc/cron.daily/
      pip3 install neovim --break-system-packages

    else
      sudo apt update
      sudo apt install neovim cmake exuberant-ctags universal-ctags terminator imagemagick pandoc texlive-latex-extra neofetch golang python3-pip
      pip3 install neovim --break-system-packages

    fi
  fi
}

function devsetup() {
    OS=`cat /etc/os-release | grep ID_LIKE | cut -d'"' -f2`
    if [[ $OS = "opensuse suse" ]]; then
        INSTALLER=zypper
        sudo $INSTALLER install -y xorg-x11-devel libX11-devel autoconf png++-devel libXScrnSaver make lsb
    else
        INSTALLER=apt
    fi
    # Install Mesen-S and Mesen
    sudo $INSTALLER install -y mono-complete wine 
    curl -s -L https://github.com/SourMesen/Mesen-S/releases/download/0.4.0/Mesen-S.0.4.0.zip -o ~/Downloads/Mesen-S.zip
    cd ~/Downloads 
    unzip Mesen-S.zip 
    curl -s -L https://github.com/SourMesen/Mesen/releases/download/0.9.9/Mesen.0.9.9.zip -o ~/Downloads/Mesen.zip
    unzip Mesen.zip 
    cd - 
    cp $DOTFILES/shortcuts/mesen* ~/.local/share/applications/ 
    # Install bsnes
    sudo $INSTALLER install -y gnome-software-plugin-flatpak 
    sudo $INSTALLER install -y flatpak 
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    sudo flatpak install -y bsnes 
    # Install snes9x
    sudo flatpak install -y snes9x 
    cp /var/lib/flatpak/exports/share/applications/*.desktop ~/.local/share/applications/
    # Install gb studio
    sudo $INSTALLER install -y gb-studio 
    # Install tilemap studio
    sudo $INSTALLER install -y make g++ git autoconf 
    sudo $INSTALLER install -y zlib1g-dev libpng-dev libxpm-dev libx11-dev libxft-dev libxinerama-dev libfontconfig1-dev x11proto-xext-dev libxrender-dev libxfixes-dev 
    cd ~/Workspace 
    git clone https://github.com/Rangi42/tilemap-studio.git 
    cd tilemap-studio 
    git clone --branch release-1.3.7 --depth 1 https://github.com/fltk/fltk.git 
    pushd fltk 
    ./autogen.sh --prefix="$PWD/.." --with-abiversion=10307 
    make 
    make install 
    popd 
    export PATH="$PWD/bin:$PATH" 
    make 
    sudo make install 
    cd - 
    # Install gb tile designer
    cd ~/Workspace 
    unzip $DOTFILES/binaries/gbtd.zip 
    cp $DOTFILES/shortcuts/GBTD* ~/.local/share/applications/ 
    cd - 
    # Install gb map builder
    cd ~/Workspace 
    unzip $DOTFILES/binaries/gbmb.zip 
    cp $DOTFILES/shortcuts/GBMB* ~/.local/share/applications/ 
    cd - 
    # Install bgb
    cd ~/Workspace 
    unzip $DOTFILES/binaries/bgb.zip 
    cp $DOTFILES/shortcuts/bgb* ~/.local/share/applications/ 
    ln -s $DOTFILES/bgb ~/bin/bgb 
    ln -s ~/bin/bgb64 ~/bin/bgb 
    chmod +x ~/bin/bgb* 
    cd - 
    # Install ca65
    cd ~/Workspace 
    git clone https://github.com/cc65/cc65.git 
    cd cc65/ 
    make 
    sudo make install 
    cd - 
    # Install wla-65816
    cd ~/Workspace 
    git clone https://github.com/vhelin/wla-dx 
    cd wla-dx/ 
    mkdir build 
    cd build/ 
    cmake .. 
    cmake --build . --config Release 
    sudo cmake -P cmake_install.cmake -DCMAKE_INSTALL_PREFIX=/usr/local 
    cd - 
    # Install rbgasm
    cd ~/Workspace 
    sudo $INSTALLER install -y bison libpng-dev libpng-tools libpng-tools 
    git clone https://github.com/gbdev/rgbds 
    cd rgbds/ 
    make clean 
    make 
    sudo make install 
    cd - 
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
