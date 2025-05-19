function! ExpOpen()
	call SetKeybind("LAZY")
	call SetKeybind("exp")

	" if there exists exp popup, reveal popup and finish this funciton
	if PopExists("exp")
		call PopReveal("exp")
		return
	endif

	" scan current directory
	let l:list = filter(glob(".*",0,1), "v:val !=# '.' && v:val !=# '..' && v:val !~ '\\.swp$'") + glob("*",0,1)

	" get index of openning file
	for l:i in range(len(l:list))
		if l:list[l:i] ==# expand('%:t')
			let l:cursor_pos = l:i
			break
		endif
	endfor

	" add cursor
	for l:i in range(len(l:list))
		if l:i == l:cursor_pos
			let l:list[l:i] = "> " . l:list[l:i]
		else
			let l:list[l:i] = "  " . l:list[l:i]
		endif
	endfor

	let l:exinfo = {"screen_per": 20, "cursor_pos": l:cursor_pos, "list": l:list}

	call PopCreate("exp", l:list, float2nr(&columns*(1.0-(l:exinfo["screen_per"])/100.0)+1.0), 1, float2nr(&columns*(l:exinfo["screen_per"]/100.0)+1.0), &lines-1, [0,0,0,1], v:false, l:exinfo)
endfunction

function! ExpClose()
	call PopHide("exp")
	call SetKeybind("normal")
endfunction

function! ExpChangeSize(delta)
	if !PopExists("exp")
		return
	endif

	let l:exinfo = PopPutExinfo("exp")
	if !has_key(l:exinfo, "screen_per")
		return
	endif

	let l:per = l:exinfo["screen_per"]
	if 0 >= l:per + a:delta
		return
	elseif 100 <= l:per + a:delta
		let l:per = 100
	else
		let l:per = l:per + a:delta
	endif

	call PopOption("exp",{'posx': float2nr(&columns*(1.0-(l:per/100.0))+1.0), 'width': float2nr(&columns*(l:per/100.0)+1.0)}, {"screen_per": l:per})
endfunction

function! ExpMoveCursor(delta)
	if !PopExists("exp")
		return
	endif

	let l:exinfo = PopPutExinfo("exp")
	if !has_key(l:exinfo, "cursor_pos") || !has_key(l:exinfo, "list")
		return
	endif

	let l:content = l:exinfo["list"]
	if 0 > l:exinfo["cursor_pos"] + a:delta || len(l:content) <= l:exinfo["cursor_pos"] + a:delta
		return
	endif

	let l:content[l:exinfo["cursor_pos"]] = "  " . strpart(l:content[l:exinfo["cursor_pos"]], 2)
	let l:content[l:exinfo["cursor_pos"] + a:delta] = "> " . strpart(l:content[l:exinfo["cursor_pos"] + a:delta], 2)

	call PopOption("exp", {'content': l:content}, {'list': l:content, 'cursor_pos': l:exinfo['cursor_pos'] + a:delta})
endfunction
