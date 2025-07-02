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
set clipboard=unnamedplus
set laststatus=2
set textwidth=0
set linebreak
hi Normal ctermbg=none
highlight NonText ctermbg=none
set foldmethod=indent
set foldlevel=99
set tags=./tags,tags;$HOME

set rtp+=~/.config/nvim/bundle/Vundle.vim/
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'skwp/vim-easymotion'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-surround.git'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Raimondi/delimitMate'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'majutsushi/tagbar'
Plugin 'flazz/vim-colorschemes'
Plugin 'rafi/awesome-vim-colorschemes'
Plugin 'ghifarit53/tokyonight-vim'
Plugin 'joonty/vdebug'
Plugin 'nvie/vim-flake8'
Plugin 'tmhedberg/SimpylFold'
Plugin 'skywind3000/asyncrun.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'davidhalter/jedi-vim'
Plugin 'preservim/nerdtree'
Plugin 'Shougo/deoplete.nvim'
Plugin 'roxma/nvim-yarp'
Plugin 'roxma/vim-hug-neovim-rpc'
"Plugin 'vim-syntastic/syntastic'
Plugin 'mitsuhiko/vim-jinja'
Plugin 'mbbill/undotree'
Plugin 'sirver/UltiSnips'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'honza/vim-snippets'
Plugin 'vimwiki/vimwiki'
Plugin 'fatih/vim-go'
Plugin 'kkoomen/vim-doge'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'dkprice/vim-easygrep'
Plugin 'vim-python/python-syntax'
Plugin 'kien/ctrlp.vim'
Plugin 'puremourning/vimspector'
Plugin 'NewLunarFire/wla-vim'
Plugin 'dahu/vim-rng'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'junegunn/limelight.vim'
call vundle#end()

set background=dark
set termguicolors
let g:tokyonight_style = 'night'
let g:tokyonight_enable_italic = 1
colorscheme sonokai

highlight LiteralTabs ctermbg=darkgreen guibg=darkgreen
match LiteralTabs /\s\  /
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$/

filetype plugin indent on

let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_guifg = 'DarkGray'

let g:tagbar_ctags_bin = "/usr/bin/ctags"

let g:doge_doc_standard_python = 'sphinx'
let g:doge_mapping = '<Leader>D'

let g:vimspector_enable_mappings = 'HUMAN'

let g:terminal_scrollback_buffer_size = 100000

let g:deoplete#enable_at_startup = 0
let g:flake8_show_in_gutter = 1
let g:flake8_show_in_file = 1

let g:jedi#use_splits_not_buffers = "bottom"
let g:jedi#documentation_command = "<leader>k"
let g:jedi#completions_command = "<C-A>"
let g:jedi#goto_command = "<leader>G"

let g:SimplyFold_docstring_preview=1

let g:flake8_show_quickfix=1
let g:flake8_show_in_gutter=1
let python_highlight_all=1
let g:Powerline_symbols = 'fancy'

let g:ycm_confirm_extra_conf = 0
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
let g:ycm_key_detailed_diagnostics = '<leader>D'

let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:ultisnips_python_style = 'sphinx'

let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
      let g:airline_symbols = {}
endif
"let g:airline_symbols.space = '\ua0'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#wordcount#enabled = 1
let g:airline#extensions#ale#enabled = 1
" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_theme='sonokai'

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

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

let g:python_highlight_all = 1

nmap <C-U> :UndotreeToggle<CR>
nmap <C-N> :NERDTreeToggle<CR>
nmap <C-W> :tabprevious<CR>
nmap <C-E> :tabnext<CR>
nmap <C-T> :tabnew<CR>
nmap <C-B> :tabnew term://bash<CR>
nmap <C-Y> :tabnew term://python3<CR>
nmap <C-G> :TagbarToggle<CR>

nnoremap <C-F> za

augroup WrapLineInMarkdown
    autocmd!
    autocmd FileType markdown setlocal wrap
augroup END

autocmd BufWritePost *.py call flake8#Flake8()
au FileType python nnoremap <leader>l :call flake8#Flake8()<CR>
au FileType rust nnoremap <leader>l :RustFmt <CR>
au BufEnter *.css set shiftwidth=2
au BufEnter *.css set tabstop=2
au BufEnter *.css set softtabstop=2
au BufEnter *.html set shiftwidth=2
au BufEnter *.html set tabstop=2
au BufEnter *.html set softtabstop=2
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
au BufEnter *.asm set filetype=wla
au BufEnter *.z80 set filetype=wla
au BufEnter *.s set filetype=wla
au BufEnter *.sls set filetype=yaml
au BufEnter *.md set breakindent
au BufEnter *.md set linebreak
au BufEnter *.md set syntax=markdown

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
nmap <leader>gs :Git<cr>
nmap <leader>gd :Git diff<cr>
nmap <leader>gb :Git blame<cr>
nmap <leader>gc :Git commit<cr>
nmap <leader>gp :Git pull<cr>
nmap <leader>gP :!gitpush_wrap.sh % <CR>

tnoremap <Esc> <C-\><C-n>

nnoremap <silent> ,K <C-w>K
nnoremap <silent> ,J <C-w>J
nnoremap <silent> ,H <C-w>H
nnoremap <silent> ,L <C-w>L

nnoremap <silent> ,k <C-w>k
nnoremap <silent> ,j <C-w>j
nnoremap <silent> ,h <C-w>h
nnoremap <silent> ,l <C-w>l

let @q="\<Esc>^i#\<Esc>j"
nnoremap <Space> @q
nnoremap <leader><space> @q@q@q@q@q@q@q@q@q@q
let @a="kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk"
nnoremap <silent> ,a @a
nnoremap <PageUp> @a
let @z="jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj"
nnoremap <PageDown> @z
nnoremap <silent> ,z @z

" Code Editor macro
let @E="\<Esc>\\ww\<Esc>:tabnew term://bash\<CR>:set nonu\<CR>bP\<CR>,K,j,h:tabnew\<CR>:set nu\<CR>:NERDTreeToggle\<CR>,l:TagbarToggle\<CR>:tabnew\<CR>:NERDTreeToggle\<CR>,l:TagbarToggle\<CR>:tabnew\<CR>:NERDTreeToggle\<CR>,l:TagbarToggle\<CR>:tabnext\<CR>"
nnoremap <leader>E @E

" Open another editor tab in Editor mode
let @T="\<Esc>\:tabnew\<CR>:set nu\<CR>:NERDTreeToggle\<CR>,l:TagbarToggle\<CR>"
nnoremap <leader>T @T

" Pentest Editor macro
let @H="\<Esc>\\ww\<Esc>:tabnew\<CR>:set nu\<CR>:NERDTreeToggle\<CR>,l:TagbarToggle\<CR>:tabnew\<CR>:set nu\<CR>:NERDTreeToggle\<CR>,l:TagbarToggle\<CR>:tabnew term://bash\<CR>:set nonu\<CR>:tabnew term://bash\<CR>:set nonu\<CR>:tabnext\<CR>"
nnoremap <leader>H @H

" Writing Editor macro
let @W="\<Esc>\\ww\<Esc>:tabnew\<CR>:set nonu\<CR>:NERDTreeToggle\<CR>,l:tabnew\<CR>:set nonu\<CR>:NERDTreeToggle\<CR>,l:tabnew\<CR>:set nonu\<CR>:NERDTreeToggle\<CR>,l:tabnext\<CR>"
nnoremap <leader>W @W

autocmd filetype c nnoremap <leader>b :w <bar> !build_wrap.sh % c -b<CR>
autocmd filetype c nnoremap <leader>r :w <bar> !build_wrap.sh % c -br<CR>
autocmd filetype c nnoremap <leader>g :sp <CR>:exec("tag ".expand("<cword>"))<CR>
autocmd filetype c nnoremap <leader>. :CtrlPTag<cr>
autocmd filetype wla nnoremap <leader>b :w <bar> !build_wrap.sh % asm -b<CR>
autocmd filetype wla nnoremap <leader>r :w <bar> !build_wrap.sh % asm -br<CR>
autocmd filetype asm nnoremap <leader>b :w <bar> !build_wrap.sh % asm -b<CR>
autocmd filetype asm nnoremap <leader>r :w <bar> !build_wrap.sh % asm -br<CR>
au FileType py nmap <leader>r :PymodeRun<CR>,k
au FileType go nmap <leader>r <Plug>(go-run-split)<CR>,k
au filetype go nnoremap <leader>b :GoBuild <CR>
au Filetype go nnoremap <leader>q :GoDebugStart <CR>
au FileType go nmap <leader>qs <Plug>(go-debug-step)
au FileType go nmap <leader>qc <Plug>(go-debug-continue)
au FileType go nmap <leader>qn <Plug>(go-debug-next)
au FileType go nmap <leader>qb <Plug>(go-debug-breakpoint)
au FileType go nmap <leader>f <Plug>(go-files)
au FileType go nmap <leader>d <Plug>(go-deps)
au FileType go nmap <leader>g <Plug>(go-def-split)
au FileType go nmap <leader>G <Plug>(go-def-stack)
au filetype sh nnoremap <leader>r :!%:p<Enter>

nnoremap <Leader>dd :call vimspector#Launch()<CR>
nnoremap <Leader>de :call vimspector#Reset()<CR>
nnoremap <Leader>dc :call vimspector#Continue()<CR>
nnoremap <Leader>dt :call vimspector#ToggleBreakpoint()<CR>
nnoremap <Leader>dT :call vimspector#ClearBreakpoints()<CR>
nmap <Leader>ds <Plug>VimspectorStepInto
nmap <Leader>dS <Plug>VimspectorStepOver

autocmd BufRead,BufNewFile *.md setlocal spell spelllang=en_us
autocmd BufRead,BufNewFile *.md setlocal spell spellfile=~/en.utf-8.add
autocmd filetype markdown nnoremap <Backspace> :VimwikiGoBackLink <CR>
autocmd filetype markdown nnoremap <leader>g <Plug>VimwikiTabDropLink
autocmd filetype markdown nnoremap <leader>G :VimwikiGoBackLink <CR>
autocmd filetype markdown nnoremap <leader>con :set spell spelllang=en_us<CR>
autocmd filetype markdown nnoremap <leader>coff :set nospell<CR>
autocmd filetype markdown nnoremap <leader>cn ]s
autocmd filetype markdown nnoremap <leader>cp [s
autocmd filetype markdown nnoremap <leader>cf z=
autocmd filetype markdown nnoremap <leader>ca zg
autocmd filetype markdown nnoremap <leader>b :w <bar> !build_wrap.sh %:p md -b<CR>
autocmd filetype markdown nnoremap <leader>B :w <bar> !build_wrap.sh %:p md_docx -b<CR>

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

function ToggleColorScheme()
    let g:fav_colors = ['gruvbox', 'iceberg', 'molokai', 'nord', 'muon', 'sonokai', 'space-vim-dark', 'Atelier_CaveDark', 'void', 'wwdc16', 'bitterjug', 'birds-of-paradise', 'badwolf', 'CandyPaper', 'smarties', 'khaki', 'neverland2', '1989', 'znake', 'twilight256', 'flatland', 'happy_hacking', 'codedark', 'orbital', 'northpole', 'dzo', 'greenvision', 'blacklight', 'jhlight', 'jitterbug', 'kalisi', 'lapis256', 'lodestone', 'lucius', 'made_of_code', 'miko', 'morning', 'mushroom', 'plasticine', 'seoul256', 'softbluev2', 'soso', 'tabula', 'moonshine', 'moss', 'monokai-phoenix', 'minimalist', 'magellan', 'luinnar']
    let g:fav_colors_idx = RandomNumber(0, len(g:fav_colors)-1)
    echo g:fav_colors[g:fav_colors_idx]
    :exe "colo " .. g:fav_colors[g:fav_colors_idx]
    let g:color_idx = index(g:colors, g:colors_name)
endfunction
nnoremap <leader>t :call ToggleColorScheme()<CR>

function FormatJSON()
    :1,$s/'/"/g
    :1,$s/None/null/g
    :1,$s/False/false/g
    :1,$s/True/true/g
    :%!python -m json.tool
endfunction
command! -bar FormatJSON call FormatJSON()

function ObsidianLink()
    let g:previouslink=expand("%:p")
    execute("Glcd")
    let startlink=searchpos('[[', 'bn', line('.'))[1] + 1
    let endlink=searchpos(']]', 'n', line('.'))[1] - 2
    let ss=getline(".")[startlink:endlink] . ".md"
    let pwd=getcwd() . "/"
    let obsidianlink=fnameescape(pwd . ss)
    execute("e " . obsidianlink)
endfunction
function ObsidianGoBack()
    if exists("g:previouslink")
        execute("e " . g:previouslink)
    endif
endfunction

let g:colors = getcompletion('', 'color')
let g:color_idx = index(g:colors, g:colors_name)
func! NextColors()
    if g:color_idx <= (len(g:colors) - 1)
        let g:color_idx += 1
    else
        let g:color_idx = 0
    endif
    echo g:colors[g:color_idx]
    return g:colors[g:color_idx]
endfunc
func! PrevColors()
    if g:color_idx >= 0
        let g:color_idx -= 1
    else
        let g:color_idx = len(g:colors) - 1
    endif
    echo g:colors[g:color_idx]
    return g:colors[g:color_idx]
endfunc
func! RandoColor()
    let g:color_idx = RandomNumber(0, len(g:colors)-1)
    echo g:colors[g:color_idx]
    :exe "colo " .. g:colors[g:color_idx]
    :exe "AirlineTheme random"
endfunc
nnoremap <leader>[ :exe "colo " .. NextColors()<CR>
nnoremap <leader>] :exe "colo " .. PrevColors()<CR>
nnoremap <leader>c :call RandoColor()<CR>
