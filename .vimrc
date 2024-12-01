" color
source ~/.vim/colors.vim

" handmade commands
source ~/.vim/handmade_commands/explopup.vim
source ~/.vim/handmade_commands/keybind.vim

" editor visual
set number
set fillchars=eob:\ 
set tabstop=3
set softtabstop=3
set shiftwidth=3
"set expandtab

" cursor type
set timeoutlen=500
set ttimeoutlen=10
let &t_SI = "\e[5 q"
let &t_EI = "\e[0 q"

" clipboard
set clipboard=unnamedplus

" key map (-> ~/.vim/handmade_commands/keybind.vim)
:call SetKeybind("normal")
