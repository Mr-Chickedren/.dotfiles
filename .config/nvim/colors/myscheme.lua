vim.g.colors_name = "myscheme"
vim.cmd.highlight("clear")

vim.api.nvim_set_hl(0,"Comment", {ctermfg=244})    --//
vim.api.nvim_set_hl(0,"Number", {ctermfg=152})     --123
vim.api.nvim_set_hl(0,"String", {ctermfg=3})       --"string"
vim.api.nvim_set_hl(0,"Search", {ctermbg=242})
vim.api.nvim_set_hl(0,"LineNr", {ctermfg=242})
vim.api.nvim_set_hl(0,"Normal", {ctermbg=0})       --background
vim.api.nvim_set_hl(0,"Operator", {ctermfg=252})   --=
vim.api.nvim_set_hl(0,"Type", {ctermfg=252})       --{}
vim.api.nvim_set_hl(0,"Pmenu", {ctermfg=8})
vim.api.nvim_set_hl(0,"PmenuSel", {ctermfg=3})
vim.api.nvim_set_hl(0,"Statement", {ctermfg=13})
vim.api.nvim_set_hl(0,"ErrorMsg", {ctermfg=1})

