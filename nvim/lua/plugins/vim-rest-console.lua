return {
  "diepm/vim-rest-console",
  keys = {
    {
      "<Leader>xr",
      "<cmd>call VrcQuery()<CR>",
      desc = "Run the Rest query that's under the cursor, using vim-rest-console"
    }
  },
  config = function()
    -- remove default mapping for running queries
    vim.g.vrc_set_default_mapping = 0
    -- set default content type to json
    vim.g.vrc_response_default_content_type = "application/json"
    -- set default output buffer name
    vim.g.vrc_output_buffer_name = "_OUTPUT.json"

    -- use jq to pretty format json response
    vim.g.vrc_auto_format_response_patterns = {
      json = "jq",
    }
  end,
}
