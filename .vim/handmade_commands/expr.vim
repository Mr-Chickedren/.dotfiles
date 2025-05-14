function! ExpOpen()
	if !exists('g:pop_exp_per')
		let g:pop_exp_per = 20
	endif

	let l:list = filter(glob(".",0,1), "v:val !=# '.' && v:val !=# '..' && v:val !~ '\\.swp$'") + glob("*",0,1)

	call PopCreate("exp", l:list, float2nr(&columns*(1.0-(g:pop_exp_per)/100.0)+1.0), 1, float2nr(&columns*(g:pop_exp_per/100.0)+1.0), &lines-1, [0,0,0,1], 50)

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
