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
set textwidth=243
hi Normal ctermbg=none
highlight NonText ctermbg=none
set foldmethod=indent
set foldlevel=99

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Plugin 'gmarik/vundle'
Plugin 'tpope/vim-fugitive'
Plugin 'skwp/vim-easymotion'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-surround.git'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Raimondi/delimitMate'
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
Plugin 'vim-airline/vim-airline-themes'
Plugin 'davidhalter/jedi-vim'
Plugin 'ClockworkNet/vim-junos-syntax'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'Shougo/deoplete.nvim'
Plugin 'roxma/nvim-yarp'
Plugin 'roxma/vim-hug-neovim-rpc'
Plugin 'klen/python-mode'
Plugin 'mitsuhiko/vim-jinja'
Plugin 'mbbill/undotree'
Plugin 'sirver/UltiSnips'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'honza/vim-snippets'
Plugin 'vimwiki/vimwiki'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'vim-scripts/DoxygenToolkit.vim'
Plugin 'vhdirk/vim-cmake'
Plugin 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plugin 'ervandew/supertab'
Plugin 'fatih/vim-go'

set background=dark
colorscheme gruvbox

highlight LiteralTabs ctermbg=darkgreen guibg=darkgreen
match LiteralTabs /\s\  /
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$/

filetype plugin indent on

let g:terminal_scrollback_buffer_size = 100000

let g:jedi#use_splits_not_buffers = "bottom"
let g:jedi#documentation_command = "<leader>k"
let g:jedi#completions_command = "<C-A>"

let g:SimplyFold_docstring_preview=1

let g:flake8_show_quickfix=0
let g:flake8_show_in_gutter=0
let python_highlight_all=1
let g:Powerline_symbols = 'fancy'

"let g:ycm_confirm_extra_conf = 0
"let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
"let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
"let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'

let g:SuperTabDefaultCompletionType = '<C-n>'

let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
      let g:airline_symbols = {}
endif
"let g:airline_symbols.space = '\ua0'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0

let wiki = {}
let wiki.path = '~/vimwiki'
let wiki.syntax = 'markdown'
let wiki.ext = '.md'
let wiki.nested_syntaxes = {'ruby': 'ruby', 'python': 'python', 'c++': 'cpp', 'sh': 'sh', 'racket': 'racket'}
let g:vimwiki_list = [wiki]
let g:vimwiki_hl_headers = 1
let g:vimwiki_global_ext = 0
let g:vimwiki_markdown_link_ext = 1
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}

let g:pymode_options_colorcolumn = 0
let g:pymode_lint_on_write = 0

let g:go_def_mapping_enabled = 0

nmap <C-U> :UndotreeToggle<CR>
nmap <C-W> :tabprevious<CR>
nmap <C-E> :tabnext<CR>
nmap <C-T> :tabnew<CR>
nmap <C-B> :tabnew term://bash<CR>
nmap <C-Y> :tabnew term://python3<CR>
nmap <leader>q :vsplit term://pdb3 %<CR>
nmap <C-G> :TagbarToggle<CR>

nnoremap <C-F> za

au FileType python map <buffer> <C-L> :call Flake8()<CR>
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
au BufEnter *.asm set filetype=nasm
au BufEnter *.sls set filetype=yaml
au BufEnter *.wiki set ft=markdown
au BufEnter *.md set ft=markdown
au BufRead,BufWrite,BufNew *.wiki set ft=markdown
au BufRead,BufWrite,BufNew *.md set ft=markdown

nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s

nnoremap <silent> bn :bn<CR>
nnoremap <silent> bp :bp<CR>

nnoremap <silent> bB :vsplit term://bash<CR>
nnoremap <silent> bP :vsplit term://python3<CR>

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

tnoremap <Esc> <C-\><C-n>
nnoremap <leader><space> :noh<cr>

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

autocmd filetype python nnoremap <leader>r :w <bar> !python3 % <CR>
autocmd filetype c nnoremap <leader>r :w <bar> !gcc % -o /tmp/a.out && chmod +x /tmp/a.out && /tmp/a.out <CR>
autocmd filetype c nnoremap <leader>m :make<CR>
autocmd filetype go nnoremap <leader>r :GoRun <CR>
autocmd filetype go nnoremap <leader>b :GoBuild <CR>
autocmd Filetype go nnoremap <leader>g :sp <CR>:exe "GoDef" <CR>
autocmd filetype sh nnoremap <leader>r :w <bar> !chmod +x % && % <CR>

autocmd filetype markdown nnoremap <Backspace> <Plug>VimwikiGoBackLink

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
