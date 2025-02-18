return {
  "lukas-reineke/virt-column.nvim",
  config = function()
    require("virt-column").setup {
      char = "│", -- You can change this to '|', '·', etc.
      highlight = "ThemeColumn",
    }

    -- vim.api.nvim_set_hl(0, "VirtColumn", { fg = "#1e2628", bg = "NONE" })
  end
}
