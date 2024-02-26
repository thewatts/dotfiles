-- Vim and Neovim plugin to reveal the commit messages under the cursor
return {
  "rhysd/git-messenger.vim",
  lazy = false,
  keys = {
    {
      "<Leader>gm",
      "<cmd>GitMessenger<CR>",
      desc = "Show the commit message for the current line",
    }
  }
}
