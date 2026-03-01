if exists("g:loaded_explopup")
  finish
endif
let g:loaded_explopup = 1

nnoremap <silent> <Plug>(explopup-handler) :call explopup#handler()<CR><Ignore>
