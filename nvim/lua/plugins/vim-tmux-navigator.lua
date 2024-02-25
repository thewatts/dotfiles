return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  keys = {
    {
      "<c-h>",
      "<cmd><C-U>TmuxNavigateLeft<cr>",
      desc = "Navigate left between tmux/nvim splits"
    },
    {
      "<c-j>",
      "<cmd><C-U>TmuxNavigateDown<cr>",
      desc = "Navigate down between tmux/nvim splits"
    },
    {
      "<c-k>",
      "<cmd><C-U>TmuxNavigateUp<cr>",
      desc = "Navigate up between tmux/nvim splits"
    },
    {
      "<c-l>",
      "<cmd><C-U>TmuxNavigateRight<cr>",
      desc = "Navigate right between tmux/nvim splits"
    },
    {
      "<c-\\>",
      "<cmd><C-U>TmuxNavigatePrevious<cr>",
      desc = "Navigate to the previous tmux/nvim split"
    },
  },
}
