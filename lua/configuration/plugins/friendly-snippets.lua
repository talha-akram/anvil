-- Use snippets provided by friendly-snippets
vim.keymap.set('i', '<A-Space>', '<C-x><C-u>', { noremap = true, desc = 'Snippets' });

return {
  src = 'https://github.com/rafamadriz/friendly-snippets',
  data = {
    setup = function() require('configuration.snippets') end,
  },
}
