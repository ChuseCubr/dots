" EDITOR SETTINGS
set encoding=utf-8
set nocompatible

set updatetime=250
set timeoutlen=300

set scrolloff=5
set mouse=a
set backspace=indent,eol,start

" search settings
set ignorecase
set smartcase
set nohlsearch
set incsearch

" indent/line options
set noexpandtab
set shiftwidth=2
set tabstop=2
set autoindent
set breakindent
set linebreak

" shell
set shell=pwsh
set noshelltemp

" file, completions, nav
set autoread
syntax on
filetype on
filetype plugin on
filetype indent on

set completeopt=menu,menuone,preview,noinsert,noselect
set wildmenu
set wildoptions=fuzzy,pum,tagfile
set path+=**

set csprg=gtags-cscope
set omnifunc=syntaxcomplete#Complete

" netrw
let g:netrw_liststyle=3
let g:netrw_banner=0
let g:netrw_winsize=30

" temporary files
set undofile
set backup
set swapfile

if has("win32")
	set undodir=$LOCALAPPDATA/vim-data/undo
	set backupdir=$LOCALAPPDATA/vim-data/backup
	set directory=$LOCALAPPDATA/vim-data/swap
else
	set undodir=$HOME/.local/share/vim/undo
	set backupdir=$HOME/.local/share/vim/backup
	set directory=$HOME/.local/share/vim/swap
endif

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
	call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
	call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
	call mkdir(expand(&directory), "p")
endif

" REMAPS
" gj/gk
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

let mapleader="\<space>"
let maplocalleader="\<space>"

" UI SETTINGS
" better colors (on supported terms)
set termguicolors
colorscheme sorbet

" Disable intro
set shortmess+=I

" ui elements
set title
set laststatus=3
set colorcolumn=80

" gutter
set number
set relativenumber
set signcolumn=yes

" white space characters
set showbreak=>
set list
set listchars=tab:>\ ,trail:-,extends:»,precedes:«,nbsp:_

" statusline
set laststatus=2
set statusline=
set statusline+=%n:\   " buffer number
set statusline+=%f%m%r " file info
set statusline+=%=     " right align
set statusline+=%p%%\  " file progress
set statusline+=%l:%c  " cursor position

" gui stuff
set guicursor=n-v-c-i:block
set guifont=Iosevka_NFM:h16
set belloff=all
