" If vundle is not installed, do it first
if (!isdirectory(expand("$HOME/.vim/bundle/vundle")))
    call system(expand("mkdir -p $HOME/.vim/bundle"))
    call system(expand("git clone https://github.com/gmarik/vundle $HOME/.vim/bundle/vundle"))
    echoerr 'Vundle was freshly installed. You should run :BundleInstall'
endif

let isNpmInstalled = executable("npm")

set nocompatible      " This should be the first line. It sets vim to not be backwards compatible with vi.
let mapleader = ","   " Set the map leader. Useful for custom commands.

" Install and setup vundle https://github.com/gmarik/Vundle.vim
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

"--------------------------------------------------
" Plugins

Bundle 'tpope/vim-fugitive'
Bundle 'kien/ctrlp.vim'
Bundle 'sjl/gundo.vim'
Bundle 'tomtom/tlib_vim'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'acevery/snipmate-plus'
Bundle 'ag.vim'
Bundle 'bling/vim-airline'
Bundle 'vim-scripts/IndentConsistencyCop'
Bundle 'scrooloose/nerdtree'
Bundle 'jszakmeister/vim-togglecursor'

" Syntax plugins
Bundle 'Shougo/neocomplcache.vim'
Bundle 'Syntastic'
Bundle 'tomtom/tcomment_vim'

" CSS
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'git://github.com/hail2u/vim-css3-syntax.git'
Bundle 'git://github.com/ap/vim-css-color.git'
Bundle 'git://github.com/groenewege/vim-less.git'
Bundle 'git://github.com/miripiruni/vim-better-css-indent.git'
Bundle 'git://github.com/csscomb/csscomb-for-vim.git'
Bundle 'git://github.com/wavded/vim-stylus.git'

" JavaScript
Bundle 'SevInf/vim-bemhtml'
Bundle 'pangloss/vim-javascript'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'git://github.com/itspriddle/vim-jquery.git'
Bundle 'git://github.com/leshill/vim-json.git'

" Provide smart autocomplete results for javascript, and some usefull commands
if has("python")
    Bundle 'marijnh/tern_for_vim'
    " install node dependencies for tern
    if isNpmInstalled && isdirectory(expand('~/.vim/bundle/tern_for_vim')) && !isdirectory(expand('~/.vim/bundle/tern_for_vim/node_modules'))
        silent ! echo 'Installing tern' && npm --prefix ~/.vim/bundle/tern_for_vim install
    endif
endif

Bundle 'mattn/emmet-vim'

Bundle 'HTML-AutoCloseTag'
Bundle 'gregsexton/MatchTag'
Bundle 'othree/html5.vim'

" Themes
Bundle 'altercation/vim-colors-solarized'

"--------------------------------------------------
" Plugins Config

" Enable Indent in plugins
filetype plugin indent on

" Enable syntax highlighting
syntax on

set t_Co=256
let g:solarized_termcolors=256

set laststatus=2

"-------------------------
" CtrlP

" let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_custom_ignore = '\v[\/](\.(git|hg|svn)|node_modules)$'

" show hidden files
let g:ctrlp_show_hidden = 1

nnoremap ff :CtrlP<CR>

"-------------------------
" vim-airline

" Colorscheme for airline
" let g:airline_theme='understated'

" Set custom left separator
let g:airline_left_sep = '▶'

" Set custom right separator
let g:airline_right_sep = '◀'

" Enable airline for tab-bar
let g:airline#extensions#tabline#enabled = 1

" Don't display buffers in tab-bar with single tab
let g:airline#extensions#tabline#show_buffers = 0

" Display only filename in tab
let g:airline#extensions#tabline#fnamemod = ':t'

" Don't display encoding
let g:airline_section_y = ''

" Don't display filetype
let g:airline_section_x = ''

"-------------------------
" NERDTree

" Tell NERDTree to display hidden files on startup
let NERDTreeShowHidden=1

" Disable bookmarks label, and hint about '?'
let NERDTreeMinimalUI=1

" Display current file in the NERDTree ont the left
nmap <silent> <leader>f :NERDTreeFind<CR>

" Toggle Nerd Tree
nmap <silent> <leader>t :NERDTreeToggle<CR>

"-------------------------
" Syntastic

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

" Enable autochecks
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1

" For correct works of next/previous error navigation
let g:syntastic_always_populate_loc_list = 1

" check json files with jshint
let g:syntastic_filetype_map = { "json": "javascript", }

" open quicfix window with all error found
nmap <silent> <leader>ll :Errors<cr>
" previous syntastic error
nmap <silent> [ :lprev<cr>
" next syntastic error
nmap <silent> ] :lnext<cr>

"-------------------------
" neocomplcache

" Enable NeocomplCache at startup
let g:neocomplcache_enable_at_startup = 1

" Max items in code-complete
let g:neocomplcache_max_list = 10

" Max width of code-complete window
let g:neocomplcache_max_keyword_width = 80

" Code complete is ignoring case until no Uppercase letter is in input
let g:neocomplcache_enable_smart_case = 1

" Auto select first item in code-complete
let g:neocomplcache_enable_auto_select = 1

" Disable auto popup
" let g:neocomplcache_disable_auto_complete = 1

" Smart tab Behavior
function! CleverTab()
    " If autocomplete window visible then select next item in there
    if pumvisible()
        return "\<C-n>"
    endif
    " If it's begining of the string then return just tab pressed
    let substr = strpart(getline('.'), 0, col('.') - 1)
    let substr = matchstr(substr, '[^ \t]*$')
    if strlen(substr) == 0
        " nothing to match on empty string
        return "\<Tab>"
    else
        " If not begining of the string, and autocomplete popup is not visible
        " Open this popup
        return "\<C-x>\<C-u>"
    endif
endfunction
inoremap <expr><TAB> CleverTab()

" Undo autocomplete
inoremap <expr><C-e> neocomplcache#undo_completion()

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS

" For cursor moving in insert mode
inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"

" disable preview in code complete
set completeopt-=preview

"--------------------------------------------------
" General options

" Auto reload changed files
set autoread

" Indicates fast terminal connection
set ttyfast

" Set character encoding to use in vim
set encoding=utf-8

" Let vim know what encoding we use in our terminal
set termencoding=utf-8

"--------------------------------------------------
" Display options

" Hide showmode
" Showmode is useless with airline
set noshowmode

" Show file name in window title
set title

" Mute error bell
set novisualbell

" Remove all useless messages like intro screen and use abbreviation like RO
" instead readonly and + instead modified
set shortmess=atI

" Numbers of rows to keep to the left and to the right off the screen
set scrolloff=10

" Numbers of columns to keep to the left and to the right off the screen
set sidescrolloff=10

" Scroll sideways a character at a time, rather than a screen at a time
set sidescroll=1

" The cursor should stay where you leave it, instead of moving to the first non
" blank of the line
set nostartofline

" Display Line numbers
set number

" Highlight line with cursor
" set cursorline

"--------------------------------------------------
" Edit

" Allow backspace to remove indents, newlines and old text
set backspace=indent,eol,start

" toggle paste mode on \p
set pastetoggle=<leader>p

set history=512       " Default is 20, I'd rather set this to ∞

" Disable swp files
set noswapfile

" Do not add eol at the end of file.
set noeol

"--------------------------------------------------
" Search options

" Add the g flag to search/replace by default
set gdefault

" Highlight search results
set hlsearch

" Ignore case in search patterns
set ignorecase

" Override the 'ignorecase' option if the search patter ncontains upper case characters
set smartcase

" Live search. While typing a search command, show where the pattern
set incsearch

" Disable higlighting search result on Enter key
nnoremap <silent> <cr> :nohlsearch<cr><cr>

" Show matching brackets
set showmatch

" Make < and > match as well
set matchpairs+=<:>


"--------------------------------------------------
" Wildmenu

" Extended autocmpletion for commands
set wildmenu

" Autocmpletion hotkey
set wildcharm=<TAB>

" Set completion mode
" When more than one match, list all matches and complete first match
" Then complete the next full match
set wildmode=list:longest,full

" Ignore following files when completing file/directory names
set wildignore=node_modules/*,*.jpg,*.png,*.gif,*.woff,node_modules
set wildignore+=.hg,.git,.svn
set wildignore+=*.DS_Store

"--------------------------------------------------
" Folding

" Enable syntax folding in javascript
let javaScript_fold=1

" No fold closed at open file
set foldlevelstart=99
set nofoldenable

"--------------------------------------------------
" Tab options

" Copy indent from previous line
set autoindent

" Enable smart indent. it add additional indents whe necessary
set smartindent

" Replace tabs with spaces
set expandtab

" Whe you hit tab at start of line, indent added according to shiftwidth value
set smarttab

" number of spaces to use for each step of indent
set shiftwidth=4

" Number of spaces that a Tab in the file counts for
set tabstop=4

" Same but for editing operation (not shure what exactly does it means)
" but in most cases tabstop and softtabstop better be the same
set softtabstop=4

" Round indent to multiple of 'shiftwidth'.
" Indentation always be multiple of shiftwidth
" Applies to  < and > command
set shiftround


"--------------------------------------------------
" Key Remaps

" Grab last edited / pasted text
nnoremap gp `[v`]

" Omnicompletion
imap <leader>m <c-x><c-o>
imap <leader>, <esc>

" Tab Navigation
nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tn  :tabnew<CR>

" easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" I like to roll through buffers like
nnoremap <leader>m  :bn<CR>
nnoremap <leader>n  :bp<CR>

" Run through jumplist with ease
nnoremap cn :cn<CR>
nnoremap cp :cp<CR>

" Custom Plugin Mappings
nnoremap -- :GundoToggle<CR>

"set iskeyword+=- "Makes foo-bar considered one word
nnoremap <leader>ev :e $MYVIMRC<cr> " ,ev will open up your vimrc in a vertical split
nnoremap <leader>gb :Gbrowse<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>c :ccl<cr>
nnoremap <leader>o :copen<cr>

map <Esc><Esc> :w<CR>


" It executes specific command when specific events occured
" like reading or writing file, or open or close buffer
if has("autocmd")
    " Define group of commands,
    " Commands defined in .vimrc don't bind twice if .vimrc will reload
    augroup vimrc
    " Delete any previosly defined autocommands
    au!
        " Auto reload vim after your cahange it
        au BufWritePost *.vim source $MYVIMRC | AirlineRefresh
        au BufWritePost .vimrc source $MYVIMRC | AirlineRefresh

        autocmd BufWritePre * :%s/\s\+$//e " Remove trailing whitespace on save

        " Restore cursor position :help last-position-jump
        au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
          \| exe "normal g'\"" | endif

        " Set filetypes aliases
        " au FileType scss set ft=scss.css
        " au FileType less set ft=less.css
        au BufWinEnter * if line2byte(line("$") + 1) > 100000 | syntax clear | endif
        au BufRead,BufNewFile *.js set ft=javascript.javascript-jquery
        au BufRead,BufNewFile *.json set ft=json
        au BufRead,BufNewFile *.bemhtml set ft=javascript
        au BufNewFile,BufRead *.styl set ft=styl.css "Sets filetpe of less to be css. Helps with plugins.

        " Auto close preview window, it uses with tags,
        " I don't use it
        autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
        autocmd InsertLeave * if pumvisible() == 0|pclose|endif

        " Enable Folding, uses plugin vim-javascript-syntax
        " au FileType javascript* call JavaScriptFold()

    " Group end
    augroup END

endif

