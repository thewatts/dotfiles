local api = vim.api

-- Turn off paste mode when leaving insert mode
api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",           -- match all files
  command = "set nopaste", -- turn off paste mode
})
