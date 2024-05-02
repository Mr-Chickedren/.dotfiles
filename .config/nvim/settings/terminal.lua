local win = nil

function open_float_win()
   local buf = vim.api.nvim_create_buf(false, true)

   local opts = {
      relative = 'editor',
      width = 40,
      height = 10,
      row = 10,
      col = 10,
      anchor = 'NW',
      style = 'minimal',
      focusable = false,
      border = 'single',
   }

   win = vim.api.nvim_open_win(buf, true, opts)

   vim.api.nvim_command('terminal')
   vim.api.nvim_command('startinsert')
end
