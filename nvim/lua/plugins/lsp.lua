return {
  {
    "williamboman/mason.nvim",
    config = function()
      -- I wouldn't think this is necessary, but it is,
      -- to ensure that the mason plugin is loaded
      -- before the mason-lspconfig plugin
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        "tsserver",
        "ruby_ls",
        "standardrb"
      },
    }
  },
  {
    "neovim/nvim-lspconfig",
    keys = {
      {
        "<Leader>k",
        "<cmd>lua vim.lsp.buf.hover()<CR>",
        desc = "LSP: Show information about the symbol under the cursor",
      },
      {
        "gd",
        "<cmd>lua vim.lsp.buf.definition()<CR>",
        desc = "LSP: Go to definition",
      },
      {
        "<Leader>ca",
        "<cmd>lua vim.lsp.buf.code_action()<CR>",
        desc = "LSP: Show code actions",
      },
    },
    config = function()
      local lspconfig = require("lspconfig")

      lspconfig.lua_ls.setup({})
      lspconfig.tsserver.setup({})
      lspconfig.standardrb.setup({})
      lspconfig.ruby_ls.setup({})
    end,
  },
}