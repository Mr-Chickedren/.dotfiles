" { [name] : [popup_number], ... }
let s:pop_list = {}

" create popup window
function! PopCreate(name, height, width, margin_height, margin_width, content, zindex)
	for name in keys(s:pop_list)
		if name == a:name
			echo "Error: Don't register same name"
			return
		endif
	endfor

	let l:id = popup_create(
		\ a:content,
		\ {
			\ 'line': a:margin_height,
			\ 'col': a:margin_width,
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
