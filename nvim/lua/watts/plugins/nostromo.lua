return {
  -- dir = "~/code/nostromo.nvim",
  "thewatts/nostromo.nvim",
  version = "0.0.8",
  lazy = false,
  priority = 1000,
  config = function()
    require("nostromo").setup({
      visible_borders = false,
    })

    if vim.g.current_theme_mode == "dark" then
      vim.cmd("colorscheme nostromo")
    end
  end,
}
