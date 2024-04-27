-- 🍨 Soothing pastel theme for (Neo)vim
-- the colorscheme should be available when starting Neovim
return {
  "catppuccin/nvim",
  lazy = false,        -- make sure we load this during startup if it is your main colorscheme
  name = "catppuccin", -- rename, otherwise this will show as `nvim` in Lazy's plugin list
  priority = 1000,     -- make sure to load this before all the other start plugins
  config = function()
    -- load the colorscheme here
    -- vim.cmd([[colorscheme catppuccin-mocha]])
  end,
}
