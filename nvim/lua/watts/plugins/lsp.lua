return {
  -- Portable package manager for Neovim that runs everywhere Neovim runs. Easily install and manage LSP servers, DAP servers, linters, and formatters.
  {
    "williamboman/mason.nvim",
    config = function()
      -- I wouldn't think this is necessary, but it is,
      -- to ensure that the mason plugin is loaded
      -- before the mason-lspconfig plugin
      require("mason").setup()
    end,
  },
  -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        -- "tsserver",
        -- "ruby_ls", -- removing for now, as it requires some setup to work with standardrb
        -- "standardrb"
      }
    },
  },
  -- Quickstart configs for Nvim LSP
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

      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })
      lspconfig.tsserver.setup({})
      -- lspconfig.standardrb.setup({})
      lspconfig.ruby_ls.setup({}) -- see above
      -- lspconfig.stimulus_ls.setup({}) -- not sure how to use this yet 😅
      lspconfig.eslint.setup({
        on_attach = function(_, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end,
      })
    end,
  },
}
