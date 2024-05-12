-- inval treesitter
vim.treesitter.start = (function(wrapped)
   return function(bufnr, lang)
      lang = lang or vim.fn.getbufvar(bufnr or '', '&filetype')
      pcall(wrapped, bufnr, lang)
   end
end)(vim.treesitter.start)
