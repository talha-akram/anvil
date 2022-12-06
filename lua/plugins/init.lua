-- Plugins
-- Configure plugins, plugin specific functions and autocommands are to be
-- written in the corresponding files (makes debuging and trying out plugins easier)

local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local run_sync = false

-- Install packer for package management, if missing
if (fn.empty(fn.glob(install_path)) > 0) then
  run_sync = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
  vim.cmd('packadd packer.nvim')
end

-- Use a protected call to avoid errors on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  vim.notify('Packer not found, Plugins will not be available!')
  return
end

-- Add plugins
local on_startup = function(use)

  -- Set packer to manage itself
  use('wbthomason/packer.nvim')

  -- Color schemes
  use('sainnhe/everforest')
  use('sainnhe/gruvbox-material')
  use({ 'kartikp10/noctis.nvim', requires = { 'rktjmp/lush.nvim' } })

  -- Ask for the right file to open when file matching name is not found
  use('EinfachToll/DidYouMean')

  -- Visualise and control undo history in tree form.
  use({
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', ',r', '<CMD>UndotreeToggle<CR>', { noremap = true })
    end
  })

  -- Notes
  use({ 'phaazon/mind.nvim', config = function() require'mind'.setup() end })

  -- Comment/Uncomment blocks of code using gc
  use({
    'b3nj5m1n/kommentary',
    config = function()
      require('kommentary.config').configure_language(
        'default', { prefer_single_line_comments = true }
      )
    end
  })

  -- Fuzzy selection for files and more, see plugin settings.
  use({
    'nvim-telescope/telescope.nvim',
    config = function() require('plugins.telescope') end,
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-live-grep-args.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    }
  })

  -- Git integration
  -- use({ 'rbong/vim-flog', branch = 'v2', requires = 'tpope/vim-fugitive' })
  use({
    'lewis6991/gitsigns.nvim',
    config = function() require('plugins.gitsigns') end
  })
  use({
    'TimUntersberger/neogit',
    config = function() require('plugins.neogit') end,
    cmd = 'Neogit',
  })

  -- REPL integration
  use({
    'rhysd/reply.vim',
    cmd = {'Repl', 'ReplAuto', 'ReplSend'},
    config = function() require('plugins.reply') end
  })

  -- TreeSitter integration
  use({
    'nvim-treesitter/nvim-treesitter',
    config = function() require('plugins.treesitter') end,
    run = ':TSUpdate',
    requires = 'p00f/nvim-ts-rainbow'
  })

  -- DAP integration
  use({
    'mfussenegger/nvim-dap',
    requires = {
      'nvim-telescope/telescope-dap.nvim',
      'theHamsta/nvim-dap-virtual-text',
      { 'rcarriga/nvim-dap-ui', config = function() require('plugins.dapui') end  },
    }
  })

  -- LSP intigration
  use({
    'neovim/nvim-lspconfig',
    config = function() require('plugins.lspconfig') end,
    run = {
      'command -v solargraph >/dev/null || gem install solargraph',
      'command -v gopls >/dev/null || go install golang.org/x/tools/gopls@latest',
      'command -v typescript-language-server >/dev/null || npm install -g typescript-language-server'
    }
  })

  -- Use LuaSnip as snippet provider
  use({
    'L3MON4D3/LuaSnip',
    config = function() require('plugins.luasnip') end,
    requires = 'rafamadriz/friendly-snippets'
  })

  -- Snippet and completion integration
  use({
    'hrsh7th/nvim-cmp',
    config = function() require('plugins.cmp') end,
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-buffer',
      'saadparwaiz1/cmp_luasnip'
    }
  })
end

packer.startup({
  on_startup,
  config = {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end
    }
  }
})

if run_sync then
  packer.sync()
  vim.notify('Please restart Neovim now for stabilty')
end

