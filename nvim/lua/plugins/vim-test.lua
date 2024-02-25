return {
  "janko/vim-test",
  keys = {
    {
      "<leader>s",
      "<cmd>TestNearest<CR>",
      desc = "Run the nearest test, in relation to the cursor"
    },
    {
      "<leader>t",
      "<cmd>TestFile<CR>",
      desc = "Run the current test file"
    },
    {
      "<leader>a",
      "<cmd>TestSuite<CR>",
      desc = "Run all tests in the current test suite"
    },
    {
      "<leader>g",
      "<cmd>TestVisit<CR>",
      desc = "Visit the test file for the most recently run test"
    },
    {
      "<CR>",
      "<cmd>TestLast<CR>",
      desc = "Re-run the most recently run test"
    }
  },
  config = function()
    -- Use the binstub for spring, if it exists
    vim.g["test#ruby#use_spring_binstub"] = 1
    -- Preserve the screen after running tests
    vim.g["test#preserve_screen"] = 1

    -- Currently, when running the specs, the window covers the whole screen.
    -- There's the possibility of using a different strategy, but I need to
    -- dig into other options to see what's available.
    --
    -- https://github.com/vim-test/vim-test?tab=readme-ov-file#strategies
  end,
}
