-- Telescope configuration
local telescope = require('telescope')
local set_keymap = vim.api.nvim_set_keymap

telescope.load_extension('fzf')

set_keymap(
  'n',
  '<leader>f',
  '<cmd>lua require("telescope").extensions.live_grep_raw.live_grep_raw()<cr>',
  {noremap = true}
)
set_keymap('n', '<leader>o', '<cmd>lua require("telescope.builtin").find_files()<cr>',   {noremap = true})
set_keymap('n', '<leader>b', '<cmd>lua require("telescope.builtin").buffers()<cr>',      {noremap = true})
set_keymap('n', '<leader>p', '<cmd>lua require("telescope.builtin").commands()<cr>',     {noremap = true})
set_keymap('n', '<F1>',      '<cmd>lua require("telescope.builtin").help_tags()<cr>',    {noremap = true})
set_keymap('n', '<F9>',      '<cmd>lua require("telescope.builtin").file_browser()<cr>', {noremap = true})

