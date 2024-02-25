local keymap = vim.keymap

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim", "folke/noice.nvim" },
  config = function()
    local harpoon = require("harpoon")
    local noice = require("noice")

    -- REQUIRED
    harpoon.setup()
    -- REQUIRED

    keymap.set("n", "<Leader>`", function()
      harpoon:list():append()
      noice.notify("Added current file to harpoon")
    end, { desc = "Add current file to harpoon" })

    keymap.set("n", "<Leader>~", function()
      harpoon:list():remove()
      noice.notify("Removed current file from harpoon")
    end, { desc = "Remove current file from harpoon" })

    keymap.set("n", "<Leader>1", function()
      harpoon:list():select(1)
    end, { desc = "Navigate to harpoon file 1" })

    keymap.set("n", "<Leader>2", function()
      harpoon:list():select(2)
    end, { desc = "Navigate to harpoon file 2" })

    keymap.set("n", "<Leader>3", function()
      harpoon:list():select(3)
    end, { desc = "Navigate to harpoon file 3" })

    keymap.set("n", "<Leader>4", function()
      harpoon:list():select(4)
    end, { desc = "Navigate to harpoon file 4" })

    -- Telescope configuration
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local config = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}

      for _, file in ipairs(harpoon_files.items) do
        table.insert(file_paths, file.value)
      end

      pickers.new({}, {
        prompt_title = "Harpoon",
        finder = finders.new_table({
          results = file_paths
        }),
        previewer = config.file_previewer({}),
        sorter = config.generic_sorter({}),
      }):find()
    end

    keymap.set("n", "<C-e>", function()
      toggle_telescope(harpoon:list())
    end, { desc = "Open harpoon window" })
  end
}
