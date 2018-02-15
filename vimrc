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
set ff=unix
set clipboard=unnamed
set laststatus=2
set textwidth=1000

set foldmethod=indent
set foldlevel=99

set rtp+=~/.vim/bundle/vundle/
set rtp+=/usr/local/go/src/github.com/golang/lint/misc/vim
call vundle#rc()
Plugin 'gmarik/vundle'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
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
Plugin 'majutsushi/tagbar'
Plugin 'CyCoreSystems/vim-cisco-ios'
Plugin 'flazz/vim-colorschemes'
Plugin 'joonty/vdebug'
Plugin 'nvie/vim-flake8'
Plugin 'tmhedberg/SimpylFold'
Plugin 'skywind3000/asyncrun.vim'
Plugin 'w0rp/ale'
Plugin 'Lokaltog/vim-powerline'
Plugin 'fatih/vim-go'
Plugin 'davidhalter/jedi-vim'
Plugin 'ervandew/supertab'
Plugin 'vim-ruby/vim-ruby'
Plugin 'roxma/vim-hug-neovim-rpc'
Plugin 'roxma/nvim-yarp'
Plugin 'Shougo/deoplete.nvim'

set background=dark
colorscheme znake

highlight LiteralTabs ctermbg=darkgreen guibg=darkgreen
match LiteralTabs /\s\  /
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$/

filetype plugin indent on

let g:NERDTreeDirArrows=0
let g:NERDTreeShowHidden=1
let g:NERDTreeWinPos="right"

let g:jedi#use_splits_not_buffers = "bottom"
let g:jedi#documentation_command = "<leader>k"

let g:ctrlp_cmd='CtrlP ~/Workspace'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

let NERDTreeIgnore=['\.pyc$', '\~$']

let g:SimplyFold_docstring_preview=1

let g:ConqueTerm_StartMessages = 0

let g:flake8_quickfix_height=12
let python_highlight_all=1

let g:deoplete#enable_at_startup = 1

let g:Powerline_symbols = 'fancy'

nmap <C-N> :NERDTreeToggle<CR>
nmap <C-W> :tabprevious<CR>
nmap <C-E> :tabnext<CR>
nmap <C-T> :tabnew<CR>
nmap <C-U> :GundoToggle<CR>
nmap <C-B> :ConqueTermTab bash<CR>
nmap <C-Y> :ConqueTermTab python3<CR>
nmap <C-M> :ConqueTermTab msfconsole<CR>
nmap <C-M> :ConqueTermTab sqlite3<CR>
nmap <C-G> :TagbarToggle<CR>

nnoremap <C-F> za

nnoremap <C-R> :call <SID>compile_and_run()<CR>

au FileType python map <buffer> <C-L> :call Flake8()<CR>
au BufEnter *.go nmap <C-L> <esc>:w\|!gofmt -d % > /tmp/lintout<CR>:belowright split /tmp/lintout<CR>:redraw!<CR>
au BufEnter *.pp nmap <C-L> <esc>:w\|!puppet-lint % > /tmp/lintout<CR>:belowright split /tmp/lintout<CR>:redraw!<CR>
au BufEnter *.rb nmap <C-L> <esc>:w\|!rspec --color % > /tmp/lintout<CR>:belowright split /tmp/lintout<CR>:redraw!<CR>
au BufEnter *.js nmap <C-L> <esc>:w\|!jslint % > /tmp/lintout<CR>:belowright split /tmp/lintout<CR>:redraw!<CR>
au BufEnter *.spec nmap <C-L> <esc>:w\|!rpmlint % > /tmp/lintout<CR>:belowright split /tmp/lintout<CR>:redraw!<CR>
au BufEnter *.json nmap <C-L> <esc>:w\|!jsonlint % > /tmp/lintout<CR>:belowright split /tmp/lintout<CR>:redraw!<CR>
au BufEnter *.js, *.html, *.css set shiftwidth=2
au BufEnter *.js, *.html, *.css set tabstop=2
au BufEnter *.js, *.html, *.css set softtabstop=2
au BufEnter *.sls set shiftwidth=2
au BufEnter *.sls set tabstop=2
au BufEnter *.sls set softtabstop=2
au BufEnter *.yml set shiftwidth=2
au BufEnter *.yml set tabstop=2
au BufEnter *.yml set softtabstop=2
au BufEnter *.yaml set shiftwidth=2
au BufEnter *.yaml set tabstop=2
au BufEnter *.yaml set softtabstop=2
au BufEnter *.rb set shiftwidth=2
au BufEnter *.rb set tabstop=2
au BufEnter *.rb set softtabstop=2
au BufEnter *.cisco set ft=cisco
au BufEnter *.junos set ft=junos
au BufEnter *.pp set filetype=puppet
au BufEnter *.asm set filetype=nasm

nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s

nnoremap <silent> bn :bn<CR>
nnoremap <silent> bp :bp<CR>

nnoremap <silent> bB :ConqueTermVSplit bash<CR>
nnoremap <silent> bP :ConqueTermVSplit python3<CR>
nnoremap <silent> bM :ConqueTermVSplit msfconsole<CR>
nnoremap <silent> bD :ConqueTermVSplit sqlite3<CR>

nnoremap <silent> ,e <C-w>+<C-w>+<C-w>+<C-w>+<C-w>+
nnoremap <silent> ,w <C-w>-<C-w>-<C-w>-<C-w>-<C-w>-
nnoremap <silent> ,q <C-w><<C-w><<C-w><<C-w><<C-w><
nnoremap <silent> ,r <C-w>><C-w>><C-w>><C-w>><C-w>>

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

augroup SPACEVIM_ASYNCRUN
    autocmd!
    " Automatically open the quickfix window
    autocmd User AsyncRunStart call asyncrun#quickfix_toggle(15, 1)
augroup END

function! s:compile_and_run()
    exec 'w'
    if &filetype == 'c'
       exec "AsyncRun! vimrun.sh c %:p"
    elseif &filetype == 'cpp'
       exec "AsyncRun! vimrun.sh cpp %:p"
    elseif &filetype == 'java'
       exec "AsyncRun! vimrun.sh java %:p"
    elseif &filetype == 'sh'
       exec "AsyncRun! vimrun.sh sh %:p"
    elseif &filetype == 'python'
       exec "AsyncRun! vimrun.sh py %:p"
    elseif &filetype == 'py2'
       exec "AsyncRun! vimrun.sh py2 %:p"
    elseif &filetype == 'go'
       exec "AsyncRun! -raw vimrun.sh go %:p"
    elseif &filetype == 'nasm'
       exec "AsyncRun! vimrun.sh asm %:p"
    elseif &filetype == 'nasm32'
       exec "AsyncRun! vimrun.sh asm32 %:p"
    endif
endfunction
command -bar Hex call ToggleHex()

function ToggleHex()
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    let b:oldft=&ft
    let b:oldbin=&bin
    setlocal binary
    silent :e
    let &ft="xxd"
    let b:editHex=1
    %!xxd
  else
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    let b:editHex=0
    %!xxd -r
  endif
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction
