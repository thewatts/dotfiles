-- Nvim Treesitter configurations and abstraction layer
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local config = require("nvim-treesitter.configs")

      -- Register custom parsers
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.haml = {
        install_info = {
          url = "https://github.com/vitallium/tree-sitter-haml",
          files = { "src/parser.c", "src/scanner.c" },
          branch = "main",
        },
        filetype = "haml",
      }

      config.setup({
        auto_install = true,
        sync_install = false,

        highlight = {
          enable = true,
          -- https://github.com/nvim-treesitter/nvim-treesitter/issues/6187
          additional_vim_regex_highlighting = false, -- <<<- causes perf issues
        },

        indent = { enable = true },
      })
    end,
  },
  -- Show code context, re: Treesitter
  {
    "nvim-treesitter/nvim-treesitter-context",
  },
  {
    "tree-sitter/tree-sitter-embedded-template"
  }
}
