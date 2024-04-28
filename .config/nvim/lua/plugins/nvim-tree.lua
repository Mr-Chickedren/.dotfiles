return {
   'nvim-tree/nvim-tree.lua',
   config = function()
      require("nvim-tree").setup({
         view = {
            width = '25%',
            side = 'right',
            signcolumn = 'no',
            preserve_window_proportions = true
         },
      })
   end
}
