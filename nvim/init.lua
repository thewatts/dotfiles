require("watts.core")
require("watts.git")
require("watts.ruby")
require("watts.lazy")

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.textwidth = 0 -- Set to 0 to wrap at window width
  end,
})
