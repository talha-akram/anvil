-- Gitsigns configuration
local gitsigns = require('gitsigns')

local on_attach = function()
  local set_keymap = function(lhs, rhs)
    vim.keymap.set('n', lhs, rhs, { noremap = true })
  end

  set_keymap(',gs', gitsigns.stage_hunk)
  set_keymap(',gu', gitsigns.undo_stage_hunk)
  set_keymap('[g',  gitsigns.prev_hunk)
  set_keymap(']g',  gitsigns.next_hunk)
  set_keymap(',g',  gitsigns.preview_hunk)
end

gitsigns.setup({
  on_attach = on_attach,
  sign_priority = 10,
  update_debounce = 100,
  status_formatter = nil,
  max_file_length = 40000,
  current_line_blame_formatter = '      <author>, <author_time:%R> - <summary>',
  signs = {
    add          = { hl = 'GitSignsAdd',    text = '┃', numhl='GitSignsAddNr',    linehl='GitSignsAddLn'    },
    change       = { hl = 'GitSignsChange', text = '┃', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
    changedelete = { hl = 'GitSignsChange', text = '━', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
    delete       = { hl = 'GitSignsDelete', text = '┳', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
    topdelete    = { hl = 'GitSignsDelete', text = '┻', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
    -- delete       = { hl = 'GitSignsDelete', text = '▁', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
    -- topdelete    = { hl = 'GitSignsDelete', text = '▔', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
  },
  signcolumn = true,
  numhl      = false,
  linehl     = false,
  word_diff  = false,
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol',
    delay = 1000,
    ignore_whitespace = false,
  },
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
})

