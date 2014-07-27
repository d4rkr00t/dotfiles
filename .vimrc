"--------------------------------------------------
" NeoBundle Init

" Turn off filetype plugins before bundles init
filetype off
" Auto installing NeoNeoBundle
let isNpmInstalled = executable("npm")
let iCanHazNeoBundle=1
let neobundle_readme=expand($HOME.'/.vim/bundle/neobundle.vim/README.md')
if !filereadable(neobundle_readme)
    if !isNpmInstalled
        echo "==============================================="
        echo "Your need to install npm to enable all features"
        echo "==============================================="
    endif
    echo "Installing NeoBundle.."
    silent !mkdir -p $HOME/.vim/bundle
    silent !git clone https://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/neobundle.vim
    let iCanHazNeoBundle=0
endif

" Call NeoBundle
if has('vim_starting')
    set runtimepath+=$HOME/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand($HOME.'/.vim/bundle/'))

" Determine make or gmake will be used for making additional deps for Bundles
let g:make = 'gmake'
if system('uname -o') =~ '^GNU/'
    let g:make = 'make'
endif

" Change leader to a comma because the backslash is too far away
" That means all \x commands turn into ,x
" The mapleader has to be set before vundle starts loading all
" the plugins.
let mapleader=","

"--------------------------------------------------
" Bundles

" Colorscheme solarazied for vim
NeoBundle 'altercation/vim-colors-solarized'

" CtrlP Full path fuzzy file, buffer, mru, tag, ... finder for Vim.
NeoBundle 'kien/ctrlp.vim'
let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }

" NerdTree. A tree explorer plugin for vim.
NeoBundle 'scrooloose/nerdtree'
nmap <silent> <leader>f :NERDTreeToggle<CR>

" Fugitive
NeoBundle 'tpope/vim-fugitive'

" Add smart commands for comments like:
" gcc - Toggle comment for the current line
" gc  - Toggle comments for selected region or number of strings
" Very usefull
NeoBundle 'tomtom/tcomment_vim'

" Surround.vim
NeoBundle 'tpope/vim-surround'

" NeoComplCache — autocompletion
NeoBundle 'Shougo/neocomplcache.vim'

" Syntastic
NeoBundle 'scrooloose/syntastic'

" Install jshint and csslint for syntastic
" Path to jshint if it not installed globally, then use local installation
if !executable("jshint")
    "let g:syntastic_jshint_exec = '~/.vim/node_modules/.bin/jshint'
    let g:syntastic_javascript_jshint_exec = '~/.vim/node_modules/.bin/jshint'
    if isNpmInstalled && !executable(expand(g:syntastic_javascript_jshint_exec))
        silent ! echo 'Installing jshint' && npm --prefix ~/.vim/ install jshint
    endif
endif
" Path to csslint if it not installed globally, then use local installation
if !executable("csslint")
    let g:syntastic_css_csslint_exec='~/.vim/node_modules/.bin/csslint'
    if isNpmInstalled && !executable(expand(g:syntastic_css_csslint_exec))
        silent ! echo 'Installing csslint' && npm --prefix ~/.vim/ install csslint
    endif
endif

" Syntax and other productivity

NeoBundle 'mattn/emmet-vim'
let g:user_emmet_expandabbr_key='<Tab>'
imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

NeoBundle 'SevInf/vim-bemhtml'
"--------------------------------------------------
" Colorscheme

" Use solarized colorscheme
colorscheme solarized

" Setting up light color scheme
set background=dark


"--------------------------------------------------
" General options

" Turn Off Swap Files
set noswapfile
set nobackup
set nowb

" No compatibility
set nocompatible
set encoding=utf-8

" status bar
set statusline=%F%m%r%h%w\  "fullpath and status modified sign
set statusline+=\ %y "filetype
set statusline+=\ %{fugitive#statusline()}
set statusline+=%= " this line bumps the line number to RHS
set statusline+=[wc:%{WordCount()}]
set statusline+=\ [%l\/%c\/%L] "line number and column number

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

"Store lots of :cmdline history
set history=1000

"Reload files changed outside vim
set autoread

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
" set clipboard=unnamed

" Detect filetype
filetype indent plugin on

" Enable syntax highighting
syntax on

" show matching bracket for 0.2 seconds
set matchtime=2

" specially for html
set matchpairs+=<:>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

" 256 colours, please
set t_Co=256

" detect file type
filetype plugin indent on

" 4 spaces please
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4

" Round indent to nearest multiple of 4
set shiftround

" Start scrolling slightly before the cursor reaches an edge
set scrolloff=3
set sidescrolloff=5

" Scroll sideways a character at a time, rather than a screen at a time
set sidescroll=1

" Allow motions and back-spacing over line-endings etc
set backspace=indent,eol,start
set whichwrap=h,l,b,<,>,~,[,]

set iskeyword-=_

" Show status line
set laststatus=2

" Show what mode you’re currently in
set showmode

" Show what commands you’re typing
set showcmd

" Respect modeline in files
set modeline
set modelines=4

" Show current line and column position in file
set ruler

" Show file title in terminal tab
set title

" Highlight current line
set cursorline

" Highlight searches
set hlsearch

" ...just highlight as we type
set incsearch

" Ignore case when searching...
set ignorecase

" ...except if we input a capital letter
set smartcase

" Enable mouse in all modes
set mouse=a

" Disable error bells
set noerrorbells

" Don’t reset cursor to start of line when moving around.
set nostartofline

" Enhance command-line completion
set wildmenu
set wildmode=list:longest
set wildignore+=*DS_Store*

" Autocmpletion hotkey
" set wildcharm=<TAB>

" Allow cursor keys in insert mode
set esckeys

" Optimize for fast terminal connections
set ttyfast

" Add the g flag to search/replace by default
set gdefault

" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure

" Enable line numbers
set number

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·
nmap <silent> <leader>s :set nolist!<CR>

" Don’t show the intro message when starting Vim
set shortmess=atI

" Do not add eol at the end of file.
set noeol

" toggle paste mode on \p
set pastetoggle=<leader>p

" Enable syntax folding in javascript
let javaScript_fold=1

" No fold closed at open file
set foldlevelstart=99
set nofoldenable

" break properly, don't split words
set linebreak

" Keymap to toggle folds with space
nmap <space> za


" =====================================
" Mapping and usefull functions

" Strip trailing whitespace (,ss)
function! StripWhitespace()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>

" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" :Q to quit (should be default)
command! Q q

" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
      \ if ! exists("g:leave_my_cursor_position_alone") |
      \     if line("'\"") > 0 && line ("'\"") <= line("$") |
      \         exe "normal g'\"" |
      \     endif |
      \ endif

" sublime key bindings
nmap ‘ >>
nmap “ <<
vmap ‘ <gv
vmap “ >gv

" move line up and down
nnoremap ∆ :m+<CR>==
nnoremap ˚ :m-2<CR>==
inoremap ∆ <Esc>:m+<CR>==gi
inoremap ˚ <Esc>:m-2<CR>==gi
vnoremap ˚ :m-2<CR>gv=gv
vnoremap ∆ :m'>+<CR>gv=gv

" word count, taken from
" http://stackoverflow.com/questions/114431/fast-word-count-function-in-vim
function! WordCount()
  let s:old_status = v:statusmsg
  let position = getpos(".")
  exe ":silent normal g\<c-g>"
  let stat = v:statusmsg
  let s:word_count = 0
  if stat != '--No lines in buffer--'
    let s:word_count = str2nr(split(v:statusmsg)[11])
    let v:statusmsg = s:old_status
  end
  call setpos('.', position)
  return s:word_count
endfunction

" Automatic commands
if has("autocmd")
    " Treat .json files as .js
    autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
    " set some markdown specific things
    autocmd FileType markdown setlocal shiftwidth=4 softtabstop=4 tabstop=4
    " wrap linebreak nolist wrap lbr colorcolumn=0
    autocmd FileType markdown setlocal statusline+=\ %{WordCount()}
    autocmd FileType tex setlocal colorcolumn=0 wrap lbr linebreak spell
endif

"--------------------------------------------------
" Diff Options

" Display filler
set diffopt=filler

" Open diff in horizontal buffer
set diffopt+=horizontal

" Ignore changes in whitespaces characters
set diffopt+=iwhite
