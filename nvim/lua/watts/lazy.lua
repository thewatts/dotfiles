-- lazy.nvim is a modern plugin manager for Neovim.
-- https://github.com/folke/lazy.nvim?tab=readme-ov-file#-installation
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- From the docs:
-- require("lazy").setup(plugins, opts)
require("lazy").setup({ { import = "watts.plugins" } }, {
  change_detection = {
    notify = false
  }
})

-- Launch Lazy with <leader>l
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { noremap = true })
