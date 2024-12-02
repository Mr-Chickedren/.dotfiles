" { [name] : [popup_number], ... }
let s:pop_list = {}

" create popup window
function! PopCreate(name, width, height, pos_x, pos_y, content, zindex)
	if has_key(s:pop_list, a:name)
		echo "Error: Don't register same name"
		return
	endif

	let l:id = popup_create(
		\ a:content,
		\ {
			\ 'line': a:pos_y,
			\ 'col': a:pos_x,
			\ 'minwidth': a:width,
			\ 'minheight': a:height,
			\ 'border': [1, 1, 1, 1],
			\ 'borderchars': ['─', '│', '─', '│', '┌', '┐', '┘', '└'],
			\ 'highlight': 'cleared',
			\ 'resize': 1,
			\ 'zindex': a:zindex,
		\ }
	\ )

	let s:pop_list[a:name] = l:id
endfunction
