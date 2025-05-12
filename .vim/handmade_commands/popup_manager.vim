" init setting""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let s:remind_file = expand('~/.vim/handmade_commands/reminder/pop_list.json')

" restore pop_list while start vim
if filereadable(s:remind_file)
	let content = join(readfile(s:remind_file), "\n")
	let g:pop_list = json_decode(content)
endif

" store pop_list while finish vim
autocmd VimLEavePre * call s:SavePop()

function! s:SavePop() abort
	if exists('g:pop_list') && type(g:pop_list) == type({})
		let json = json_encode(g:pop_list)
		call writefile(split(json, "\n"), s:remind_file)
	endif
endfunction


" public function""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" create popup window
function! PopCreate(name, content, posx, posy, width, height, border, zindex)
	if !exists('g:pop_list') || type(g:pop_list) != type({})
		let g:pop_list = {}
	endif

	if type(g:pop_list) == type({})
		if has_key(g:pop_list, a:name)
			echo "Error: Don't register same name"
			return
		endif
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
		\ 'content': a:content,
		\ 'posx': a:posx,
		\ 'posy': a:posy,
		\ 'width': a:width,
		\ 'height': a:height,
		\ 'border': a:border,
		\ 'zindex': a:zindex,
		\ }

	let g:pop_list[a:name] = l:addpop
endfunction

" delete popup window
function! PopDelete(name)
	if exists('g:pop_list') && type(g:pop_list) == type({}) && has_key(g:pop_list, a:name)
		call popup_close(g:pop_list[a:name]['id'])
		call remove(g:pop_list, a:name)
		return
	endif
endfunction

" change popup option
" if i change content, use popup_setoptions.
" if i change other, use PopDelete and PopCreate.
" copy dictionary and update value in dict.
function! PopOption(name, change_dict)
	if !exists('g:pop_list') || type(g:pop_list) != type({}) || has_key(a:change_dict, 'id')
		return
	endif

"	for l:p in g:pop_list
"		if l:p['name'] ==# a:name
"			for l:key in keys(a:dict)
"				if has_key(l:p, l:key)
"					let l:p[l:key] = a:dict[l:key]
"				endif
"			endfor
"
"			let l:tmp = {}
"			for l:key in keys(l:p)
"				if l:key ==# 'posy'
"					let l:tmp['line'] = l:p['posy']
"				elseif l:key ==# 'posx'
"					let l:tmp['col'] = l:p['posx']
"				elseif l:key ==# 'width'
"					let l:tmp['minwidth'] = l:p['width']
"				elseif l:key ==# 'height'
"					let l:tmp['minheight'] = l:p['height']
"				elseif l:key ==# 'border'
"					let l:tmp['border'] = l:p['border']
"				elseif l:key ==# 'zindex'
"					let l:tmp['zindex'] = l:p['zindex']
"				endif
"			endfor
"
"			call popup_setoptions(l:p['id'], l:tmp)
"
"			return
"		endif
"	endfor
endfunction


" for maintenance"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! PopList()
	if exists('g:pop_list') && type(g:pop_list) == type({})
		for l:name in keys(g:pop_list)
			echo g:pop_list[l:name]['id'] . ": " . l:name
		endfor
	endif
endfunction
