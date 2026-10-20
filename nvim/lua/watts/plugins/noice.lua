-- 💥 Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    lsp = {
      -- ruby-lsp sends indexing progress for the first minute or two of a
      -- session. Noice redraws its spinner for every update, and each redraw
      -- repaints the whole screen. That made scrolling slow and kept Ghostty
      -- at full CPU. We turn the progress indicator off to stop it.
      progress = {
        enabled = false,
      },
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    routes = {
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "%d+L, %d+B" },
            { find = "; after #%d+" },
            { find = "; before #%d+" },
          },
        },
        view = "mini",
      },
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "hamllint",
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "notify",
          find = "hamllint",
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "msg_show",
          kind = "echomsg",
          find = "hamllint",
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "cmdline",
          find = "a:message",
        },
        opts = { skip = true },
      }
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = true,
    },
  },
  keys = {
    {
      "<S-Enter>",
      function() require("noice").redirect(vim.fn.getcmdline()) end,
      mode = "c",
      desc =
      "Redirect Cmdline"
    },
    {
      "<leader>snl",
      function() require("noice").cmd("last") end,
      desc =
      "Noice Last Message"
    },
    {
      "<leader>snh",
      function() require("noice").cmd("history") end,
      desc =
      "Noice History"
    },
    { "<leader>sna", function() require("noice").cmd("all") end,     desc = "Noice All" },
    { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
    {
      "<c-f>",
      function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,
      silent = true,
      expr = true,
      desc =
      "Scroll forward",
      mode = {
        "i", "n", "s" }
    },
  },
}
