" EDITOR SETTINGS
set encoding=utf-8
set autoread
set undofile
set updatetime=250

" search settings
set ignorecase
set smartcase
set nohlsearch

set wildmenu
set path+=**

" indent options
set breakindent
set noexpandtab
set shiftwidth=2
set tabstop=2

set timeoutlen=300
set mouse=a
set scrolloff=5

set linebreak

set completeopt=menu,menuone,preview,noinsert,noselect

set backspace=indent,eol,start
set autoindent

" UI SETTINGS
" better colors (on supported terms)
set termguicolors

" Disable intro
set shortmess+=I

" ui elements
set title
set laststatus=3
set guicursor=n-v-c-i:block
set colorcolumn=80

" gutter
set number
set relativenumber
set signcolumn=yes

" white space characters
set showbreak=>
set list
set listchars=tab:>\ ,trail:-,extends:»,precedes:«,nbsp:_

set guifont=Iosevka_NFM_Medium:h16
colorscheme habamax

let mapleader="\<space>"
set shell=pwsh
