" --------------------------------------------
"
" Plugins
"
"

" Auto install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Themes
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'rainglow/vim', { 'as': 'rainglow' }

" FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Airline – Status line plugin
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Surround selection with anything
Plug 'tpope/vim-surround'

" Toggle commenting
Plug 'tomtom/tcomment_vim'

" Faster movements for VIM
Plug 'easymotion/vim-easymotion'

" TypeScript
Plug 'leafgarland/typescript-vim'

" JavaScript
Plug 'pangloss/vim-javascript'

" Undo tree
Plug 'mbbill/undotree'

" Initialize all plugins
call plug#end()






" -------------------------------------
"
" GENERAL
"
"

set t_Co=256
syntax on          " syntax
filetype indent on " load filetype-specific indent files
filetype on        " enable file type detection

" Enable per-directory .vimrc files and disable unsafe commands in them {{
  set exrc
  set secure
"}}

set nocompatible       " Make Vim more useful
set ttyfast            " Optimize for fast terminal connections
set mouse=a            " Enable mouse in all modes
set autoread           " Auto reload changed files
set termencoding=utf-8 " Let vim know what encoding we use in our terminal
set shortmess=atI " Remove all useless messages like intro screen and use abbreviation like RO
set noswapfile    " Disable swp files
set history=1000  " Default is 20, I'd rather set this to ∞

set noerrorbells    " Disable error bells
set nostartofline   " Don’t reset cursor to start of line when moving around.
set noshowmode      " Showmode is useless with airline
set showcmd         " show command in bottom bar
set title           " Show the filename in the window titlebar
set number          " show line numbers
set wildmenu        " visual autocomplete for command menu
set showmatch       " highlight matching [{()}]
set matchpairs+=<:> " Make < and > match as well
set cursorline      " highlight current line
set scrolloff=3     " Start scrolling N lines before the horizontal window border
set sidescroll=1    " Enables side scroll
set guifont="SFMono:13"

set tabstop=2     " number of visual spaces per TAB
set softtabstop=2 " number of spaces in tab when editing
set shiftwidth=2  " number of spaces to use for each step of indent
set expandtab     " tabs are spaces
set shiftround    " Round indent to multiple of 'shiftwidth'.

set foldenable    " disable folding

set incsearch     " search as characters are entered
set hlsearch      " highlight matches
set smartcase     " don't ignore capitals in searches
set ignorecase
set gdefault      " Add the g flag to search/replace by default

set backspace=indent,eol,start " Backspace
" set esckeys                    " Allow cursor keys in insert mode
set encoding=utf-8 nobomb      " Use UTF-8 without BOM


"
" Backups
"
" set backupdir=~/.vim/backups
" set directory=~/.vim/swaps
" if exists("&undodir")
"   set undodir=~/.vim/undo
" endif

"
" Save undo history
"
if has("persistent_undo")
  set undodir=~/.undodir/
  set undofile
endif

"
" netrw
"
let g:netrw_banner = 0 " Removing the banner
let g:netrw_liststyle = 3 " The tree list view in netrw.
let g:netrw_browse_split = 4 " open in previous window
let g:netrw_altv = 1
let g:netrw_winsize = 25 " Set the width of the directory explorer

" Automatic commands
augroup file_types
    autocmd!
    autocmd BufRead,BufNewFile *.md   set ft=markdown
    autocmd BufRead,BufNewFile *.txt  set ft=markdown
    autocmd BufRead,BufNewFile *.js   set ft=javascript syntax=javascript
    autocmd BufRead,BufNewFile *.jsx  set ft=javascript syntax=javascript
    autocmd BufRead,BufNewFile *.jsm  set ft=javascript syntax=javascript
    autocmd BufRead,BufNewFile *.ts   set ft=typescript syntax=typescript
    autocmd BufRead,BufNewFile *.tsx  set ft=typescript syntax=typescript
    autocmd BufRead,BufNewFile *.json set ft=json       syntax=javascript
augroup END

" Remember cursor position between vim sessions
autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  " center buffer around cursor when opening files
autocmd BufRead * normal zz
" }}






" ----------------------------------------------
"
" System mappings
"

let mapleader="," " leader is comma

" Q exists too
:command! Q q

" turn off search highlight by pressing Enter
nnoremap <CR> :noh<CR><CR>

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" Select last inserted text
nnoremap gV `[v`]

" No need for ex mode
nnoremap Q <nop>
vnoremap // y/<C-R>"<CR>

" recording macros is not my thing
map q <Nop>

" Align blocks of text and keep them selected
vmap < <gv
vmap > >gv"}}}

" Strips whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Window splitting remap"
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>q <C-w>s<C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j

" Toggle pasting mode
set pastetoggle=<leader>P

" Save buffer on double Esc
map <Esc><Esc> :w<CR>

" Copy / Paste
noremap <leader>y "*y
noremap <leader>p "*p

" Keep cursor where I expect it to be after yanking – http://ddrscott.github.io/blog/2016/yank-without-jank/
vnoremap <expr>y "my\"" . v:register . "y`y"

" Quickly edit/reload this configuration file
nnoremap <leader>ev :e $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>


function! ToggleMovement(firstOp, thenOp)
  let pos = getpos('.')
  execute "normal! " . a:firstOp
  if pos == getpos('.')
    execute "normal! " . a:thenOp
  endif
endfunction

" 0 firsts move to the first non-blank character and on second click all the
" way to the first character in the line
nnoremap <silent> 0 :call ToggleMovement('^', '0')<CR>


"-------------------------
"
" Plugins Configs
"
"

" Theme
colorscheme dracula

" Airline config
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_theme='violet'

" fzf
let $FZF_DEFAULT_COMMAND='rg --hidden --no-ignore -l ""'

imap <C-f> <plug>(fzf-complete-line)
nnoremap <silent> <leader><space> :Files<CR>
nnoremap <silent> <leader>a :Buffers<CR>
nnoremap <silent> <leader>/ :History<CR>
nnoremap <silent> <leader>gl :Commits<CR>
nnoremap <silent> <leader>ga :BCommits<CR>
nnoremap <silent> <leader>ft :Filetypes<CR>

" undotree
nnoremap <silent> <leader>u :UndotreeShow<CR>

" vim-javascript
let g:javascript_plugin_jsdoc = 1 " Syntax highlighting for jsdoc
let g:javascript_plugin_flow = 1  " Syntax highlighting for flow
