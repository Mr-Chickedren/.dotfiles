local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local neovim_plugins = {
   --'hoge',                  => don't write config file
   --require("plugins.hoge"), => write config file (./plugins/hoge.lua)
   require("plugins.nvim-web-devicons"),
   require("plugins.nvim-tree"),
   require("plugins.markdown-preview"),
   require("plugins.toggleterm"),
}

require('lazy').setup(neovim_plugins)
