-- Plugins
local fn = vim.fn;
local install_path = fn.stdpath('data') .. '/lazy/lazy.nvim';

if not vim.loop.fs_stat(install_path) then
  vim.notify('Installing Plugins... please wait!')

  fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    install_path,
  });
end
vim.opt.rtp:prepend(install_path);

require('lazy').setup({
  -- Color schemes
  'talha-akram/noctis.nvim',

  -- Syntax support for languages
  { 'https://gitlab.com/theoreichel/tree-sitter-slim', ft = 'slim' },

  -- Visualise and control undo history in tree form.
  {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
    keys = {
      { ',r', '<CMD>UndotreeToggle<CR>', desc = 'Undotree', noremap = true },
    },
  },

  -- Fuzzy selection for files and more, see plugin settings for keymaps.
  {
    'echasnovski/mini.pick',
    version = false,
    config = function() require('plugins.picker') end,
  },

  -- Git integration
  {
    'lewis6991/gitsigns.nvim',
    config = function() require('plugins.gitsigns') end,
  },

  -- TreeSitter integration
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    config = function() require('plugins.treesitter') end,
    build = ':TSUpdate',
  },

  -- Use snippets provided by friendly-snippets
  {
    'rafamadriz/friendly-snippets',
    config = function() require('plugins.snippets') end,
  },

  -- -- Preview colors (useful for developing themes)
  -- {
  --   'norcalli/nvim-colorizer.lua',
  --   config = function() require('colorizer').setup() end,
  -- }
});
