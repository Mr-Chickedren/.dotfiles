" enumerate file and directory list / process list in the path
function! EnumList()
  let list = systemlist('ls -ap ' . shellescape(b:path) . ' | xargs -n 1 echo')
  let b:list_length = len(list)
  let line_number = b:writing_list_start

  for i in range(1, b:writing_list_start - 1)
    call setline(i, '')
  endfor

  for tmp in list
    if line_number == b:writing_list_start
      call setline(line_number, '* ' . tmp)
    else
      call setline(line_number, '  ' . tmp)
    endif

    let line_number += 1
  endfor

  call cursor(b:writing_list_start, 1)

endfunction

" open selected file and enter selected directory
function! SelectedPathOpen()
  let list = systemlist('ls -ap ' . shellescape(b:path) . ' | xargs -n 1 echo')
  let current_path = get(b:, 'path', '')
  let updated_path = current_path . list[line('.') - b:writing_list_start]
  let b:path = updated_path

  if b:path =~ '/$'
    :silent %delete
    call EnumList()
  else
    let tmp = b:path
    bd
    execute 'e ' . fnameescape(tmp)
  endif
endfunction

" transfer cursor
function! CursorDown()
  let current_cursor = line('.')

  if current_cursor + 1 <= b:writing_list_start + b:list_length - 1
    call setline(current_cursor, substitute(getline('.'), '^..', '  ', ''))
    call cursor(current_cursor + 1, 1)
    call setline(current_cursor + 1, substitute(getline('.'), '^..', '* ', ''))
  endif

endfunction

function! CursorUp()
  let current_cursor = line('.')

  if current_cursor - 1 >= b:writing_list_start
    call setline(current_cursor, substitute(getline('.'), '^..', '  ', ''))
    call cursor(current_cursor - 1, 1)
    call setline(current_cursor - 1, substitute(getline('.'), '^..', '* ', ''))
  endif

endfunction


" main function
function! FileExplorer()
  :silent w
  let current_path = fnamemodify(expand('%:p'), ':h') . '/'

  " create new buffer
  enew
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  setlocal nonumber
  setlocal norelativenumber
  setlocal nospell
  setlocal nowrap

  let b:path = current_path
  let b:writing_list_start = 5
  let b:list_length = 0

  " modify cursor shape
  let &t_EI = "\e[4 q"
  call feedkeys("i", "n")
  call feedkeys("\<Esc>", "n")

  autocmd BufLeave * let &t_EI = "\e[0 q" | call feedkeys("i", "n") | call feedkeys("\<Esc>", "n")

  " display file list
  call EnumList()

  " key map in this buffer
  nnoremap <buffer> <Space> <Cmd>call SelectedPathOpen()<CR>
  nnoremap <buffer> q <Cmd>bd<CR>
  nnoremap <buffer> <Tab> <Cmd>bd<CR>
  nnoremap <buffer> j <Cmd>call CursorDown()<CR>
  nnoremap <buffer> k <Cmd>call CursorUp()<CR>
  nnoremap <buffer> h <Nop>
  nnoremap <buffer> l <Nop>
  nnoremap <buffer> i <Nop>
  nnoremap <buffer> I <Nop>
  nnoremap <buffer> a <Nop>
  nnoremap <buffer> A <Nop>
  nnoremap <buffer> o <Nop>
  nnoremap <buffer> O <Nop>
  nnoremap <buffer> ; <Nop>
  nnoremap <buffer> : <Nop>
  nnoremap <buffer> <CR> <Nop>
endfunction

" create command
command! Exp call FileExplorer()

" key map
nnoremap <Tab> <Cmd>Exp<CR>
