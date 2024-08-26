" ファイルエクスプローラーを表示する関数
function! FileExplorer()
  " 新しいバッファを作成してファイルリストを表示
  enew
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  setlocal nonumber
  setlocal norelativenumber
  setlocal nospell
  setlocal nowrap

  " カレントディレクトリのファイルリストを取得して表示
  call setline(1, systemlist('ls -p'))

  " ファイルを選択するためのコマンドを作成
  nnoremap <buffer> <CR> :e %<CR>
  nnoremap <buffer> q :bd<CR>
endfunction

" コマンドを作成
command! Explore call FileExplorer()
