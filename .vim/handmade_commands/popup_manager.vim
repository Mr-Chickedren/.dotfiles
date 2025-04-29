" init setting""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let s:remind_file = expand('~/.vim/handmade_commands/reminder/pop_list.json')

" restore pop_list while start vim
if filereadable(s:remind_file)
	let content = join(readfile(s:remind_file), "\n")
	let s:pop_list = json_decode(content)

	if type(s:pop_list) == type([])
		for p in s:pop_list
			let id = popup_create(
				\ p['content'],
				\ {
					\ 'line': p['posy'],
					\ 'col': p['posx'],
					\ 'minwidth': p['width'],
					\ 'minheight': p['height'],
					\ 'border': p['border'],
					\ 'borderchars': ['─', '│', '─', '│', '┌', '┐', '┘', '└'],
					\ 'highlight': 'cleared',
					\ 'fixed': 1,
					\ 'zindex': p['zindex'],
				\ }
			\ )

			let p['id'] = id
		endfor
	endif
endif

" store pop_list while finish vim
autocmd VimLEavePre * call s:SavePop()

function! s:SavePop() abort
	if exists('s:pop_list') && type(s:pop_list) == type([])
		let json = json_encode(s:pop_list)
		call writefile(split(json, "\n"), s:remind_file)
	endif
endfunction


" public fnction""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" create popup window
function! PopCreate(name, content, posx, posy, width, height, border, zindex)
	if !exists('s:pop_list') || type(s:pop_list) != type([])
		let s:pop_list = []
	endif

	if type(s:pop_list) == type([])
		for l:p in s:pop_list
			if l:p['name'] ==# a:name
				echo "Error: Don't register same name"
				return
			endif
		endfor
	endif

	let l:id = popup_create(
		\ a:content,
		\ {
			\ 'line': a:posy,
			\ 'col': a:posx,
			\ 'minwidth': a:width,
			\ 'minheight': a:height,
			\ 'border': a:border,
			\ 'borderchars': ['─', '│', '─', '│', '┌', '┐', '┘', '└'],
			\ 'highlight': 'cleared',
			\ 'fixed': 1,
			\ 'zindex': a:zindex,
		\ }
	\ )

	let l:addpop = {
		\ 'id': l:id,
		\ 'name': a:name,
		\ 'content': a:content,
		\ 'posx': a:posx,
		\ 'posy': a:posy,
		\ 'width': a:width,
		\ 'height': a:height,
		\ 'border': a:border,
		\ 'zindex': a:zindex,
		\ }

	call add(s:pop_list, l:addpop)
endfunction

" delete popup window
function! PopDelete(name)
	if exists('s:pop_list') && type(s:pop_list) == type([])
		for l:i in range(len(s:pop_list) - 1, 0, -1)
			if s:pop_list[l:i]['name'] ==# a:name
				call popup_close(s:pop_list[l:i]['id'])
				call remove(s:pop_list, l:i)
			endif
		endfor
	endif
endfunction


" for maintenance"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! PopList()
	if exists('s:pop_list') && type(s:pop_list) == type([])
		for l:item in s:pop_list
			echo l:item['id'] . ": " . l:item['name']
		endfor
	endif
endfunction
