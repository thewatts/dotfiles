local api = vim.api
local cmd = vim.cmd

-- Turn off paste mode when leaving insert mode
api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",           -- match all files
  command = "set nopaste", -- turn off paste mode
})

-- Auto Strip Whitespace on Save
-- I should probably move this into some sort of autocommands group or something :)
api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    -- Use Lua's vim.cmd to execute the Ex command for substitution
    cmd([[%s/\s\+$//e]])
  end,
})
