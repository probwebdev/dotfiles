call plug#begin()

Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'

call plug#end()

"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set ttyfast

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs
set tabstop=2
set softtabstop=0
set shiftwidth=2
set expandtab

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

"" Fileformats
set fileformats=unix,dos,mac

"" Editor
set ruler
set number
set nocompatible
set modelines=0
set noshiftround
set laststatus=2
set showmode
set showcmd

"" Airline config
let g:airline_powerline_fonts = 1
