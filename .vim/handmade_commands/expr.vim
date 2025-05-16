function! s:ExpGenContent()
	" scan current directory
	let l:list = filter(glob(".",0,1), "v:val !=# '.' && v:val !=# '..' && v:val !~ '\\.swp$'") + glob("*",0,1)

	" get index of openning file
	if !exists('s:exp_pos')
		for l:i in range(len(l:list))
			if l:list[l:i] ==# expand('%:t')
				let s:exp_pos = l:i
				break
			endif
		endfor
	endif

	" check index number
	if 0 > s:exp_pos
		let s:exp_pos = 0
	elseif len(l:list) <= s:exp_pos
		let s:exp_pos = len(l:list) - 1
	endif

	" add cursor
	for l:i in range(len(l:list))
		if l:i == s:exp_pos
			let l:list[l:i] = "> " . l:list[l:i]
		else
			let l:list[l:i] = "  " . l:list[l:i]
		endif
	endfor

	return l:list
endfunction

function! ExpOpen()
	if !exists('g:pop_exp_per')
		let g:pop_exp_per = 20
	endif

	call PopCreate("exp", s:ExpGenContent(), float2nr(&columns*(1.0-(g:pop_exp_per)/100.0)+1.0), 1, float2nr(&columns*(g:pop_exp_per/100.0)+1.0), &lines-1, [0,0,0,1], v:false)

	call SetKeybind("LAZY")
	call SetKeybind("exp")
endfunction

function! ExpClose()
	call PopDelete("exp")

	call SetKeybind("normal")
endfunction

function! ExpChangeSize(delta)
	if 0 >= g:pop_exp_per + a:delta
		return
	elseif 100 <= g:pop_exp_per + a:delta
		let g:pop_exp_per = 100
	else
		let g:pop_exp_per = g:pop_exp_per + a:delta
	endif

	call PopOption("exp",{'posx': float2nr(&columns*(1.0-(g:pop_exp_per)/100.0)+1.0), 'width': float2nr(&columns*(g:pop_exp_per/100.0)+1.0)})
endfunction

function! ExpMoveCursor(delta)
	if !exists('s:exp_pos') || !PopExists("exp")
		return
	endif

	let s:exp_pos = s:exp_pos + a:delta

	call PopOption("exp",{'content': s:ExpGenContent()})
endfunction
