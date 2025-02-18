-- Run your tests at the speed of thought
return {
  "janko/vim-test",
  dependencies = {
    "voldikss/vim-floaterm",
  },
  keys = {
    -- 🛠️ Test Execution Keymaps
    { "<leader>s", "<cmd>TestNearest<CR>", desc = "Run the nearest test" },
    { "<leader>t", "<cmd>TestFile<CR>",    desc = "Run the current test file" },
    { "<leader>a", "<cmd>TestSuite<CR>",   desc = "Run all tests in the suite" },
    { "<leader>g", "<cmd>TestVisit<CR>",   desc = "Go to the last test file" },
    { "<CR>",      "<cmd>TestLast<CR>",    desc = "Re-run the last test" },
  },
  config = function()
    -- 📌 Test Runner Settings
    vim.g["test#ruby#use_spring_binstub"] = 1 -- Use Spring for faster test runs
    vim.g["test#preserve_screen"] = 1         -- Prevent screen clearing after tests
    vim.g["test#strategy"] = "floaterm"       -- Use Floaterm for test execution

    -- 🖥️ Floaterm Configuration
    vim.g["floaterm_position"] = "topright"
    vim.g["floaterm_height"] = 0.97
    vim.g["floaterm_width"] = 0.5

    -- 🎨 Theme Colors (from your custom theme)
    local colors = {
      bg = "#141D22",
      fg = "#A5FBFF",
      gray = "#3a4c4e",
      dark_gray = "#1e2628",
      light_gray = "#91b0b1",
      red = "#dd513c",
      green = "#3df2ad",
      blue = "#34A2DF",
      cyan = "#4DDCFF",
      light_blue = "#A5FBFF",
      dark_blue = "#3f9bbc",
      orange = "#ffb78a",
      pink = "#eb78c3",
      warning = "#FFFF84",
      border = "#154547",
    }

    -- 🎨 Default Floaterm Border Color
    vim.api.nvim_set_hl(0, "FloatermBorder", { fg = colors.dark_gray, bg = colors.bg })

    -- 🔄 Floaterm Border Color Cycling
    local border_colors = {
      colors.dark_gray,  -- Subtle
      colors.gray,       -- Slight contrast
      colors.border,     -- Defined theme border color
      colors.cyan,       -- Accent
      colors.light_blue, -- Brighter accent
      colors.red,        -- Strong contrast
      colors.orange,     -- Warm alternative
    }

    local index = 1
    vim.keymap.set("n", "<leader>bc", function()
      vim.api.nvim_set_hl(0, "FloatermBorder", { fg = border_colors[index], bg = colors.bg })
      print("Floaterm Border Color: " .. border_colors[index])
      index = (index % #border_colors) + 1
    end, { noremap = true, silent = true })

    -- 🔀 Seamless Floaterm Navigation

    -- Function to check if Floaterm is open
    local function is_floaterm_open()
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local bufname = vim.api.nvim_buf_get_name(buf)
        local filetype = vim.api.nvim_buf_get_option(buf, "filetype")

        if bufname:match("floaterm") or filetype == "floaterm" then
          return win
        end
      end
      return nil
    end

    -- Function to move to the left-most window
    local function move_to_leftmost_window()
      local cur_win = vim.api.nvim_get_current_win()
      local windows = vim.api.nvim_list_wins()
      local leftmost_win = cur_win

      for _, win in ipairs(windows) do
        local win_info = vim.fn.getwininfo(win)[1]
        if win_info and win_info.wincol < vim.fn.getwininfo(leftmost_win)[1].wincol then
          leftmost_win = win
        end
      end

      if leftmost_win ~= cur_win then
        vim.api.nvim_set_current_win(leftmost_win)
      end
    end

    -- Move **out** of Floaterm to the left-most split
    vim.keymap.set("t", "<C-h>", function()
      vim.cmd("stopinsert") -- Exit terminal mode

      move_to_leftmost_window()
    end, { noremap = true, silent = true })

    -- Move **into** Floaterm with <C-l> (only if it's open)
    vim.keymap.set("n", "<C-l>", function()
      local floaterm_win = is_floaterm_open()

      if floaterm_win then
        -- Switch to Floaterm and enter terminal mode
        vim.cmd("FloatermToggle")
      else
        -- If Floaterm is not open, fall back to Tmux navigation
        vim.cmd("TmuxNavigateRight")
      end
    end, { noremap = true, silent = true })

    vim.g.floaterm_is_full = false

    -- Create the toggle function
    local function toggle_floaterm_width()
      -- Toggle the state first
      vim.g.floaterm_is_full = not vim.g.floaterm_is_full

      if not vim.g.floaterm_is_full then
        -- Reset to original width
        vim.g.floaterm_width = 0.5
        vim.cmd('FloatermUpdate --width=0.5')
      else
        -- Set to full width
        vim.g.floaterm_width = 0.99
        vim.cmd('FloatermUpdate --width=0.99')
      end
    end

    vim.keymap.set("t", "<C-f>", function()
      toggle_floaterm_width()
    end, { noremap = true, silent = true })
  end,
}
