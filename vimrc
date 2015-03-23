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

au BufEnter *.pp nmap <F5> <esc>:w\|!puppet-lint %<CR>
au BufEnter *.rb nmap <F5> <esc>:w\|!rspec --color %<CR>
au BufEnter *.spec nmap <F5> <esc>:w\|!rpmlint %<CR>

nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s

nnoremap <silent> tt :TagbarToggle<CR>

nnoremap <silent> nn :bn<CR>
nnoremap <silent> pp :bp<CR>

nnoremap <silent> bb :ConqueTermVSplit bash<CR>

nnoremap <silent> ,e <C-w>+
nnoremap <silent> ,w <C-w>-
nnoremap <silent> ,q <C-w><
nnoremap <silent> ,r <C-w>>

nnoremap <silent> ,K <C-w>K
nnoremap <silent> ,J <C-w>J
nnoremap <silent> ,H <C-w>H
nnoremap <silent> ,L <C-w>L

nnoremap <silent> ,k <C-w>k
nnoremap <silent> ,j <C-w>j
nnoremap <silent> ,h <C-w>h
nnoremap <silent> ,l <C-w>l

set laststatus=2
set statusline=%<%F\ %{fugitive#statusline()}\ [%{&ff}/%Y]\ [%{getcwd()}]
set statusline+=%#warningmsg#
set statusline+=%*
set statusline+=%=%-14.(%l,%c%V%)\ %p%%
