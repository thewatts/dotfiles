-- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function() -- Switch to config function for dynamic loading
    require('lualine').setup({
      options = {
        theme = require('nostromo').lualine
      }
    })
  end
}
