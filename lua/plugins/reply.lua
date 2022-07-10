-- Reply configuration
local set_keymap = vim.keymap.set
local options = { noremap = true }

set_keymap('v', '<leader>e', ':ReplSend<Cr>', options)
set_keymap('n', '<leader>e', ':Repl<Cr>',     options)
set_keymap('n', '<leader>x', ':ReplStop<Cr>', options)

