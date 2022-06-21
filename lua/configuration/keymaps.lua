local set_keymap = vim.keymap.set

-- Use semicolon to enter command mode
set_keymap('n',';', ':', { noremap = true })
-- Use CTRL + j/k for fast scroll
set_keymap('n', '<C-k>', '<C-u>', { noremap = true })
set_keymap('n', '<C-j>', '<C-d>', { noremap = true })

-- Copy to & paste from system clipboard
set_keymap('v', ',y', '"+y', { noremap = true })
set_keymap('', ',p', '"+p', { noremap = true })

-- Trim trailing whitespace
set_keymap('n', ',s', ":%s/\\s\\+$//e<CR>")
-- Delete current buffer, (keep window splits)
set_keymap('n', ',d', ':bd<CR>', { noremap = true })
-- Use ALT + q/l for opening quickfix and loclist
set_keymap('n', '<A-q>', ':cope<CR>',      { noremap = true })
set_keymap('n', '<A-l>', ':cope<CR>',      { noremap = true })
-- Close Quickfix list
set_keymap('n', ']Q', ':cla<CR>', { noremap = true })
-- Close Location list
set_keymap('n', ',l', ':lcl<CR>', { noremap = true })
-- Fast * list navigation, inspired by tpope/vim-unimpaired
-- [ / ] -> previous / next, Uppercase Modifier -> First / Last
-- Quickfix list navigation:
set_keymap('n', ',q', ':ccl<CR>', { noremap = true })
set_keymap('n', '[q', ':cpr<CR>', { noremap = true })
set_keymap('n', ']q', ':cnex<CR>', { noremap = true })
set_keymap('n', '[Q', ':cfir<CR>', { noremap = true })
-- Location list navigation
set_keymap('n', '[l', ':lpr<CR>', { noremap = true })
set_keymap('n', ']l', ':lne<CR>', { noremap = true })
set_keymap('n', '[L', ':lfir<CR>', { noremap = true })
set_keymap('n', ']L', ':lla<CR>', { noremap = true })
-- Buffer list navigation
set_keymap('n', '[b', ':bp<CR>', { noremap = true })
set_keymap('n', ']b', ':bn<CR>', { noremap = true })
set_keymap('n', '[B', ':bf<CR>', { noremap = true })
set_keymap('n', ']B', ':bl<CR>', { noremap = true })

-- Yank current line to system clipboard
set_keymap('n', ',y', '+yy', { noremap = true })
-- Close current window
set_keymap('n', ',c', ':q<CR>', { noremap = true })
-- Write changes made to open files
set_keymap('n', ',w', ':w<CR>', { noremap = true })

-- -- Use ctrl+space for omnifunc
-- set_keymap('i', '<C-Space>', '<C-x><C-o>', { noremap = true })
-- -- Use alt+space for completefunc
-- set_keymap('i', '<A-Space>', '<C-x><C-u>', { noremap = true })

-- Move vertically by visual line
set_keymap('n', 'j', 'gj', { noremap = true })
set_keymap('n', 'k', 'gk', { noremap = true })

-- Keep cursor inplace while joining lines
set_keymap('n', 'J', 'mzJ`z', { noremap = true })

-- Use Shift + J/K to moves selected lines up/down in visual mode
set_keymap('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true })
set_keymap('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true })

-- Keep current search result centered on the screen
set_keymap('n', 'n', 'nzz', { noremap = true })
set_keymap('n', 'N', 'Nzz', { noremap = true })

-- Close popup menu and compensate cursor shifting one place left
set_keymap('i', '<Esc>', function()
  return vim.fn.pumvisible() == 1 and "<Esc>i<Right>" or "<Right><Esc>"
end, { noremap = true, expr = true })

-- Use <C-w> to move between terminal buffer and other buffers
set_keymap('t', '<C-w>', '<C-\\><C-n><C-w>', { noremap = true })

