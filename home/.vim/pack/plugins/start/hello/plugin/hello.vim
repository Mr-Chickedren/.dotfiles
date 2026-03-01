if exists("g:loaded_hello")
  finish
endif
let g:loaded_hello = 1

nnoremap <silent> <Plug>(hello-echo_hello) :call hello#echo_hello()<CR>
