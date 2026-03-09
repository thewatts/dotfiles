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

-- Theme auto-switching based on macOS appearance
-- Dark: nostromo | Light: rose-pine-dawn
-- Matches ghostty config: theme = light:rose-pine-dawn,dark:nostromo

local themes = {
  dark = {
    colorscheme = "nostromo",
    cursor_color = "#ffb78a",
    column_color = "#1e2628",
  },
  light = {
    colorscheme = "rose-pine-dawn",
    cursor_color = "#575279",
    column_color = "#dfdad9",
  },
}

local function detect_appearance()
  local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
  local result = handle:read("*a")
  handle:close()
  return result:match("Dark") and "dark" or "light"
end

-- Detect appearance immediately (before lazy.nvim loads plugins) so
-- colorscheme plugins can read vim.g.current_theme_mode and set the
-- correct scheme on first load — no flash.
vim.g.current_theme_mode = detect_appearance()
vim.o.background = vim.g.current_theme_mode

-- Set indent guide colors after each colorscheme change
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function(args)
    for _, theme in pairs(themes) do
      if args.match == theme.colorscheme then
        vim.api.nvim_set_hl(0, "IblIndent", { fg = theme.column_color, nocombine = true })
        return
      end
    end
  end,
})

local function apply_theme(mode)
  if vim.g.current_theme_mode == mode then
    return
  end

  vim.g.current_theme_mode = mode
  local theme = themes[mode]

  vim.o.background = mode
  vim.cmd("colorscheme " .. theme.colorscheme)

  local smear_ok, smear = pcall(require, "smear_cursor")
  if smear_ok then smear.setup({ cursor_color = theme.cursor_color }) end
end

-- Poll for macOS appearance changes every second (async — never blocks the editor)
vim.defer_fn(function()
  local timer = vim.uv.new_timer()
  timer:start(1000, 1000, vim.schedule_wrap(function()
    vim.system(
      { "defaults", "read", "-g", "AppleInterfaceStyle" },
      { text = true },
      vim.schedule_wrap(function(result)
        local mode = (result.stdout or ""):match("Dark") and "dark" or "light"
        apply_theme(mode)
      end)
    )
  end))
end, 0)

-- Manual toggle command
vim.api.nvim_create_user_command("ToggleTheme", function()
  local new_mode = vim.g.current_theme_mode == "dark" and "light" or "dark"
  vim.g.current_theme_mode = nil
  apply_theme(new_mode)
end, {})
