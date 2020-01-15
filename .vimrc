" Pathogen
filetype off
" call pathogen#runtime_append_all_bundles()
filetype plugin indent on

" It's 2020. Don't try to be compatible with Vi
set nocompatible

" Modelines increases security exploit potential
set modelines=0

" Tab settings
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" Change the <leader> key
let mapleader = ","

"" Alternative for ESC
inoremap kj <esc>
cnoremap kj <C-C>

" Editing qol
set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set relativenumber
set undofile

" Movement
" https://stevelosh.com/blog/2010/09/coming-home-to-vim/#using-the-leader
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

" Long lines
set colorcolumn=80,100

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Display invisible characters
set list
set listchars=tab:▸\ ,eol:¬

" Disable help for when you fat finger ESC
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" Save on loss of focus
au FocusLost * :wa
