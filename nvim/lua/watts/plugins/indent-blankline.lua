-- Indent guides for Neovim
return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {
    indent = {
      char = "│",
      tab_char = "│",
      highlight = "ThemeColumn",
    },
    scope = {
      -- scope keeps one of the lines highlighted, depending on the cursor position
      -- I ultimately didn't really like how this looked, visually, so I'm disabling it
      enabled = false
    }
  }
}
