function! SetKeybind(mode)
	if a:mode == "normal"
		nnoremap ; :
		nnoremap : ;
		inoremap <C-j> <Down>
		inoremap <C-k> <Up>
		inoremap <C-h> <Left>
		inoremap <C-l> <Right>
	endif
endfunction
