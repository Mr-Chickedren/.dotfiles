let s:pop_list = {}	"{ <name>: <popup_id>, ... }
let s:name = ""
let s:content = []
let s:zindex = 0
let s:size = {'x': 0, 'y': 0}
let s:pos = {'x': 0, 'y': 0}

" help
function! PopHelp()
	echo "PopName(\"<name>\")\t name popup manu"
	echo "PopContent([\"..\", \"..\"]) register content"
	echo "PopZindex(..)\t\t register zindex"
	echo "PopSize(x,y)\t\t register size in popup manu"
	echo "PopPos(x,y)\t\t register position in popup manu"
	echo "PopList()\t\t list names of popup manu"
	echo "PopCreate()\t\t create popup manu"
	echo "PopDelete(\"<name>\")\t delete popup manu"
endfunction

" set name
function! PopName(name)
	let s:name = a:name
endfunction

" set content
function! PopContent(content)
	let s:content = a:content
endfunction

" set zindex
function! PopZindex(zindex)
	let s:zindex = a:zindex
endfunction

" set popup_menu size
function! PopSize(x, y)
	let s:size = {'x': a:x, 'y': a:y}
endfunction

" set popup_menu position
function! PopPos(x, y)
	let s:pos = {'x': a:x, 'y': a:y}
endfunction


" list popup_menu
function! PopList()
	let l:notexist = v:true

	for [name, id] in items(s:pop_list)
		let l:notexist = v:false
		echo "name: " . name . " id: " . id
	endfor

	if l:notexist
		echo "-- no popup menu --\n"
	endif
endfunction

" create popup window
function! PopCreate()
	if s:name == ""
		echo "Error: Please name popup_menu"
		return
	elseif has_key(s:pop_list, s:name)
		echo "Error: Don't register same name"
		return
	endif

	let l:id = popup_create(
		\ s:content,
		\ {
			\ 'line': s:pos.y,
			\ 'col': s:pos.x,
			\ 'minwidth': s:size.x,
			\ 'minheight': s:size.y,
			\ 'border': [1, 1, 1, 1],
			\ 'borderchars': ['─', '│', '─', '│', '┌', '┐', '┘', '└'],
			\ 'highlight': 'cleared',
			\ 'resize': 1,
			\ 'zindex': s:zindex,
		\ }
	\ )

	let s:pop_list[s:name] = l:id
endfunction

" delete popup window
function! PopDelete(name)
	if has_key(s:pop_list, a:name)
		call popup_close(s:pop_list[a:name])
		call remove(s:pop_list, a:name)
	endif
endfunction
