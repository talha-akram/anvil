local set_keymap = vim.keymap.set
local options = { noremap = true }

-- Use semicolon to enter command mode
set_keymap('n',';', ':', options)
-- Use CTRL + j/k for fast scroll
set_keymap('n', '<C-k>', '<C-u>', options)
set_keymap('n', '<C-j>', '<C-d>', options)

-- Copy to & paste from system clipboard
set_keymap('v', ',y', '"+y', options)
set_keymap('', ',p', '"+p', options)

-- Trim trailing whitespace
set_keymap('n', ',s', ":%s/\\s\\+$//e<CR>")
-- Delete current buffer, (keep window splits)
set_keymap('n', ',d', ':bd<CR>', options)
-- Use ALT + q/l for opening quickfix and loclist
set_keymap('n', '<A-q>', ':cope<CR>',      options)
set_keymap('n', '<A-l>', ':cope<CR>',      options)
-- Close Quickfix list
set_keymap('n', ']Q', ':cla<CR>', options)
-- Close Location list
set_keymap('n', ',l', ':lcl<CR>', options)
-- Fast * list navigation, inspired by tpope/vim-unimpaired
-- [ / ] -> previous / next, Uppercase Modifier -> First / Last
-- Quickfix list navigation:
set_keymap('n', ',q', ':ccl<CR>', options)
set_keymap('n', '[q', ':cpr<CR>', options)
set_keymap('n', ']q', ':cnex<CR>', options)
set_keymap('n', '[Q', ':cfir<CR>', options)
-- Location list navigation
set_keymap('n', '[l', ':lpr<CR>', options)
set_keymap('n', ']l', ':lne<CR>', options)
set_keymap('n', '[L', ':lfir<CR>', options)
set_keymap('n', ']L', ':lla<CR>', options)
-- Buffer list navigation
set_keymap('n', '[b', ':bp<CR>', options)
set_keymap('n', ']b', ':bn<CR>', options)
set_keymap('n', '[B', ':bf<CR>', options)
set_keymap('n', ']B', ':bl<CR>', options)

-- Yank current line to system clipboard
set_keymap('n', ',y', '+yy', options)
-- Close current window
set_keymap('n', ',c', ':q<CR>', options)
-- Write changes made to open files
set_keymap('n', ',w', ':w<CR>', options)

-- -- Use ctrl+space for omnifunc
-- set_keymap('i', '<C-Space>', '<C-x><C-o>', options)
-- Use alt+space for completefunc
set_keymap('i', '<A-Space>', '<C-x><C-u>', options)

-- Move vertically by visual line
set_keymap('n', 'j', 'gj', options)
set_keymap('n', 'k', 'gk', options)

-- Keep cursor inplace while joining lines
set_keymap('n', 'J', 'mzJ`z', options)

-- Use Shift + J/K to moves selected lines up/down in visual mode
set_keymap('v', 'J', ":m '>+1<CR>gv=gv", options)
set_keymap('v', 'K', ":m '<-2<CR>gv=gv", options)

-- Keep current search result centered on the screen
set_keymap('n', 'n', 'nzz', options)
set_keymap('n', 'N', 'Nzz', options)

-- Keep current cursor position while entering and exiting insert mode
set_keymap('i', '<Esc>', function()
  return vim.fn.pumvisible() == 1 and "<Esc>i<Right>" or "<Right><Esc>"
end, { noremap = true, expr = true })

-- Use <C-w> to move between terminal buffer and other buffers
set_keymap('t', '<C-w>', '<C-\\><C-n><C-w>', options)

