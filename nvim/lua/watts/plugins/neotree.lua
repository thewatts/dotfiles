-- Neovim plugin to manage the file system and other tree like structures.
return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",       -- 3rd party "standard library" functions
    "nvim-tree/nvim-web-devicons", -- for fancy icons :)
    "MunifTanjim/nui.nvim",        -- ui component library for neovim
    "s1n7ax/nvim-window-picker",   -- This plugins prompts the user to pick a window and returns the window id of the picked window
  },
  keys = {
    {
      "<C-b>",
      "<cmd>Neotree filesystem toggle left<CR>",
      desc = "Toggle the filesystem tree on the left"
    },
    {
      "<Leader>f",
      "<cmd>Neotree reveal<CR>",
      desc = "Reveal the current file in the filesystem tree"
    },
  },
  config = function()
    vim.g.neotree_close_on_file_open = true

    -- Command to toggle auto-close behavior
    vim.api.nvim_create_user_command("ToggleNeoTreeAutoClose", function()
      vim.g.neotree_close_on_file_open = not vim.g.neotree_close_on_file_open

      if vim.g.neotree_close_on_file_open then
        print("NeoTree Auto-Close: ON")
      else
        print("NeoTree Auto-Close: OFF")
      end
    end, { desc = "Toggle NeoTree auto-close on file open" })

    require("neo-tree").setup({
      filesystem = {
        window = {
          mappings = {
            -- disable fuzzy finder
            -- https://github.com/nvim-neo-tree/neo-tree.nvim/issues/791
            ["/"] = "noop",
            ["<C-b>"] = { "filesystem toggle left" },
            ["<C-n>"] = { "scroll_preview", config = { direction = -10 } },
            ["<C-p>"] = { "scroll_preview", config = { direction = 10 } },
          },
        },
      },
      event_handlers = {
        {
          -- Auto close NeoTree when selecting (opening) a file
          event = "file_opened",
          handler = function() -- file_path is the argument
            if vim.g.neotree_close_on_file_open then
              require("neo-tree").close_all()
            end
          end,
        },
      },
    })
  end,
}
