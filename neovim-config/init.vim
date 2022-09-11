set shell=/bin/zsh
set shiftwidth=4
set tabstop=4
set expandtab
set autoindent
set hlsearch
set clipboard=unnamed
syntax on

call plug#begin()

Plug 'ntk148v/vim-horizon'
Plug 'preservim/nerdtree'

call plug#end()

" if you don't set this option, this color might not correct.
set termguicolors

colorscheme horizon

" rightline
let g:lightline = {}
let g:lightline.olorscheme = 'horizon'

