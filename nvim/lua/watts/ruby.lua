local keymap = vim.keymap.set
local cmd = vim.api.nvim_create_autocmd

-- Setting Ruby Path
vim.g.ruby_path = vim.fn.system("echo $HOME/.rbenv/shims")

-- Autocommands for File Type Settings
cmd("FileType", {
  pattern = "conf",
  command = "set filetype=ruby",
})

-- Setting File Types for Specific Extensions
cmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.jbuilder", "*.rb.example", "*.csv.ruby", "*.axlsx" },
  command = "set filetype=ruby",
})

cmd({ "BufRead", "BufNewFile" }, {
  pattern = { ".env.local", ".env.development", ".env.test", ".env.production" },
  command = "setf sh",
})

-- Key Mappings
-- Quick insert hashrocket
keymap("i", "<C-l>", " => ")

-- Insert a binding.pry under cursor
keymap("n", "<Leader>p", 'orequire "pry"; ::Kernel.binding.pry<esc>:w<cr>', { silent = true })
keymap("n", "<Leader>d", "o::Kernel.binding.irb<esc>:w<cr>", { silent = true })

-- ERB
keymap("i", "<C-e>", "<Esc>i<%  %><Left><Left><Left>", { noremap = true, silent = true })
keymap("i", "<C-r>", "<Esc>i<%=  %><Left><Left><Left>", { noremap = true, silent = true })

-- Bundle
keymap("n", "<Leader>bb", ":term bundle install<cr>", { silent = true })
