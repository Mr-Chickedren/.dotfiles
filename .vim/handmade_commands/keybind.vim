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
	endif
endfunction
