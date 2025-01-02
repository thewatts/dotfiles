return {
  -- dir = "~/code/nostromo",
  "thewatts/nostromo.nvim",
  version = "0.0.8",
  lazy = false,
  priority = 1000,
  config = function()
    require("nostromo").setup({
      visible_borders = false,
    })
  end,
}
