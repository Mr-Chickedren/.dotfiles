-- encoding
vim.opt.encoding = "utf-8"
vim.scriptencoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- visual
vim.opt.number = true
vim.opt.display:append{"lastline"}
vim.opt.visualbell = true
vim.opt.showtabline = 2
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 3
vim.opt.shiftwidth = 3
vim.opt.softtabstop = 3
vim.opt.fillchars:append({eob = ' '})
vim.opt.ambiwidth = "single"
vim.opt.laststatus = 0
vim.opt.wrap = false
vim.opt.ruler = false

vim.cmd('colorscheme myscheme')

--- (maximum number of completion candidates)
vim.opt.pumheight = 10

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- keymap
vim.g.mapleader = " "
vim.keymap.set('i','<C-k>','<Up>')
vim.keymap.set('i','<C-j>','<Down>')
vim.keymap.set('i','<C-h>','<left>')
vim.keymap.set('i','<C-l>','<right>')
vim.keymap.set('n',';',':')

vim.keymap.set('n','<Leader><tab>',':NvimTreeToggle<CR>')


-- setup plugin-manager (lazy.nvim)
require("plugin")

-- inval explorer
vim.api.nvim_set_var('loaded_netrw', 1)
vim.api.nvim_set_var('loaded_netrwPlugin', 1)

-- true color setting
--vim.opt.termguicolors = true


-- treesitter bug repair
vim.treesitter.start = (function(wrapped)
   return function(bufnr, lang)
      lang = lang or vim.fn.getbufvar(bufnr or '', '&filetype')
      pcall(wrapped, bufnr, lang)
   end
end)(vim.treesitter.start)
