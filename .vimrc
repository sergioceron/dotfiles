set nocompatible

filetype on
filetype plugin on
filetype indent on
syntax on

call pathogen#infect('~/.vim/bundle')

"4 characters indents, no tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set smartindent
set backspace=2

set title
set smartcase
set encoding=utf-8
set showcmd
set showmode
set showmatch
set history=1000
set noerrorbells
set ttyfast

"Other stuff
"set backupdir=~/.vim/backup,/tmp
set autoindent
set number
set ruler
set ls=2

" siq standards
"set textwidth=100
set textwidth=79
set columns=105

set modelines=0

set noanti
set hlsearch

"key bindings
inoremap jj <ESC>
nmap <silent> <C-e> :NERDTreeToggle<CR>
nmap <silent> <C-h> :tabp<CR>
nmap <silent> <C-l> :tabn<CR>
nnoremap <C-q> :noh<CR>


set background=light
colorscheme desert

"nerdtree stuff
autocmd vimenter * if !argc() | NERDTree | endif
let NERDTreeIgnore = ['\.pyc$']
let NERDTreeShowLineNumbers=1

set completeopt=longest,menuone
set incsearch
