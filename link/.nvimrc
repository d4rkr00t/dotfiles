" Setup dein  ---------------------------------------------------------------{{
  if (!isdirectory(expand("$HOME/.config/nvim/repos/github.com/Shougo/dein.vim")))
    call system(expand("mkdir -p $HOME/.config/nvim/repos/github.com"))
    call system(expand("git clone https://github.com/Shougo/dein.vim $HOME/.config/nvim/repos/github.com/Shougo/dein.vim"))
  endif

  set runtimepath+=~/.config/nvim/repos/github.com/Shougo/dein.vim/
  call dein#begin(expand('~/.config/nvim'))
  call dein#add('Shougo/dein.vim')
  call dein#add('tpope/vim-sensible')

  " Themes
  call dein#add('dracula/vim')
  call dein#add('arcticicestudio/nord-vim')

  " Plugins
  call dein#add('itchyny/lightline.vim')
  call dein#add('scrooloose/syntastic')
  call dein#add('tpope/vim-surround')
  call dein#add('wellle/targets.vim')
  call dein#add('tpope/vim-commentary')
  call dein#add('junegunn/fzf', { 'build': './install --all' })
  call dein#add('junegunn/fzf.vim')
  call dein#add('easymotion/vim-easymotion')
  call dein#add('tpope/vim-vinegar')

  " Languages
  call dein#add('sheerun/vim-polyglot')

  " do install plugins
  if dein#check_install()
    call dein#install()
    let pluginsExist=1
  endif

  call dein#end()
  filetype plugin indent on
" }}

" System Settings  ----------------------------------------------------------{{
  " leader is ,
  let mapleader = ','

  " Search
  set gdefault " use global flag by default in s: commands
  set hlsearch " highlight searches
  set ignorecase
  set smartcase " don't ignore capitals in searches
  " hide highlight on Enter
  nnoremap <CR> :nohls <CR><CR>

  " Neovim Settings
  set termguicolors
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  autocmd BufWritePre * %s/\s\+$//e
  filetype on

  " Line Number {{
    " Display relative line numbers
    " set relativenumber

    " display the absolute line number at the line you're on
    set number

    " Keep the line number gutter narrow so three digits is cozy.
    set numberwidth=2
  " }}

  set tabstop=2 shiftwidth=2 expandtab
  set conceallevel=0
  set wildmenu
  set laststatus=2
  set wrap linebreak nolist
  set wildmode=full
  set autoread

  set undofile
  set undodir="$HOME/.VIM_UNDO_FILES"

  " Remember cursor position between vim sessions
  autocmd BufReadPost *
             \ if line("'\"") > 0 && line ("'\"") <= line("$") |
             \   exe "normal! g'\"" |
             \ endif
             " center buffer around cursor when opening files
  autocmd BufRead * normal zz
" }}

" Themes, Commands, etc  ----------------------------------------------------{{
  syntax on
  colorscheme dracula
" }}

" System mappings  ----------------------------------------------------------{{

  " No need for ex mode
  nnoremap Q <nop>
  vnoremap // y/<C-R>"<CR>

  " recording macros is not my thing
  map q <Nop>

  " Copy to osx clipboard
  vnoremap <C-c> "*y<CR>

  " Paste from osx clipboard
  vnoremap <C-p> "*p<CR>
  noremap <C-p> "*p<CR>

  " Multi cursor
  let g:multi_cursor_next_key='<C-n>'
  let g:multi_cursor_prev_key='<C-p>'
  let g:multi_cursor_skip_key='<C-x>'
  " let g:multi_cursor_quit_key='<Esc>'

  " Align blocks of text and keep them selected
  vmap < <gv
  vmap > >gv"}}}

" }}

" Plugin settings -----------------------------------------------------------{{
  let g:vim_markdown_folding_disabled = 1

  " fzf
  imap <C-f> <plug>(fzf-complete-line)
  nnoremap <silent> <leader><space> :Files<CR>
  nnoremap <silent> <leader>a :Buffers<CR>
  nnoremap <silent> <leader>? :History<CR>
  nnoremap <silent> <leader>gl :Commits<CR>
  nnoremap <silent> <leader>ga :BCommits<CR>
  nnoremap <silent> <leader>ft :Filetypes<CR>

  " sneak.vim
  let g:sneak#label = 1
" }}
