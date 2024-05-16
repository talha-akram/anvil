-- Plugins
local fn = vim.fn;
local install_path = fn.stdpath("data") .. "/lazy/lazy.nvim";

if not vim.loop.fs_stat(install_path) then
  vim.notify('Installing Plugins... please wait!')

  fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    install_path,
  });
end
vim.opt.rtp:prepend(install_path);

require('lazy').setup({
  -- Color schemes
  'talha-akram/noctis.nvim',

  -- Search & replace visual selection using CTRL+f
  {
    'windwp/nvim-spectre',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('spectre').setup({
        color_devicons = true,
        open_cmd = '50vsplit new',
        vim.keymap.set('v', '<C-f>', function()
          require('spectre').open_visual({ select_word = true })
        end)
      })
    end
  },

  -- Visualise and control undo history in tree form.
  {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
    keys = {
      { ',r', '<CMD>UndotreeToggle<CR>', desc = 'Undotree', noremap = true },
    },
  },

  -- Comment/Uncomment blocks of code using gc
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup({
        ignore = '^$',
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      });
    end
  },

  -- Fuzzy selection for files and more, see plugin settings.
  {
    'nvim-telescope/telescope.nvim',
    config = function() require('plugins.telescope') end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-live-grep-args.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    }
  },

  -- Git integration
  {
    'lewis6991/gitsigns.nvim',
    config = function() require('plugins.gitsigns') end
  },

  -- TreeSitter integration
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    config = function() require('plugins.treesitter') end,
    build = ':TSUpdate',
    dependencies = 'JoosepAlviste/nvim-ts-context-commentstring',
  },

  -- Manage language and debug servers
  {
    "williamboman/mason.nvim",
    config = function() require('mason').setup() end,
  },

  -- DAP integration
  {
    'mfussenegger/nvim-dap',
    config = function() require('plugins.dap') end,
    dependencies = {
      'nvim-telescope/telescope-dap.nvim',
      'theHamsta/nvim-dap-virtual-text',
    }
  },

  -- LSP intigration
  {
    'neovim/nvim-lspconfig',
    config = function() require('plugins.lspconfig') end
  },

  -- Use LuaSnip as snippet provider
  {
    'L3MON4D3/LuaSnip',
    config = function() require('plugins.luasnip') end,
    dependencies = 'rafamadriz/friendly-snippets'
  },

  -- -- Preview colors
  -- {
  --   'norcalli/nvim-colorizer.lua',
  --   config = function() require('colorizer').setup() end,
  -- }
});
