" color
source ~/.vim/colors.vim

" indent setting
autocmd FileType rust,vim set smartindent
autocmd FileType rust,vim set autoindent

" editor visual
set number
set fillchars+=eob:\ 
set fillchars+=vert:┃
set fillchars+=stl:─,stlnc:─
set noruler
set tabstop=3
set softtabstop=3
set shiftwidth=3
"set expandtab

" sound
set belloff=all

" search
set hlsearch
set incsearch

" cursor type
set timeoutlen=500
set ttimeoutlen=10
let &t_SI = "\e[5 q"
let &t_EI = "\e[0 q"

" clipboard
set clipboard=unnamedplus

" key mapping
let mapleader = " "

nnoremap ; :
nnoremap : ;
nnoremap <silent> <Esc><Esc> :nohlsearch<Bar>echo ""<CR>
nnoremap <Down> <Nop>
nnoremap <Up> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>

inoremap { {}<Left>
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap < <><Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <Down> <Nop>
inoremap <Up> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
cnoremap <Down> <Nop>
cnoremap <Up> <Nop>
cnoremap <Left> <Nop>
cnoremap <Right> <Nop>

nnoremap <Leader>h <Plug>(hello-echo_hello)
nnoremap <Leader><Tab> <Plug>(explopup-handler)
