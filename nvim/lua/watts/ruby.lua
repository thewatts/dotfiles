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
  pattern = { "*.jbuilder", "*.rb.example", "*.csv.ruby", "*.axlsx", ".pryrc", ".irbrc" },
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
keymap("n", "<Leader>d", 'orequire "pry"; ::Kernel.binding.pry<esc>:w<cr>', { silent = true })
keymap("n", "<Leader>i", "o::Kernel.binding.irb<esc>:w<cr>", { silent = true })

-- ERB
keymap("i", "<C-e>", "<Esc>i<%  %><Left><Left><Left>", { noremap = true, silent = true })
keymap("i", "<C-r>", "<Esc>i<%=  %><Left><Left><Left>", { noremap = true, silent = true })

-- Bundle
keymap("n", "<Leader>bb", ":term bundle install<cr>", { silent = true })

-- Run the current Ruby file in a Floaterm window
keymap("n", "<leader>rr", ':FloatermNew zsh -i -c "ruby %; read"<CR>', { noremap = true, silent = true })

------------------------------------------------------------------
---- Inject a frozen_string_literal comment at the top of the file
local function inject_frozen_string_literal()
  -- Get the filetype of the current buffer
  local filetype = vim.bo.filetype

  -- Check if the filetype is Ruby
  if filetype == "ruby" then
    -- Save the current cursor position
    local current_pos = vim.api.nvim_win_get_cursor(0)

    -- Go to the top of the file
    vim.api.nvim_win_set_cursor(0, { 1, 0 })

    -- Insert the frozen_string_literal comment with a newline
    vim.api.nvim_buf_set_lines(0, 0, 0, false, { "# frozen_string_literal: true" })

    -- Insert an empty line after the comment
    vim.api.nvim_buf_set_lines(0, 1, 1, false, { "" })

    -- Restore the cursor position
    vim.api.nvim_win_set_cursor(0, { current_pos[1] + 2, current_pos[2] })
  else
    -- Output a message that we're not in a Ruby file
    vim.api.nvim_out_write("Not a Ruby file, cannot inject frozen_string_literal\n")
  end
end

keymap('n', '<leader>rfs', '', {
  noremap = true,
  silent = true,
  callback = inject_frozen_string_literal
})
