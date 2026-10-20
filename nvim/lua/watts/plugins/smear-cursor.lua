-- We only enable smear-cursor when nvim runs directly in Ghostty.
--
-- The animation makes nvim send several times more screen updates on each
-- scroll. Ghostty handles that fine on its own. Inside tmux, a single tmux
-- thread has to process all of that output, which caused stutter and freezes.
-- So the plugin is on outside tmux and off inside it.
return {
  "sphamba/smear-cursor.nvim",
  enabled = vim.env.TMUX == nil,
  -- opts = { -- Default  Range
  --   -- stiffness = 0.8,          -- 0.6      [0, 1]
  --   -- trailing_stiffness = 0.5, -- 0.4      [0, 1]
  --   -- -- stiffness_insert_mode = 0.7,          -- 0.5      [0, 1]
  --   -- -- trailing_stiffness_insert_mode = 0.7, -- 0.5      [0, 1]
  --   -- -- damping = 0.8,                        -- 0.65     [0, 1]
  --   -- -- damping_insert_mode = 0.8,            -- 0.7      [0, 1]
  --   -- distance_stop_animating = 0.5, -- 0.1      > 0
  --   stiffness = 0.5,
  --   trailing_stiffness = 0.5,
  --   matrix_pixel_threshold = 0.5,
  -- },
  opts = {
    cursor_color = "#ffb78a",
    stiffness = 0.8,
    trailing_stiffness = 0.3,
    stiffness_insert_mode = 0.7,
    trailing_stiffness_insert_mode = 0.3,
    damping = 0.95,
    damping_insert_mode = 0.95,
    trailing_exponent = 3,
    distance_stop_animating = 0.5,
    time_interval = 10,
    smear_insert_mode = true,
  }
}
