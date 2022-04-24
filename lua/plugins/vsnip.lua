local set_keymap = vim.keymap.set

-- Expand if a snippet is available
set_keymap('i', '<A-Space>', 'vsnip#expandable() ? "<Plug>(vsnip-expand)" : "<A-Space>"', { expr = true })
set_keymap('s', '<A-Space>', 'vsnip#expandable() ? "<Plug>(vsnip-expand)" : "<A-Space>"', { expr = true })

-- Expand or jump
set_keymap('i', '<Tab>', 'vsnip#available(1) ? "<Plug>(vsnip-expand-or-jump)" : "<Tab>"', { expr = true })
set_keymap('s', '<Tab>', 'vsnip#available(1) ? "<Plug>(vsnip-expand-or-jump)" : "<Tab>"', { expr = true })

-- Jump forward or backward
set_keymap('i', '<S-Tab>', 'vsnip#jumpable(-1) ? "<Plug>(vsnip-jump-prev)" : "<S-Tab>"', { expr = true })
set_keymap('s', '<S-Tab>', 'vsnip#jumpable(-1) ? "<Plug>(vsnip-jump-prev)" : "<S-Tab>"', { expr = true })

-- Directory where custom snippets are saved
vim.g.vsnip_snippet_dir = vim.fn.stdpath('config') .. '/snippets'

