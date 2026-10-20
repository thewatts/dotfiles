-- LSP setup for Neovim 0.11+.
--
-- The old `require("lspconfig").<server>.setup{}` framework is gone (nvim-lspconfig
-- v3.0.0). nvim-lspconfig is now just a bundle of `lsp/<server>.lua` config files
-- that Neovim picks up off the runtimepath; we tweak them with `vim.lsp.config()`
-- and turn them on with `vim.lsp.enable()`.
return {
  -- Portable package manager for Neovim that runs everywhere Neovim runs. Easily install and manage LSP servers, DAP servers, linters, and formatters.
  {
    "mason-org/mason.nvim",
    opts = {},
  },
  -- Quickstart configs for Nvim LSP.
  --
  -- Loaded eagerly: it has to be on the runtimepath before any buffer opens,
  -- otherwise `vim.lsp.enable()` has no config to resolve. Lazy-loading this on
  -- `keys` means nothing ever attaches until you hit a mapping, and that first
  -- press always fails with "not supported by any server activated for buffer".
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      -- Run ruby-lsp out of the project's bundle. Mirrors the upstream config's
      -- cmd function so the server is spawned from the project root.
      vim.lsp.config("ruby_lsp", {
        cmd = function(dispatchers, config)
          return vim.lsp.rpc.start(
            { "bundle", "exec", "ruby-lsp" },
            dispatchers,
            config and config.root_dir and { cwd = config.cmd_cwd or config.root_dir }
          )
        end,
        -- ruby-lsp's semantic tokens land at a higher priority than treesitter
        -- and repaint the buffer once indexing finishes (e.g. `self` drops from
        -- @variable.builtin to a plain @variable), so colours shift a few
        -- seconds after opening a file. Treesitter alone is more accurate here.
        on_attach = function(client)
          vim.lsp.semantic_tokens.enable(false, { client_id = client.id })
        end,
      })

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })

      local ts_inlay_hints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      }

      vim.lsp.config("ts_ls", {
        settings = {
          typescript = { inlayHints = ts_inlay_hints },
          javascript = { inlayHints = ts_inlay_hints },
        },
      })

      vim.lsp.config("eslint", {
        on_attach = function(_, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end,
      })

      -- ruby-lsp comes from the project's Gemfile, not Mason, so enable it here.
      -- The Mason-managed servers are enabled by mason-lspconfig.
      vim.lsp.enable("ruby_lsp")

      -- Buffer-local mappings, bound only once a server is actually attached.
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local function map(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { buffer = args.buf, silent = true, desc = desc })
          end

          map("<Leader>k", vim.lsp.buf.hover, "LSP: Show information about the symbol under the cursor")
          map("gd", vim.lsp.buf.definition, "LSP: Go to definition")
          map("<Leader>ca", vim.lsp.buf.code_action, "LSP: Show code actions")
        end,
      })
    end,
  },
  -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim.
  -- As of v2 it calls `vim.lsp.enable()` for every installed server on our behalf.
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
    opts = {
      ensure_installed = {
        "lua_ls",
        "ts_ls",
        "eslint",
      },
    },
  },
}
