-- Use snippets provided by friendly-snippets
return {
  'rafamadriz/friendly-snippets',
  config = function() require('configuration.snippets') end,
  keys = {
    {'<A-Space>', '<C-x><C-u>', mode = 'i', desc = 'Snippets'}
  },
}
