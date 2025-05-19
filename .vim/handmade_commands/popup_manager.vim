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
		for l:name in keys(g:pop_list)
			if !g:pop_list[l:name]['save']
				call remove(g:pop_list, l:name)
			endif
		endfor

		let json = json_encode(g:pop_list)
		call writefile(split(json, "\n"), s:remind_file)
	endif
endfunction


" public function""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" create popup window
function! PopCreate(name, content, posx, posy, width, height, border, save, exinfo)
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
			\ 'maxwidth': a:width,
			\ 'minwidth': a:width,
			\ 'maxheight': a:height,
			\ 'minheight': a:height,
			\ 'border': a:border,
			\ 'borderchars': ['─', '│', '─', '│', '┌', '┐', '┘', '└'],
			\ 'highlight': 'cleared',
			\ 'fixed': 1,
			\ 'zindex': 50,
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
		\ 'save': a:save,
		\ 'exinfo': a:exinfo,
		\ }

	let g:pop_list[a:name] = l:addpop
endfunction

" delete popup window
function! PopDelete(name)
	if exists('g:pop_list') && type(g:pop_list) == type({}) && has_key(g:pop_list, a:name)
		call popup_close(g:pop_list[a:name]['id'])
		call remove(g:pop_list, a:name)
	endif
endfunction

" change popup option
function! PopOption(name, change_dict, change_exinfo)
	if !exists('g:pop_list') || type(g:pop_list) != type({}) || has_key(a:change_dict, 'id') || !has_key(g:pop_list, a:name)
		return
	endif

	let l:org_dict = g:pop_list[a:name]

	for l:key in filter(keys(a:change_dict), 'v:val !=# "exinfo"')
		if has_key(g:pop_list[a:name], l:key)
			let g:pop_list[a:name][l:key] = a:change_dict[l:key]
		else
			let g:pop_list[a:name] = l:org_dict
			return
		endif
	endfor

	for l:key in keys(a:change_exinfo)
		let g:pop_list[a:name]['exinfo'][l:key] = a:change_exinfo[l:key]
	endfor

	let l:save_dict = g:pop_list[a:name]

	" rewrite window
	call PopDelete(a:name)
	call PopCreate(a:name, l:save_dict['content'], l:save_dict['posx'], l:save_dict['posy'], l:save_dict['width'], l:save_dict['height'], l:save_dict['border'], l:save_dict['save'], l:save_dict['exinfo'])
endfunction

" get popup exists
function! PopExists(name)
	if exists('g:pop_list') && has_key(g:pop_list, a:name)
		return v:true
	else
		return v:false
	endif
endfunction

" output exinfo
function! PopPutExinfo(name)
	if !exists('g:pop_list') || type(g:pop_list) != type({}) || !has_key(g:pop_list, a:name)
		return {}
	endif

	return g:pop_list[a:name]['exinfo']
endfunction

" hiden popup
function! PopHide(name)
	if exists('g:pop_list') && type(g:pop_list) == type({}) && has_key(g:pop_list, a:name)
		call popup_hide(g:pop_list[a:name]['id'])
	endif
endfunction

" reveal popup
function! PopReveal(name)
	if exists('g:pop_list') && type(g:pop_list) == type({}) && has_key(g:pop_list, a:name)
		call popup_show(g:pop_list[a:name]['id'])
	endif
endfunction


" for maintenance"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! PopList()
	if exists('g:pop_list') && type(g:pop_list) == type({})
		for l:name in keys(g:pop_list)
			echo g:pop_list[l:name]['id'] . ": " . l:name
		endfor
	endif
endfunction
