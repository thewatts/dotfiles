-- Indent guides for Neovim.
--
-- Disabled in favour of Neovim's built-in guides (`listchars` with
-- `leadmultispace`, see core/options.lua). indent-blankline attaches virtual
-- text to every visible line and refreshes all of them on each scroll, which
-- measured at ~7.5 KB of extra terminal output per scroll keystroke in a
-- vertical split (the built-in guides measured at zero). The only visible
-- difference: built-in guides do not continue through blank lines.
return {
  "lukas-reineke/indent-blankline.nvim",
  enabled = false,
  main = "ibl",
  opts = {
    indent = {
      char = "│",
      tab_char = "│",
    },
    scope = {
      enabled = false,
    },
  },
}
