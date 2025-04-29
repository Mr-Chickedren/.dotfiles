let s:pop_list = {}	"{ <name>: <popup_id>, ... }

" create popup window
function! PopCreate(name, content, posx, posy, width, height, border, zindex)
	if has_key(s:pop_list, a:name)
		echo "Error: Don't register same name"
		return
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

	let s:pop_list[a:name] = l:id
endfunction

" delete popup window
function! PopDelete(name)
	if has_key(s:pop_list, a:name)
		call popup_close(s:pop_list[a:name])
		call remove(s:pop_list, a:name)
	endif
endfunction
