-- Nvim Treesitter — `main` branch.
-- The classic `master` branch is archived and does NOT support Neovim 0.12+,
-- which caused the treesitter highlighter decoration-provider crashes. The
-- `main` branch is the only version supported on 0.12 and uses a new API:
-- parsers are installed via `install()` and highlighting/indent are enabled
-- per-buffer via `vim.treesitter.start()` rather than a `configs.setup{}` block.
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false, -- the main branch does not support lazy-loading
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")

      ts.setup()

      -- Register custom parsers. `install()`/`get_available()`/`:TSUpdate` all
      -- re-require the parsers table fresh and then fire `User TSUpdate`, so this
      -- is the supported hook for re-adding parsers not shipped with the plugin.
      vim.api.nvim_create_autocmd("User", {
        pattern = "TSUpdate",
        callback = function()
          require("nvim-treesitter.parsers").haml = {
            install_info = {
              url = "https://github.com/vitallium/tree-sitter-haml",
              branch = "main",
            },
          }
        end,
      })

      -- Parsers to keep installed (async; a no-op if already present).
      ts.install({
        "bash", "css", "diff", "embedded_template", "gitcommit", "gitignore",
        "haml", "html", "javascript", "json", "lua", "markdown",
        "markdown_inline", "ruby", "sql", "tsx", "typescript", "yaml",
      })

      -- Enable highlighting + treesitter indentation per buffer, auto-installing
      -- the parser on demand for any other filetype (replaces classic
      -- `auto_install`/`highlight`/`indent` modules).
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local buf = args.buf
          local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
          if not lang then
            return
          end

          -- Languages whose treesitter indent queries are worse than Vim's
          -- built-in indentexpr. Ruby's mis-indent multi-line keyword args and
          -- `case`/`when` bodies; `GetRubyIndent()` gets them right.
          local keep_builtin_indent = { ruby = true }

          local function enable()
            if not pcall(vim.treesitter.start, buf, lang) then
              return
            end

            if not keep_builtin_indent[lang] then
              vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
              return
            end

            -- Vim's indent/ruby.vim decides "am I inside a string or comment?"
            -- by checking `synID() == hlID('rubyString')` and friends. With
            -- treesitter the regex syntax file is never loaded, so those
            -- groups don't exist, both sides are 0, every position looks like
            -- a string, and every new line gets indent -1 (i.e. none). Load
            -- the syntax file once so the highlight groups exist (they are
            -- global), then drop the regex items again so treesitter stays
            -- the only highlighter.
            if vim.fn.hlID(lang .. "String") == 0 then
              vim.api.nvim_buf_call(buf, function()
                vim.cmd("runtime! syntax/" .. lang .. ".vim")
                vim.cmd("syntax clear")
              end)
            end
          end

          if vim.list_contains(ts.get_installed(), lang) then
            enable()
          elseif vim.list_contains(ts.get_available(), lang) then
            -- Install asynchronously, then enable without blocking the UI.
            ts.install(lang):await(function(err)
              if not err then
                vim.schedule(enable)
              end
            end)
          end
        end,
      })
    end,
  },
  -- Show code context, re: Treesitter (uses `vim.treesitter` directly, so it is
  -- compatible with the main branch).
  -- {
  --   "nvim-treesitter/nvim-treesitter-context",
  -- },
}
