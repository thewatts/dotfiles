return {
  -- Find, Filter, Preview, Pick. All lua, all the time.
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<C-p>",
        function()
          local builtin = require("telescope.builtin")
          builtin.find_files()
        end,
        desc = "Fuzzy find files by name in the current directory"
      },
      {
        "<Leader>F",
        function()
          local builtin = require("telescope.builtin")
          builtin.live_grep()
        end,
        desc = "Find search-term within files in the current directory"
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
            "vendor",
            "import_data_samples",
            "tmp",
            "legacy_invoices",
            "tasting_notes",
            "%.csv",
            "public/assets",
            "public/downloads",
            "log",
          },
        },
      })

      -- To get ui-select loaded and working with telescope, you need to call
      -- load_extension, somewhere after setup function:
      telescope.load_extension("ui-select")
      telescope.load_extension("fzf")
    end,
  },
  {
    -- a faster, native, implementation of FZF
    "nvim-telescope/telescope-fzf-native.nvim",
    build =
    "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
  },
}
