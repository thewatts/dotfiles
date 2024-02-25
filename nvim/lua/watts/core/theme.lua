local cmd = vim.cmd
local keymap = vim.keymap

-- Setting Terminal Capabilities for Italics
cmd("set t_ZH=\\e[3m")
cmd("set t_ZR=\\e[23m")

-- Setting Highlight for Comments
cmd("highlight Comment gui=italic")
cmd("highlight Comment cterm=italic")

-- Mapping for gathering Highlight Information
-- Press F3 to get the highlight information for the current cursor position
keymap.set("n", "<F3>", function()
  local line_nr = vim.fn.line(".")
  local col_nr = vim.fn.col(".")
  local syn_id = vim.fn.synID(line_nr, col_nr, true)
  local trans_id = vim.fn.synIDtrans(syn_id)
  local name = vim.fn.synIDattr(syn_id, "name")
  local trans_name = vim.fn.synIDattr(trans_id, "name")
  local fg = vim.fn.synIDattr(trans_id, "fg#")

  local info = string.format("hi<%s> trans<%s> lo<%s> FG:%s", name, trans_name, trans_name, fg)
  vim.api.nvim_echo({ { info } }, false, {})
end)

-- Initialize the global variable for the theme mode if it's not set
if vim.g.current_theme_mode == nil then
  vim.g.current_theme_mode = "dark"
end

-- Function to toggle between light and dark themes
local function toggle_theme()
  if vim.g.current_theme_mode == "dark" then
    -- Switch to light theme
    vim.cmd("colorscheme catppuccin-latte")
    vim.g.current_theme_mode = "light"
  else
    -- Switch to dark theme
    vim.cmd("colorscheme catppuccin-mocha")
    vim.g.current_theme_mode = "dark"
  end
end

-- Command to toggle the theme
vim.api.nvim_create_user_command("ToggleTheme", toggle_theme, {})
