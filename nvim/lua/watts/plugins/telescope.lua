return {
  -- Find, Filter, Preview, Pick. All lua, all the time.
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim"
    },
    keys = {
      {
        "<C-p>",
        function()
          local builtin = require("telescope.builtin")
          builtin.find_files({ debounce = 100, hidden = true })
        end,
        desc = "Fuzzy find files by name in the current directory"
      },
      {
        -- Make sure to brew install ripgrep for this!
        "<Leader>F",
        function()
          local extension = require("telescope").extensions.live_grep_args
          extension.live_grep_args({ debounce = 200, hidden = true })
        end,
        desc = "Find search-term within files in the current directory"
      },
      {
        -- Make sure to brew install ripgrep for this!
        "<Leader>gb",
        function()
          local builtin = require("telescope.builtin")
          builtin.git_branches({
            debounce = 200,
            show_remote_tracking_branches = true,
            layout_config = {
              width = 0.97,      -- Keep full width
              height = 0.97,     -- Keep full height
              preview_width = 0, -- Make preview smaller for branch names
            }
          })
        end,
        desc = "Switch Git branches (including remote) using Telescope"
      },
      {
        -- Make sure to brew install ripgrep for this!
        "<Leader>gr",
        function()
          local builtin = require("telescope.builtin")
          builtin.lsp_references()
        end,
        desc = "Find references to LSP symbol using Telescope"
      },
      {
        -- Make sure to brew install ripgrep for this!
        "<Leader>sw",
        function()
          local builtin = require("telescope.builtin")
          builtin.grep_string({
            search = vim.fn.expand("<cword>"), -- search for exact word under cursor
            prompt_title = "Search Word",
          })
        end,
        desc = "Find references to LSP symbol using Telescope"
      },
    }
  },
  -- It sets vim.ui.select to telescope. That means for example that neovim core stuff can fill the telescope picker. Example would be lua vim.lsp.buf.code_action().
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          mappings = {
            i = {
              -- Note: C-q is the default keymap to send *all* results to the quickfix list
              ["<C-k>"] = actions.move_selection_previous,                       -- move to previous result, using C-k
              ["<C-j>"] = actions.move_selection_next,                           -- move to next result, using C-j
              ["<C-w>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected items to quick fix list & open it
            },
          },
          file_ignore_patterns = {
            "node_modules",
            "%.git",
            "import_data_samples",
            "tmp",
            "legacy_invoices",
            "tasting_notes",
            -- "%.csv",
            "public/assets",
            "public/downloads",
            "public/maintenance_files",
            "vendor/javascript",
            "vendor/assets",
            "test_results",
            "rdpscan",
            "coverage",
            "vendor/mitre",
            "%.log",
          },
          layout_config = {
            width = 0.97,         -- 95% of screen width
            height = 0.97,        -- 95% of screen height
            preview_width = 0.55, -- width of preview window (right side)
          },
        },
      })

      -- To get ui-select loaded and working with telescope, you need to call
      -- load_extension, somewhere after setup function:
      telescope.load_extension("ui-select")
      telescope.load_extension("fzf")
      telescope.load_extension("live_grep_args")
    end,
  },
  {
    -- a faster, native, implementation of FZF
    "nvim-telescope/telescope-fzf-native.nvim",
    build =
    "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
  },
}
