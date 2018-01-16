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
Plugin 'Valloric/YouCompleteMe'
Plugin 'CyCoreSystems/vim-cisco-ios'
Plugin 'flazz/vim-colorschemes'
Plugin 'joonty/vdebug'
Plugin 'nvie/vim-flake8'
Plugin 'tmhedberg/SimpylFold'
Plugin 'skywind3000/asyncrun.vim'
Plugin 'w0rp/ale'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'fatih/vim-go'

set background=dark
colorscheme Benokai

highlight LiteralTabs ctermbg=darkgreen guibg=darkgreen
match LiteralTabs /\s\  /
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$/

filetype plugin indent on

let g:NERDTreeDirArrows=0
let g:NERDTreeShowHidden=1
let g:NERDTreeWinPos="right"

let g:ctrlp_cmd='CtrlP ~/Workspace'

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

let NERDTreeIgnore=['\.pyc$', '\~$']

let g:SimplyFold_docstring_preview=1

let g:flake8_quickfix_height=12
let python_highlight_all=1

let g:ycm_autoclose_preview_window_after_completion=1

nmap <C-N> :NERDTreeToggle<CR>
nmap <C-W> :tabprevious<CR>
nmap <C-E> :tabnext<CR>
nmap <C-T> :tabnew<CR>
nmap <C-U> :GundoToggle<CR>
nmap <C-B> :ConqueTermTab bash<CR>
nmap <C-Y> :ConqueTermTab python3<CR>
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
au BufEnter *.cisco set ft=cisco
au BufEnter *.junos set ft=junos
au BufEnter *.pp set filetype=puppet
au BufEnter *.py set textwidth=99

nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s

nnoremap <silent> bn :bn<CR>
nnoremap <silent> bp :bp<CR>

nnoremap <silent> bB :ConqueTermVSplit bash<CR>
nnoremap <silent> bP :ConqueTermVSplit python3<CR>

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
let @e="\<Esc>bP\<Esc>,J,k:TagbarToggle\<CR>:NERDTreeToggle\<CR>,h,h:CtrlP\<CR>"

augroup SPACEVIM_ASYNCRUN
    autocmd!
    " Automatically open the quickfix window
    autocmd User AsyncRunStart call asyncrun#quickfix_toggle(15, 1)
augroup END

function! s:compile_and_run()
    exec 'w'
    if &filetype == 'c'
        exec "AsyncRun! gcc % -o %<; chmod +x %<; time %<"
    elseif &filetype == 'cpp'
       exec "AsyncRun! g++ -std=c++11 % -o %<; chmod +x %<; time %<"
    elseif &filetype == 'java'
       exec "AsyncRun! source ~/.aliases; javac %; vimjavarun %"
    elseif &filetype == 'sh'
       exec "AsyncRun! time bash %"
    elseif &filetype == 'python'
       exec "AsyncRun! time python3 %"
    elseif &filetype == 'go'
       exec "AsyncRun! -raw time go run %"
    endif
endfunction
