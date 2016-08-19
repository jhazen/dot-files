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
set encoding=utf-8
if has('persistent_undo')
  silent !mkdir ~/.vimbackups > /dev/null 2>&1
  set undodir=~/.vimbackups
  set undofile
endif
set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
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
Plugin 'moll/vim-node'
Plugin 'vim-scripts/indentpython.vim'

set background=dark
colorscheme koehler

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
nmap <C-Y> :ConqueTermTab python2.7<CR>

nmap <F6> :w<CR>:silent !chmod +x %<CR>:silent !%:p > /tmp/vimout<CR>:belowright split /tmp/vimout<CR>:redraw!<CR>

au BufEnter *.pp nmap <F5> <esc>:w\|!puppet-lint % > /tmp/lintout<CR>:belowright split /tmp/lintout<CR>:redraw!<CR>
au BufEnter *.py nmap <F5> <esc>:w\|!pylint % > /tmp/lintout<CR>:belowright split /tmp/lintout<CR>:redraw!<CR>
au BufEnter *.rb nmap <F5> <esc>:w\|!rspec --color % > /tmp/lintout<CR>:belowright split /tmp/lintout<CR>:redraw!<CR>
au BufEnter *.js nmap <F5> <esc>:w\|!jslint % > /tmp/lintout<CR>:belowright split /tmp/lintout<CR>:redraw!<CR>
au BufEnter *.spec nmap <F5> <esc>:w\|!rpmlint % > /tmp/lintout<CR>:belowright split /tmp/lintout<CR>:redraw!<CR>

nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s

nnoremap <silent> bn :bn<CR>
nnoremap <silent> bp :bp<CR>

nnoremap <silent> bB :ConqueTermVSplit bash<CR>
nnoremap <silent> bP :ConqueTermVSplit python2.7<CR>

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

nnoremap <Space> @q
let @q="\<Esc>^i#\<Esc>j"

set laststatus=2
set statusline=%<%F\ %{fugitive#statusline()}\ [%{&ff}/%Y]\ [%{getcwd()}]
set statusline+=%#warningmsg#
set statusline+=%*
set statusline+=%=%-14.(%l,%c%V%)\ %p%%
