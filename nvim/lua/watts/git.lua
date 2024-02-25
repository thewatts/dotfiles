-- Autocommands for Git Commit Messages
vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  callback = function()
    vim.opt.colorcolumn = "50,72"
    vim.opt.textwidth = 72
  end,
})

-- OpenCommitMessageDiff Function
local function OpenCommitMessageDiff()
  vim.api.nvim_exec(
    [[
    let old_z = getreg("z")
    let old_z_type = getregtype("z")
    try
      call cursor(1, 0)
      let diff_start = search("^diff --git")
      if diff_start == 0
        let @z = system("git diff --cached -M -C")
      else
        :.,$yank z
        call cursor(1, 0)
      endif
      vnew
      normal! V"zP
    finally
      call setreg("z", old_z, old_z_type)
    endtry
    set filetype=diff noswapfile nomodified readonly
    silent file [Changes\ to\ be\ committed]
    wincmd p
  ]],
    false
  )
end

-- Autocmd to call OpenCommitMessageDiff on entering COMMIT_EDITMSG
vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "COMMIT_EDITMSG",
  callback = OpenCommitMessageDiff,
})
