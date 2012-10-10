set nocompatible

filetype on
filetype plugin on
syntax on

"4 characters indents, no tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set smartindent
set backspace=2

set smartcase
set encoding=utf-8
set showcmd
set showmode
set showmatch
set history=1000
set ttyfast

"Other stuff
"set backupdir=~/.vim/backup,/tmp
set autoindent
set textwidth=79
set columns=105
set number

color desert

set modelines=0

inoremap jj <ESC>

set noanti
set hlsearch

nmap <silent> <C-e> :NERDTreeToggle<CR>
nmap <silent> <C-h> :tabp<CR>
nmap <silent> <C-l> :tabn<CR>
nnoremap <C-q> :noh<CR>

