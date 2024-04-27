return {
  "rose-pine/neovim",
  lazy = false,       -- make sure we load this during startup if it is your main colorscheme
  name = "rose-pine", -- rename, otherwise this will show as `neovim` in Lazy's plugin list
  priority = 1000,    -- make sure to load this before all the other start plugins
  config = function()
    -- load the colorscheme here
    vim.cmd([[colorscheme rose-pine-main]])
    -- vim.cmd([[colorscheme rose-pine-dawn]])
  end,
}
