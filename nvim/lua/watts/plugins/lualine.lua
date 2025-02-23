return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup({
      options = {
        theme = require('nostromo').lualine,
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = {
          {
            'branch',
            fmt = function(str)
              local max_width = math.floor(vim.o.columns * 0.08) -- 8% of window width

              if #str > max_width then
                return '…' .. str:sub(-max_width + 1) -- Show last part of branch name with an ellipsis
              end

              return str
            end
          }
        },
        lualine_c = { { 'filename', path = 1 } }, -- Show relative path (use path = 2 for absolute)
        lualine_x = { 'filetype' },               -- OS display is now removed
        lualine_y = {},                           -- Removed progress %
        lualine_z = { 'location' }
      }
    })
  end
}
