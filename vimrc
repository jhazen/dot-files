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
set encoding=utf8
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
set textwidth=270
hi Normal ctermbg=none
highlight NonText ctermbg=none
set foldmethod=indent
set foldlevel=99

set rtp+=~/.vim/bundle/vundle/
set rtp+=/usr/local/go/src/github.com/golang/lint/misc/vim
call vundle#rc()
Plugin 'gmarik/vundle'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'skwp/vim-easymotion'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-surround.git'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Raimondi/delimitMate'
Plugin 'moll/vim-node'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'majutsushi/tagbar'
Plugin 'CyCoreSystems/vim-cisco-ios'
Plugin 'flazz/vim-colorschemes'
Plugin 'morhetz/gruvbox'
Plugin 'joonty/vdebug'
Plugin 'nvie/vim-flake8'
Plugin 'tmhedberg/SimpylFold'
Plugin 'skywind3000/asyncrun.vim'
Plugin 'w0rp/ale'
Plugin 'vim-airline/vim-airline'
Plugin 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plugin 'mdempsky/gocode', {'rtp': 'vim/'}
Plugin 'davidhalter/jedi-vim'
Plugin 'vim-ruby/vim-ruby'
Plugin 'ClockworkNet/vim-junos-syntax'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'Valloric/YouCompleteMe'
Plugin 'roxma/nvim-yarp'
Plugin 'roxma/vim-hug-neovim-rpc'
Plugin 'klen/python-mode'
Plugin 'mitsuhiko/vim-jinja'
Plugin 'plytophogy/vim-virtualenv'
Plugin 'mbbill/undotree'
Plugin 'sirver/UltiSnips'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'honza/vim-snippets'
Plugin 'vimwiki/vimwiki'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'vim-scripts/DoxygenToolkit.vim'
Plugin 'vhdirk/vim-cmake'
Plugin 'artur-shaik/vim-javacomplete2'
Plugin 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plugin 'ervandew/supertab'

set background=dark
colorscheme gruvbox

highlight LiteralTabs ctermbg=darkgreen guibg=darkgreen
match LiteralTabs /\s\  /
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$/

filetype plugin indent on

let g:terminal_scrollback_buffer_size = 100000

let g:NERDTreeDirArrows=0
let g:NERDTreeShowHidden=1
let g:NERDTreeWinPos="right"

let g:jedi#use_splits_not_buffers = "bottom"
let g:jedi#documentation_command = "<leader>k"
let g:jedi#completions_command = "<C-A>"

let g:ctrlp_cmd='CtrlP ~/Workspace'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

let NERDTreeIgnore=['\.pyc$', '\~$']

let g:SimplyFold_docstring_preview=1

let g:flake8_quickfix_height=12
let python_highlight_all=1
let g:Powerline_symbols = 'fancy'

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_version_warning = 0

let g:ycm_confirm_extra_conf = 0
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']

let g:SuperTabDefaultCompletionType = '<C-n>'

let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
      let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline_theme = 'gruvbox'

let g:pymode_options_colorcolumn = 0

let g:JavaComplete_EnableDefaultMappings = 1

nmap <C-N> :NERDTreeToggle<CR>
nmap <C-U> :UndotreeToggle<CR>
nmap <C-W> :tabprevious<CR>
nmap <C-E> :tabnext<CR>
nmap <C-T> :tabnew<CR>
nmap <C-B> :tabnew term://bash<CR>
nmap <C-Y> :tabnew term://python3<CR>
nmap <C-D> :tabnew term://sqlite3<CR>
nmap <leader>q :vsplit term://pdb3 %<CR>
nmap <C-G> :TagbarToggle<CR>

nnoremap <C-F> za

autocmd FileType java setlocal omnifunc=javacomplete#Complete
au FileType python map <buffer> <C-L> :call Flake8()<CR>
au BufEnter *.go nmap <C-L> <esc>:w\|!gofmt -d % > /tmp/lintout<CR>:belowright split /tmp/lintout<CR>:redraw!<CR>
au FileType go nmap <leader>g <Plug>(go-def-split)
au FileType go inoremap <leader>t <C-x><C-o>
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
au BufEnter *.asm set filetype=nasm
au BufEnter *.sls set filetype=yaml

nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s

nnoremap <silent> bn :bn<CR>
nnoremap <silent> bp :bp<CR>

nnoremap <silent> bB :vsplit term://bash<CR>
nnoremap <silent> bP :vsplit term://python3<CR>
nnoremap <silent> bD :vsplit term://sqlite3<CR>

nnoremap <silent> ,e <C-w>+<C-w>+<C-w>+<C-w>+<C-w>+
nnoremap <silent> ,w <C-w>-<C-w>-<C-w>-<C-w>-<C-w>-
nnoremap <silent> ,q <C-w><<C-w><<C-w><<C-w><<C-w><
nnoremap <silent> ,r <C-w>><C-w>><C-w>><C-w>><C-w>>

nnoremap <leader>cd :Glcd<CR>
nmap <leader>gs :Gstatus<cr>
nmap <leader>gd :Gdiff<cr>
nmap <leader>gb :Gblame<cr>
nmap <leader>gc :Gcommit<cr>
nmap <leader>gp :Gpull<cr>
nmap <leader>gP :Gpush<cr>

nmap <leader>cm :CMake<cr>
nmap <leader>m :make %<<cr>

tnoremap <Esc> <C-\><C-n>
nnoremap <leader><space> :noh<cr>

nnoremap <leader>jd :YcmCompleter GoTo<CR>

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
nnoremap <silent> ,a @a
let @a="kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk"
nnoremap <silent> ,z @z
let @z="jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj"

augroup SPACEVIM_ASYNCRUN
    autocmd!
    autocmd User AsyncRunStart call asyncrun#quickfix_toggle(15, 1)
augroup END

autocmd filetype c nnoremap <leader>r :w <bar> !%<<CR>
autocmd filetype cpp nnoremap <leader>r :w <bar> !%<<CR>
autocmd Filetype java set makeprg=javac\ %
autocmd filetype java nnoremap <leader>r :w <bar> !java -cp %:p:h %:t:r<CR>
autocmd filetype python nnoremap <leader>r :w <bar> !python3 % <CR>
autocmd filetype sh nnoremap <leader>r :w <bar> !chmod +x % && % <CR>
autocmd filetype go nnoremap <leader>r :w <bar> !go build % && %<<CR>
autocmd filetype asm nnoremap <leader>r :w <bar> !nasm -f elf64 % -o %.o && ld -m elf_x86_64 %.o -o a.out && chmod +x a.out && ./a.out<CR>
autocmd filetype asm32 nnoremap <leader>r :w <bar> !nasm -f elf32 % -o %.o && ld -m elf_i386 %.o -o a.out && chmod +x a.out && ./a.out<CR>

function! ToggleHex()
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
command! -bar Hex call ToggleHex()

function! s:CTF(datapath)
    exec ":tabnew term://bash -c 'docker run -it -v " . a:datapath . ":/data ctf'"
endfunction
command! -nargs=1 CTF call s:CTF(<f-args>)

function! s:ServerRequest(role)
    exec "AsyncRun! vimserver.py " . a:role
endfunction
command! -nargs=1 ServerRequest call s:ServerRequest(<f-args>)

function! s:ServerShellTab(name)
    exec ":tabnew term://bash -c 'cd ~/Workspace/vagrantlab/ && vagrant ssh " . a:name . "'"
endfunction
command! -nargs=1 ServerShellTab call s:ServerShellTab(<f-args>)

function! s:ServerShellVSplit(name)
    exec ":vsplit term://bash -c 'cd ~/Workspace/vagrantlab/ && vagrant ssh " . a:name . "'"
endfunction
command! -nargs=1 ServerShellVSplit call s:ServerShellVSplit(<f-args>)

function! s:ServerStart(name)
    exec "AsyncRun! bash -c 'cd ~/Workspace/vagrantlab/ && vagrant up " . a:name . "'"
endfunction
command! -nargs=1 ServerStart call s:ServerStart(<f-args>)

function! s:ServerStop(name)
    exec "AsyncRun! bash -c 'cd ~/Workspace/vagrantlab/ && vagrant halt -f " . a:name . "'"
endfunction
command! -nargs=1 ServerStop call s:ServerStop(<f-args>)
