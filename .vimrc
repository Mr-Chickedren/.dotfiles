" color
source ~/.vim/colors.vim

" handmade commands
source ~/.vim/handmade_commands/keybind.vim
source ~/.vim/handmade_commands/popup_manager.vim
source ~/.vim/handmade_commands/expr.vim

"indent setting
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

" key map (-> ~/.vim/handmade_commands/keybind.vim)
let mapleader = " "
:call SetKeybind("normal")
