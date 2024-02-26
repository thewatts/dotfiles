local keymap = vim.keymap

-- Incremental LSP renaming based on Neovim's command-preview feature.
return {
  "smjonas/inc-rename.nvim",
  config = function()
    require("inc_rename").setup()

    keymap.set("n", "<leader>rn", function()
      return ":IncRename " .. vim.fn.expand("<cword>")
    end, { expr = true })
  end,
}
