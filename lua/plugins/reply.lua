-- Reply configuration
local set_keymap = vim.api.nvim_set_keymap

set_keymap('v', '<leader>e', ':ReplSend<Cr>', {noremap = true})
set_keymap('n', '<leader>e', ':Repl<Cr>',     {noremap = true})
set_keymap('n', '<leader>x', ':ReplStop<Cr>', {noremap = true})

