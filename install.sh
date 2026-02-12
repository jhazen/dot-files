#!/bin/bash

# Script will install dot-files based on input
#
# Example: ./install.sh vim bash
#
# jhazen532@gmail.com

### Variables

DOTFILES=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
BACKUP_DIR=~/.dot-files-bak

### Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

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

### Detect OS and package manager

detect_os() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
    PKG_MGR="brew"
    PKG_INSTALL="brew install"
  elif [ -f /etc/os-release ]; then
    source /etc/os-release
    OS="linux"
    PKG_MGR="apt"
    PKG_INSTALL="sudo apt install -y"
  else
    OS="unknown"
    PKG_MGR="unknown"
    PKG_INSTALL="echo 'Unknown package manager, manually install:'"
  fi
}

detect_os

### Helper: check if a command exists
cmd_exists() {
  command -v "$1" &>/dev/null
}

### Helper: check and collect missing packages
# Usage: check_missing_packages <array_name> <cmd1:pkg_apt:pkg_brew> ...
# Format per entry: "command_name:apt_package:brew_package"
#   - command_name: the binary to check with `command -v`
#   - apt_package: package name for apt (use "-" to skip)
#   - brew_package: package name for brew (use "-" to skip)
check_and_report() {
  local label="$1"
  shift
  local entries=("$@")
  local missing_apt=()
  local missing_brew=()
  local all_found=true

  for entry in "${entries[@]}"; do
    IFS=':' read -r cmd apt_pkg brew_pkg <<< "$entry"
    if ! cmd_exists "$cmd"; then
      all_found=false
      if [[ "$apt_pkg" != "-" ]]; then
        missing_apt+=("$apt_pkg")
      fi
      if [[ "$brew_pkg" != "-" ]]; then
        missing_brew+=("$brew_pkg")
      fi
      echo -e "  ${RED}✗${NC} ${cmd} not found"
    else
      echo -e "  ${GREEN}✓${NC} ${cmd}"
    fi
  done

  if [[ "$all_found" == true ]]; then
    return 0
  fi

  echo ""
  if [[ "$OS" == "macos" && ${#missing_brew[@]} -gt 0 ]]; then
    echo -e "  ${YELLOW}→ Install missing packages:${NC}"
    echo -e "    ${CYAN}brew install ${missing_brew[*]}${NC}"
  elif [[ "$OS" == "linux" && ${#missing_apt[@]} -gt 0 ]]; then
    echo -e "  ${YELLOW}→ Install missing packages:${NC}"
    echo -e "    ${CYAN}sudo apt install -y ${missing_apt[*]}${NC}"
  fi
  return 1
}

### Helper: check pip packages
check_pip_packages() {
  local label="$1"
  shift
  local packages=("$@")
  local missing=()
  local all_found=true

  for pkg in "${packages[@]}"; do
    IFS=':' read -r import_name pip_name <<< "$pkg"
    if python3 -c "import ${import_name}" &>/dev/null; then
      echo -e "  ${GREEN}✓${NC} ${pip_name} (python)"
    else
      all_found=false
      missing+=("$pip_name")
      echo -e "  ${RED}✗${NC} ${pip_name} (python) not found"
    fi
  done

  if [[ "$all_found" == true ]]; then
    return 0
  fi

  echo ""
  echo -e "  ${YELLOW}→ Install missing pip packages:${NC}"
  echo -e "    ${CYAN}pip3 install ${missing[*]} --break-system-packages${NC}"
  return 1
}

### Helper: check npm packages
check_npm_packages() {
  local label="$1"
  shift
  local packages=("$@")
  local missing=()
  local all_found=true

  for pkg in "${packages[@]}"; do
    if cmd_exists "$pkg"; then
      echo -e "  ${GREEN}✓${NC} ${pkg} (npm)"
    else
      all_found=false
      missing+=("$pkg")
      echo -e "  ${RED}✗${NC} ${pkg} (npm) not found"
    fi
  done

  if [[ "$all_found" == true ]]; then
    return 0
  fi

  echo ""
  echo -e "  ${YELLOW}→ Install missing npm packages:${NC}"
  echo -e "    ${CYAN}npm install -g ${missing[*]}${NC}"
  return 1
}

### Helper: check go packages
check_go_packages() {
  local label="$1"
  shift
  local packages=("$@")
  local missing=()
  local all_found=true

  for entry in "${packages[@]}"; do
    IFS=':' read -r cmd go_path <<< "$entry"
    if cmd_exists "$cmd"; then
      echo -e "  ${GREEN}✓${NC} ${cmd} (go)"
    else
      all_found=false
      missing+=("$go_path")
      echo -e "  ${RED}✗${NC} ${cmd} (go) not found"
    fi
  done

  if [[ "$all_found" == true ]]; then
    return 0
  fi

  echo ""
  echo -e "  ${YELLOW}→ Install missing go packages:${NC}"
  for pkg in "${missing[@]}"; do
    echo -e "    ${CYAN}go install ${pkg}${NC}"
  done
  return 1
}

### Functions

function vimsetup() {
  echo -e "${BOLD}=== Vim/Neovim Setup ===${NC}"
  echo ""

  # Symlink neovim config
  echo -e "${BOLD}Linking config...${NC}"
  rm -rf ~/.config/nvim
  rm -rf ~/.vim
  rm -rf ~/.vimrc
  ln -s $DOTFILES/nvim ~/.config/nvim
  echo -e "  ${GREEN}✓${NC} Linked $DOTFILES/nvim → ~/.config/nvim"
  echo ""

  # --- System packages ---
  echo -e "${BOLD}System packages:${NC}"
  #                  command:apt_package:brew_package
  local sys_packages=(
    "nvim:neovim:neovim"
    "git:git:git"
    "cmake:cmake:cmake"
    "python3:python3:python3"
    "curl:curl:curl"
    "rg:ripgrep:ripgrep"
    "fdfind:fd-find:fd"
    "pandoc:pandoc:pandoc"
    "xelatex:texlive-latex-extra:mactex"
    "shellcheck:shellcheck:shellcheck"
    "xclip:xclip:-"
  )

  # On macOS, pbcopy is built-in so xclip isn't needed; adjust fd command name
  if [[ "$OS" == "macos" ]]; then
    sys_packages=(
      "nvim:neovim:neovim"
      "git:git:git"
      "cmake:cmake:cmake"
      "python3:python3:python3"
      "curl:curl:curl"
      "rg:ripgrep:ripgrep"
      "fd:fd-find:fd"
      "pandoc:pandoc:pandoc"
      "xelatex:texlive-latex-extra:mactex"
      "shellcheck:shellcheck:shellcheck"
    )
  fi

  check_and_report "System packages" "${sys_packages[@]}"
  echo ""

  # --- Node.js (needed for some Mason LSP servers and npm packages) ---
  echo -e "${BOLD}Node.js runtime:${NC}"
  check_and_report "Node.js" "node:nodejs:node" "npm:npm:npm"
  echo ""

  # --- pip packages ---
  echo -e "${BOLD}Python (pip) packages:${NC}"
  #                  import_name:pip_name
  local pip_packages=(
    "pynvim:pynvim"
    "debugpy:debugpy"
    "bandit:bandit"
  )
  check_pip_packages "pip" "${pip_packages[@]}"
  echo ""

  # --- npm packages ---
  echo -e "${BOLD}npm global packages:${NC}"
  local npm_packages=(
    "snyk"
    "eslint_d"
  )
  check_npm_packages "npm" "${npm_packages[@]}"
  echo ""

  # --- Go tools (for Go DAP - delve is excluded from mason auto-install) ---
  echo -e "${BOLD}Go packages:${NC}"
  if cmd_exists "go"; then
    echo -e "  ${GREEN}✓${NC} go"
    local go_packages=(
      "dlv:github.com/go-delve/delve/cmd/dlv@latest"
    )
    check_go_packages "go" "${go_packages[@]}"
  else
    echo -e "  ${RED}✗${NC} go not found"
    echo ""
    if [[ "$OS" == "macos" ]]; then
      echo -e "  ${YELLOW}→ Install Go:${NC}"
      echo -e "    ${CYAN}brew install go${NC}"
    else
      echo -e "  ${YELLOW}→ Install Go:${NC}"
      echo -e "    ${CYAN}sudo apt install -y golang-go${NC}"
    fi
    echo -e "  ${YELLOW}  Then install Go tools:${NC}"
    echo -e "    ${CYAN}go install github.com/go-delve/delve/cmd/dlv@latest${NC}"
  fi
  echo ""

  # --- Mason-managed tools (informational) ---
  echo -e "${BOLD}Mason-managed (auto-installed on first nvim launch):${NC}"
  echo -e "  LSP servers: pyright, bashls, clangd, ts_ls, jdtls, asm_lsp, lua_ls"
  echo -e "  Formatters:  black, prettier, shfmt, stylua, clang-format"
  echo -e "  Linters:     ruff, shellcheck, markdownlint"
  echo -e "  DAP:         bash-debug-adapter, codelldb, php-debug-adapter, debugpy"
  echo ""
  echo -e "  ${CYAN}Run :Mason in neovim to manage these packages.${NC}"
  echo ""

  # --- Summary ---
  echo -e "${BOLD}Notes:${NC}"
  echo -e "  • google-java-format (Java formatter) may need manual install if using Java."
  echo -e "  • Neovim plugins are managed by lazy.nvim and install automatically on first launch."
  echo -e "  • Treesitter parsers install automatically on first launch."
  echo ""
}

function bashsetup() {
  echo -e "${BOLD}=== Bash Setup ===${NC}"
  echo ""

  # Symlink bashrc
  echo -e "${BOLD}Linking config...${NC}"
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
    mv ~/.aliases $BACKUP_DIR/aliases-$(date +%s)
  fi
  ln -s $DOTFILES/aliases ~/.aliases
  ln -s $DOTFILES/bashrc ~/.bashrc
  echo -e "  ${GREEN}✓${NC} Linked $DOTFILES/bashrc → ~/.bashrc"
  echo -e "  ${GREEN}✓${NC} Linked $DOTFILES/aliases → ~/.aliases"

  if [ ! -d ~/bin ]; then
    mkdir ~/bin
  fi
  if [ ! -d ~/.bin ]; then
    mkdir ~/.bin
  fi
  if [ -f ~/bin/shot.sh ]; then
    mv ~/bin/shot.sh $BACKUP_DIR/shot.sh-$(date +%s)
  fi
  ln -s $DOTFILES/shot.sh ~/bin/shot.sh
  echo -e "  ${GREEN}✓${NC} Linked $DOTFILES/shot.sh → ~/bin/shot.sh"
  echo ""

  # --- Check system packages needed by bashrc/aliases ---
  echo -e "${BOLD}System packages:${NC}"
  local bash_packages=()

  if [[ "$OS" == "macos" ]]; then
    bash_packages=(
      "nvim:neovim:neovim"
      "cmake:cmake:cmake"
      "python3:python3:python3"
      "terminator:-:terminator"
      "convert:imagemagick:imagemagick"
      "pandoc:pandoc:pandoc"
      "xelatex:texlive-latex-extra:mactex"
      "neofetch:neofetch:neofetch"
      "feh:-:feh"
    )
  else
    bash_packages=(
      "nvim:neovim:neovim"
      "cmake:cmake:cmake"
      "python3:python3:python3"
      "terminator:terminator:terminator"
      "convert:imagemagick:imagemagick"
      "pandoc:pandoc:pandoc"
      "xelatex:texlive-latex-extra:mactex"
      "neofetch:neofetch:neofetch"
      "feh:feh:feh"
    )
  fi

  check_and_report "System packages" "${bash_packages[@]}"

  # --- Ubuntu PPA note ---
  if [[ "$OS" == "linux" ]]; then
    echo ""
    echo -e "  ${YELLOW}Note:${NC} For the latest neovim on Ubuntu, you may want to add the PPA:"
    echo -e "    ${CYAN}sudo add-apt-repository ppa:neovim-ppa/stable && sudo apt update${NC}"
  fi

  echo ""

  # --- pip packages needed by bashrc/aliases ---
  echo -e "${BOLD}Python (pip) packages:${NC}"
  local bash_pip=(
    "pynvim:pynvim"
    "debugpy:debugpy"
  )
  check_pip_packages "pip" "${bash_pip[@]}"
  echo ""
}

function allsetup() {
  echo -e "${BOLD}=== Full Setup ===${NC}"
  echo ""
  bashsetup
  vimsetup
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
