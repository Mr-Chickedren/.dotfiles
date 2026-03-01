function! explopup#handler() abort
	if !exists('s:pid')
		let s:icon_dir = ' '
		let s:icon_file = ' '
		let s:icon_exe = ' '
		let s:icon_link = '󰌷 '
		let s:icon_socket = '󱄉 '
		let s:icon_fifo = '󰟥 '
		let s:icon_cursor = ' '

		let cd = getcwd()
		let od = expand('%:p:h')
		let s:wd = (len(cd) < len(od)) ? cd : od

		let list = List(s:wd)
		let s:cursor_pos = 0
		let s:cursor_top = 0
		let s:cursor_end = len(list) - 1
		let s:cursor_depth = 0

		let list = [' aaa', ' bbb', '   ccc', '   ddd', ' eee']
		let s:cursor_end = len(list) - 1
		let s:cursor_pos = 1
		let s:cursor_depth = 1

		for i in range(len(list))
			let list[i] = (s:cursor_pos == i) ? s:icon_cursor . list[i] : repeat(' ', strwidth(s:icon_cursor)) . list[i]
		endfor


		let s:pid = popup_create(list,{
		\	'filter': function('Filter'),
		\	'mapping': 0,
		\})
	else
		call popup_show(s:pid)
	endif

endfunction

function! Filter(id, key) abort
	if a:key ==# 'q'
		call popup_hide(a:id)
		return 1
		
	elseif a:key ==# 'j'
		call Move(1)
		return 1

	elseif a:key ==# 'k'
		call Move(-1)
		return 1

	elseif a:key ==# "\<Space>"
		let buf = winbufnr(s:pid)
		if strcharpart(getbufline(buf, s:cursor_pos + 1)[0], (s:cursor_depth + 1) * strwidth(s:icon_cursor), 1) == strcharpart(s:icon_dir , 0, 1)
			echo 'dir'
			call Deply()
		else
			echo 'open'
		endif
		return 1

	endif

	return 1
endfunction

function! Move(delta) abort
	let buf = winbufnr(s:pid)
	let spaces_now = s:cursor_depth * strwidth(s:icon_cursor)

	let i = s:cursor_pos
	while s:cursor_top <= i+a:delta && i+a:delta <= s:cursor_end
		let i = i + a:delta
		let spaces_ptr = match(getbufline(buf, i+1)[0], '\S') - strwidth(s:icon_cursor)

		if spaces_ptr < spaces_now
			break
		elseif spaces_ptr > spaces_now
			continue
		else
			call setbufline(buf, s:cursor_pos+1, substitute(getbufline(buf, s:cursor_pos+1)[0], s:icon_cursor, repeat(' ', strwidth(s:icon_cursor)), 'g'))
			call setbufline(buf, i+1, repeat(' ', spaces_now) . s:icon_cursor . getbufline(buf, i+1)[0][(spaces_now + strwidth(s:icon_cursor)):])
			let s:cursor_pos = i
			break
		endif
	endwhile

endfunction

function! List(path) abort
	let list = filter(systemlist(
	\	'ls -aF ' . shellescape(a:path) . ' | grep /$; ' . 
	\	'ls -aF ' . shellescape(a:path) . ' | grep -v "[*/]$";' .
	\	'ls -aF ' . shellescape(a:path) . ' | grep *$'
	\),
	\	'!(v:val ==# "./" || v:val ==# "../" || v:val =~# "\\.swp$")'
	\)

	for i in range(len(list))
		if list[i][len(list[i])-1] == '/'
			let list[i] = s:icon_dir . list[i][:len(list[i])-2]
		elseif list[i][len(list[i])-1] == '*'
			let list[i] = s:icon_exe . list[i][:len(list[i])-2]
		elseif list[i][len(list[i])-1] == '@'
			let list[i] = s:icon_link . list[i][:len(list[i])-2]
		elseif list[i][len(list[i])-1] == '='
			let list[i] = s:icon_socket . list[i][:len(list[i])-2]
		elseif list[i][len(list[i])-1] == '|'
			let list[i] = s:icon_fifo . list[i][:len(list[i])-2]
		else
			let list[i] = s:icon_file . list[i]
		endif
	endfor

	return list
endfunction

function! Deply()
endfunction


"call setbufline(s:buf, 2, 'second line')
"echo getbufline(s:buf, i+1)[0]
"let s = 'banana'
"echo 'B' . s[1:]
"let s:buf = winbufnr(s:pid)
"let s:wd = getcwd()
"let cf = expand('%:p')
"let cd = expand('%:p:h')
"let addlist[ai] = repeat(' ', (i+1)*s:tab) . addlist[ai]
"let spaces = match(line, '\S')
"echo (strcharpart(a, 0, 1) == strcharpart(' ', 0, 1)) ? 'same':'not'
"echo strwidth(' ')
"ls -aF || directory / | exe * | link @ | socket = | FIFO | |
"let s:wd = fnamemodify(s:wd, ':h')
