-- Run your tests at the speed of thought
return {
  "janko/vim-test",
  dependencies = {
    "voldikss/vim-floaterm",
  },
  keys = {
    -- 🛠️ Test Execution Keymaps
    { "<leader>s", "<cmd>TestNearest<CR>",         desc = "Run the nearest test" },
    { "<leader>t", "<cmd>TestFile COVERAGE=1<CR>", desc = "Run the current test file" },
    { "<leader>a", "<cmd>TestSuite<CR>",           desc = "Run all tests in the suite" },
    { "<leader>g", "<cmd>TestVisit<CR>",           desc = "Go to the last test file" },
    { "<CR>",      "<cmd>TestLast<CR>",            desc = "Re-run the last test" },
  },
  config = function()
    -- 📌 Test Runner Settings
    -- Use the binstub for spring, if it exists and it's enabled in the ENV
    if vim.fn.getenv("USE_SPRING") == "true" then
      vim.g["test#ruby#use_spring_binstub"] = 1
    end

    vim.g["test#preserve_screen"] = 1   -- Prevent screen clearing after tests
    vim.g["test#strategy"] = "floaterm" -- Use Floaterm for test execution
  end,
}
