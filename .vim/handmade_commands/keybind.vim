function! SetKeybind(mode)
	if a:mode == "normal"
		nnoremap ; :
		nnoremap : ;
		nnoremap <silent> <Esc><Esc> :nohlsearch<Bar>echo ""<CR>

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
	endif
endfunction
