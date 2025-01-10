" color
source ~/.vim/colors.vim

" handmade commands
source ~/.vim/handmade_commands/keybind.vim
source ~/.vim/handmade_commands/popup_manager.vim
source ~/.vim/handmade_commands/explopup.vim
"source ~/.vim/handmade_commands/test.vim

"indent setting
autocmd FileType rust,vim set smartindent
autocmd FileType rust,vim set autoindent

" editor visual
set number
set fillchars+=eob:\ 
set fillchars+=vert:┃
set fillchars+=stl:─,stlnc:─
set noruler
set tabstop=3
set softtabstop=3
set shiftwidth=3
"set expandtab

" search
set hlsearch
set incsearch

" cursor type
set timeoutlen=500
set ttimeoutlen=10
let &t_SI = "\e[5 q"
let &t_EI = "\e[0 q"

" clipboard
set clipboard=unnamedplus

" key map (-> ~/.vim/handmade_commands/keybind.vim)
:call SetKeybind("normal")





""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! MCF(findstart, base)
	if a:findstart
		let line = getline('.')
		let start = col('.') - 1
		while start > 0 && (line[start-1] =~ '!' || line[start - 1] =~ '\k')
			let start -= 1
		endwhile
		return start
	else
		if a:base == '!'
			return [{'word': 'html', 'abbr': 'cheet1\naaa'}, {'word': 'a', 'abbr': 'b'}]
		else
			return filter(['apple', 'banana', 'cherry'], 'v:val =~ "^" . a:base')
		endif
	endif
endfunction

set completefunc=MCF

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"todo
"split W ( ) , ignore " // # /**/

function! GetWordsWithSymbols()
    let text = join(getbufline('%', 1, '$'))
    let pattern = '\w\+\|[,()]'
    let matches = []
    let start = 0

    while start < len(text)
        " 現在の位置からマッチを探す
        let match = matchstr(text[start:], pattern)
        if match == ''
            break
        endif
        " マッチをリストに追加
        call add(matches, match)
        " マッチ部分の次の位置から再検索
        let start += stridx(text[start:], match) + len(match)
    endwhile

    " 重複を除去して返す
	 return matches
    "return uniq(sort(matches))
endfunction

function! RemoveFromQuoteToEndSimple()
    let lines = getbufline('%', 1, '$')
    let result = []
    for line in lines
        let idx = matchend(line, '"')
        if idx > 0
            call add(result, strpart(line, 0, idx - 1))
        else
            call add(result, line)
        endif
    endfor
    return result
endfunction

"echo split(join(getbufline('%', 1, '$')), '\W\+')
"echo matchlist(join(getbufline('%', 1, '$')), 'source\s\+\zs\S*')
"(abc, cde)
