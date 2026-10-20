-- Auto-close blocks (adds `end` after `def`/`class`/`if`/`do`/etc. on <CR>).
--
-- Treesitter-based, so it works alongside the nvim-treesitter `main` branch:
-- on Neovim >= 0.9 its init() attaches per FileType via `vim.treesitter`
-- queries and never touches the removed `define_modules` API.
--
-- tpope/vim-endwise is NOT an option here: it decides whether to add `end` via
-- regex-syntax `synID()` groups, which treesitter never populates, so it
-- silently does nothing in a treesitter-highlighted buffer.
return {
  "RRethy/nvim-treesitter-endwise",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
}
