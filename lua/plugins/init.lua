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

  -- -- Preview colors (useful for developing themes)
  -- {
  --   'norcalli/nvim-colorizer.lua',
  --   config = function() require('colorizer').setup() end,
  -- },

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
  {
    'isakbm/gitgraph.nvim',
    opts = {
      symbols = {
        merge_commit = 'M',
        commit = '*',
      },
      format = {
        timestamp = '%H:%M:%S %d-%m-%Y',
        fields = { 'hash', 'timestamp', 'author', 'branch_name', 'tag' },
      },
      hooks = {
        on_select_commit = function(commit)
          print('selected commit:', commit.hash)
        end,
        on_select_range_commit = function(from, to)
          print('selected range:', from.hash, to.hash)
        end,
      },
    },
    keys = {
      {
        ",l",
        function()
          require('gitgraph').draw({}, { all = true, max_count = 5000 })
        end,
        desc = "GitGraph - Draw",
      },
    },
  },

  -- TreeSitter configurations for nvim
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      -- Support for languages which are yet to be included
      'https://gitlab.com/theoreichel/tree-sitter-slim',
    },
    lazy = false,
    config = function() require('plugins.treesitter') end,
    build = ':TSUpdate',
  },

  -- Use snippets provided by friendly-snippets
  {
    'rafamadriz/friendly-snippets',
    config = function() require('configuration.snippets') end,
    keys = {
      {'<A-Space>', '<C-x><C-u>', mode = 'i', desc = 'Snippets'}
    },
  },
});
