
syntax on
filetype plugin indent on

" colorscheme togglebit
colorscheme molokai

set encoding=utf-8
set termguicolors
set guicursor=
set background=dark
set regexpengine=1

" dont show commands in lower right corner
set noshowcmd

" more space for displaying messages
set cmdheight=2

" indent with 4 spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set autoindent

" hightlight active line
set cursorline

" hide mouse
set mouse=

" searching
set incsearch
set ignorecase
set smartcase
set nohlsearch

" integrate vim clipboard with system clipboard
set clipboard+=unnamedplus

" display title of current file in terminal title bar
set title

" allow hidden buffers
set hidden

" disable beeping
set noerrorbells

" dont wrap long lines
set nowrap

" dont use swapfiles
set noswapfile

" disable backups
set nobackup
set nowritebackup

" start scrolling when 8 lines left
set scrolloff=8

" always show the sign column
set signcolumn=yes

" new splits are added to bottom or right
set splitbelow splitright

" avoid delays when typing
set updatetime=50

set pyx=3

" display colorcolumn at 110 characters
set colorcolumn=110
highlight ColorColumn ctermbg=darkgray

" Always show status line
set laststatus=2

" Format status line to show current file
set statusline=\ %f

" reload file if changed from outside
au FocusGained,BufEnter * :checktime

