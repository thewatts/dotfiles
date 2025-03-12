return {
  "dense-analysis/ale",
  config = function()
    -- Configuration goes here.
    local g = vim.g

    g.ale_ruby_rubocop_auto_correct_all = 1

    g.ale_linters = {
      haml = { 'hamllint' },
    }

    g.ale_fixers = {
      haml = { 'hamllint' }
    }

    -- Set this variable to 1 to fix files when you save them.
    g.ale_fix_on_save = 1

    -- Only run linters named in ale_linters settings.
    g.ale_linters_explicit = 1

    -- g.ale_cursor_detail = 1

    g.ale_echo_msg_error_str = 'E'
    g.ale_echo_msg_warning_str = 'W'
    g.ale_echo_msg_format = '[%linter%] %s [%severity%]'
  end
}
