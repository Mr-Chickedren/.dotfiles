" design setting
let s:margin_width = 5
let s:margin_height = 3
let s:cursor_char = '>'

" open explorer with popup window
function! ExpOpen()
	let s:path = fnamemodify(expand('%:p'), ':h') . '/'

	let s:id = popup_create(
		\ [],
		\ {
			\ 'line': s:margin_height,
			\ 'col': s:margin_width,
			\ 'minwidth': winwidth(0) - s:margin_width*2,
			\ 'minheight': winheight(0) - s:margin_height*2,
			\ 'border': [1, 1, 1, 1],
			\ 'borderchars': ['═', '║', '═', '║', '╔', '╗', '╝', '╚'],
			\ 'highlight': 'cleared',
			\ 'resize': 1,
		\ }
	\ )

	call s:ExpGetList()
	call ExpUpdateContent(0)

	nnoremap q <Cmd>call ExpClose()<CR>
	nnoremap <tab> <Cmd>call ExpClose()<CR>
	nnoremap j <Cmd>call ExpUpdateContent(1)<CR>
	nnoremap k <Cmd>call ExpUpdateContent(-1)<CR>
	nnoremap <Space> <Cmd>call ExpSelect()<CR>
	nnoremap h <Nop>
	nnoremap l <Nop>
	nnoremap i <Nop>
	nnoremap I <Nop>
	nnoremap a <Nop>
	nnoremap A <Nop>
	nnoremap o <Nop>
	nnoremap O <Nop>
	nnoremap <CR> <Nop>

endfunction

" close popup window
function! ExpClose()
	call popup_close(s:id)

	nnoremap q q
	nnoremap j j
	nnoremap k k
	nnoremap <Space> <Space>
	nnoremap h h
	nnoremap l l
	nnoremap i i
	nnoremap I I
	nnoremap a a
	nnoremap A A
	nnoremap o o
	nnoremap O O
	nnoremap <CR> <CR>
	nnoremap <Tab> <Cmd>Exp<CR>

endfunction

" get list of file and directory and print it
function! s:ExpGetList()
	let s:list = systemlist('ls -ap ' . shellescape(s:path) . ' | xargs -n 1 echo')
	call filter(s:list, 'v:val !~ ".vim.swp"')

	let s:cursor = 0
endfunction

" attach cursor from list and move cursor by the number of 'cursor_movement' and update popup window
function! ExpUpdateContent(cursor_movement)
	let l:content = copy(s:list)
	if 0 <= s:cursor + a:cursor_movement && s:cursor + a:cursor_movement < len(s:list)
		let s:cursor = s:cursor + a:cursor_movement

		for i in range(0, len(s:list) - 1)
			if s:cursor == i
				let l:content[i] = s:cursor_char . ' ' . l:content[i]
			else
				let l:content[i] = '  ' . l:content[i]
			endif
		endfor

		let l:content = ['[ ' . fnamemodify(s:path, ':p') . ' ]', ''] + l:content

		call popup_settext(s:id, l:content)
	endif
endfunction

" open selected path. if already open, change buffer.
function! s:ExpFileOpen(path)
	let l:absolute_path = fnamemodify(a:path, ':p')

	for buf in range(1, bufnr('$'))
		if bufexists(buf) && bufname(buf) != '' && fnamemodify(bufname(buf), ':p') == l:absolute_path
			execute 'buffer ' . l:absolute_path
		endif
	endfor

	execute 'e ' . l:absolute_path
endfunction

" behavior when selected from list
function! ExpSelect()
	if s:list[s:cursor] =~ '/$'
		let s:path = s:path . s:list[s:cursor]
		call s:ExpGetList()
		call ExpUpdateContent(0)
	else
		call s:ExpFileOpen(s:path . s:list[s:cursor])
	endif
endfunction

" create command
command! Exp call ExpOpen()

" key map
nnoremap <Tab> <Cmd>Exp<CR>
