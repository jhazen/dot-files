set nocompatible
filetype off
set number
set history=1000
set visualbell
set autoread
set hidden
syntax on
set noswapfile
set nobackup
set nowb
set fo=tcq
set modeline
set bg=dark
if has('persistent_undo')
  silent !mkdir ~/.vimbackups > /dev/null 2>&1
  set undodir=~/.vimbackups
  set undofile
endif
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set nowrap
set foldnestmax=3
set nofoldenable
set noerrorbells visualbell t_vb=
set scrolloff=8
set sidescrolloff=15
set ruler
set sidescroll=1
set shell=bash
colorscheme koehler

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Plugin 'gmarik/vundle'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'rodjek/vim-puppet'
Plugin 'skwp/vim-easymotion'
Plugin 'godlygeek/tabular'
Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-surround.git'
Plugin 'pthrasher/conqueterm-vim'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Raimondi/delimitMate'
Plugin 'majutsushi/tagbar'

highlight LiteralTabs ctermbg=darkgreen guibg=darkgreen
match LiteralTabs /\s\  /
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$/

au BufRead,BufNewFile *.pp
  \ set filetype=puppet
au BufRead,BufNewFile *_spec.rb
  \ nmap <F8> :!rspec --color %<CR>

filetype plugin indent on

let g:NERDTreeDirArrows=0
let g:NERDTreeShowHidden=1
let g:NERDTreeWinPos="right"

nmap <C-N> :NERDTreeToggle<CR>
nmap <C-W> :tabprevious<CR>
nmap <C-E> :tabnext<CR>
nmap <C-T> :tabnew<CR>
nmap <C-U> :GundoToggle<CR>
nmap <C-B> :ConqueTermTab bash<CR>
nmap <F5> :!puppet-lint %<CR>

nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s

nnoremap <silent> tt :TagbarToggle<CR>

nnoremap <silent> nn :bn<CR>
nnoremap <silent> pp :bp<CR>

nnoremap <silent> bb :ConqueTermVSplit bash<CR>

nnoremap <silent> ee <C-w>+
nnoremap <silent> ww <C-w>-
nnoremap <silent> qq <C-w><
nnoremap <silent> rr <C-w>>

nnoremap <silent> KK <C-w>K
nnoremap <silent> JJ <C-w>J
nnoremap <silent> HH <C-w>H
nnoremap <silent> LL <C-w>L

nnoremap <silent> kk <C-w>k
nnoremap <silent> jj <C-w>j
nnoremap <silent> hh <C-w>h
nnoremap <silent> ll <C-w>l

