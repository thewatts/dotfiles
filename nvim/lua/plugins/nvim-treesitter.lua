-- Nvim Treesitter configurations and abstraction layer
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local config = require("nvim-treesitter.configs")
      config.setup({
        auto_install = true,
        sync_install = false,
        highlight = {
          enable = true,
          -- https://github.com/nvim-treesitter/nvim-treesitter/issues/6187
          additional_vim_regex_highlighting = true,
        },
        indent = { enable = true },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
  },
}
