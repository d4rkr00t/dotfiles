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

" FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

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
Plug 'mxw/vim-jsx'

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
set laststatus=2
set shortmess+=Icm
set diffopt+=vertical

" Show block cursor in Normal mode and line cursor in Insert mode
" (use odd numbers for blinking cursor):
let &t_ti.="\e[2 q"
let &t_SI.="\e[6 q"
let &t_SR.="\e[4 q"
let &t_EI.="\e[2 q"
let &t_te.="\e[0 q"

set tabstop=2     " number of visual spaces per TAB
set softtabstop=2 " number of spaces in tab when editing
set shiftwidth=2  " number of spaces to use for each step of indent
set expandtab     " tabs are spaces
set smarttab
set shiftround    " Round indent to multiple of 'shiftwidth'.

set foldenable    " disable folding

set incsearch     " search as characters are entered
set hlsearch      " highlight matches
set smartcase     " don't ignore capitals in searches
set ignorecase
set gdefault      " Add the g flag to search/replace by default
if executable('rg')
  set grepprg=rg\ -i\ --vimgrep
endif
set grepformat^=%f:%l:%c:%m

set backspace=indent,eol,start " Backspace
" set esckeys                  " Allow cursor keys in insert mode
set encoding=utf-8 nobomb      " Use UTF-8 without BOM
set fileformats=unix,mac,dos

" Editing
set autoindent                  " Use indentation of the first-line when reflowing a paragraph
set shiftround                  " Round indent to multiple of shiftwidth (applies to < and >)
set backspace=indent,eol,start  " Intuitive backspacing in insert mode
set whichwrap=b,~,<,>,[,],h,l   " More intuitive arrow movements
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set formatoptions+=1j           " Do not wrap after a one-letter word and remove extra comment when joining lines

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

" Window navigation
nnoremap <leader>1 1<c-w>w
nnoremap <leader>2 2<c-w>w
nnoremap <leader>3 3<c-w>w
nnoremap <leader>4 4<c-w>w
nnoremap <leader>5 5<c-w>w
nnoremap <leader>6 6<c-w>w
nnoremap <leader>7 7<c-w>w
nnoremap <leader>8 8<c-w>w
nnoremap <leader>9 9<c-w>w
nnoremap <leader>0 10<c-w>w

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

" Change to the directory of the current file
nnoremap <silent> cd :<c-u>cd %:h \| pwd<cr>

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

" Status line {{
  " See :h mode()
  let g:mode_map = {
        \ 'n': ['N', 'NormalMode' ], 'i': ['I', 'InsertMode' ],      'R': ['R', 'ReplaceMode'],
        \ 'v': ['V', 'VisualMode' ], 'V': ['V', 'VisualMode' ], "\<c-v>": ['V', 'VisualMode' ],
        \ 's': ['S', 'VisualMode' ], 'S': ['S', 'VisualMode' ], "\<c-s>": ['S', 'VisualMode' ],
        \ 'c': ['C','CommandMode'],  'r': ['P', 'CommandMode'],      't': ['T','CommandMode'],
        \ '!': ['!',  'CommandMode']}

  " newMode may be a value as returned by mode() or the name of a highlight group
  " Note: setting highlight groups while computing the status line may cause the
  " startup screen to disappear. See: https://github.com/powerline/powerline/issues/250
  fun! s:updateStatusLineHighlight(newMode)
    execute 'hi! link CurrMode' get(g:mode_map, a:newMode, ["", a:newMode])[1]
    return 1
  endf

  " nr is always the number of the currently active window. In a %{} context, winnr()
  " always refers to the window to which the status line being drawn belongs. Since this
  " function is invoked in a %{} context, winnr() may be different from a:nr. We use this
  " fact to detect whether we are drawing in the active window or in an inactive window.
  fun! SetupStl(nr)
    return get(extend(w:, {
          \ "lf_active": winnr() != a:nr
            \ ? 0
            \ : (mode() ==# get(g:, "lf_cached_mode", "")
              \ ? 1
              \ : s:updateStatusLineHighlight(get(extend(g:, { "lf_cached_mode": mode() }), "lf_cached_mode"))
              \ ),
          \ "lf_winwd": winwidth(winnr())
          \ }), "", "")
  endf

  " Build the status line the way I want - no fat light plugins!
  fun! BuildStatusLine(nr)
    return '%{SetupStl('.a:nr.')}
          \%#CurrMode#%{w:["lf_active"] ? "  " . get(g:mode_map, mode(), [mode()])[0] . (&paste ? " PASTE " : " ") : ""}%*
          \ %{winnr()} %{&modified ? "◦" : " "} %t (%n) %{&modifiable ? (&readonly ? "▪" : " ") : "✗"}
          \ %<%{empty(&buftype) ? (w:["lf_winwd"] < 80 ? (w:["lf_winwd"] < 50 ? "" : expand("%:p:h:t")) : expand("%:p:~:h")) : ""}
          \ %=
          \ %w %{&ft} %{w:["lf_winwd"] < 80 ? "" : " " . (strlen(&fenc) ? &fenc : &enc) . (&bomb ? ",BOM " : " ")
          \ . &ff . (&expandtab ? "" : " ⇥ ")} %l:%v %P
          \ %#Warnings#%{w:["lf_active"] ? get(b:, "lf_stl_warnings", "") : ""}%*'
  endf

  fun! s:enableStatusLine()
    if exists("g:default_stl") | return | endif
    augroup lf_warnings
      autocmd!
      autocmd BufReadPost,BufWritePost * call <sid>update_warnings()
    augroup END
    set noshowmode " Do not show the current mode because it is displayed in the status line
    set noruler
    let g:default_stl = &statusline
    let g:default_tal = &tabline
    set statusline=%!BuildStatusLine(winnr()) " winnr() is always the number of the *active* window
    set tabline=%!BuildTabLine()
  endf

  " Update trailing space and mixed indent warnings for the current buffer.
  fun! s:update_warnings()
    if exists('b:lf_no_warnings')
      unlet! b:lf_stl_warnings
      return
    endif
    if exists('b:lf_large_file')
      let b:lf_stl_warnings = '  Large file '
      return
    endif
    let l:trail  = search('\s$',       'cnw')
    let l:spaces = search('^\s\{-} ',  'cnw')
    let l:tabs   = search('^\s\{-}\t', 'cnw')
    if l:trail || (l:spaces && l:tabs)
      let b:lf_stl_warnings = ' '
            \ . (l:trail            ? 'Trailing space ('.l:trail.') '           : '')
            \ . (l:spaces && l:tabs ? 'Mixed indent ('.l:spaces.'/'.l:tabs.') ' : '')
    else
      unlet! b:lf_stl_warnings
    endif
  endf
  
  call <sid>enableStatusLine()
" }}

"-------------------------
"
" Plugins Configs
"
"

" Theme
colorscheme dracula

" Airline config
" let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
" let g:airline_theme='violet'

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
