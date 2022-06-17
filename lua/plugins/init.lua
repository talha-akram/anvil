-- PLUGIN SETTINGS
-- Configure plugins, plugin specific functions and autocommands are to be
-- written in the corresponding files (makes debuging and trying out plugins easier)

-- Use a protected call to avoid errors on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Add plugins
local on_startup = function(use)

  -- Set packer to manage itself
  use { 'wbthomason/packer.nvim' }

  -- Color schemes
  use { 'sainnhe/everforest' }
  use { 'sainnhe/gruvbox-material' }

  -- Ask for the right file to open when file matching name is not found
  use { 'EinfachToll/DidYouMean' }

  -- Visualise and control undo history in tree form.
  use {
    'mbbill/undotree',
    cmd = {'UndotreeToggle', 'UndotreeFocus', 'UndotreeHide', 'UndotreeShow'},
    config = function()
      vim.keymap.set('n', ',r', ':UndotreeToggle<CR>', { noremap = true })
    end
  }

  -- Comment/Uncomment blocks of code using gc
  use {
    'b3nj5m1n/kommentary',
    config = function()
      require('kommentary.config').configure_language("default", {
          prefer_single_line_comments = true,
      })
    end
  }

  -- Quick fuzzy selection for files and more, see plugin settings.
  use {
    'nvim-telescope/telescope.nvim',
    config = function() require('plugins.telescope') end,
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-live-grep-args.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    },
  }

  -- Git integration
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('plugins.gitsigns')

      -- Create User command for opening gitui in neovim, if installed
      if (vim.fn.executable('gitui') == 1) then
          vim.api.nvim_create_user_command('GitUI', 'edit term://gitui', {})
      end
    end,
    -- requires = {'tpope/vim-fugitive', 'rbong/vim-flog'}
  }

  -- REPL integration
  use {
    'rhysd/reply.vim',
    cmd = {'Repl', 'ReplAuto', 'ReplSend'},
    config = function() require('plugins.reply') end
  }

  -- TreeSitter integration
  use {
    'nvim-treesitter/nvim-treesitter',
    config = function() require('plugins.treesitter') end,
    run = ':TSUpdate',
    requires = 'p00f/nvim-ts-rainbow'
  }

  -- DAP integration
  -- use {
  --   'mfussenegger/nvim-dap',
  --   config = function() end,
  --   requires = {
  --     { 'nvim-telescope/telescope-dap.nvim' },
  --     { 'theHamsta/nvim-dap-virtual-text' },
  --     { 'rcarriga/nvim-dap-ui' },
  --     { 'leoluz/nvim-dap-go', config = function() require('dap-go').setup() end  },
  --   },
  -- }

  -- LSP intigration
  use {
    'neovim/nvim-lspconfig',
    config = function() require('plugins.lspconfig') end,
    run = {
      'command -v solargraph >/dev/null || gem install solargraph',
      'command -v gopls >/dev/null || go install golang.org/x/tools/gopls@latest',
      'command -v typescript-language-server >/dev/null || npm install -g typescript-language-server',
    }
  }

  -- Copilot integration
  -- use {
  --   'zbirenbaum/copilot.lua',
  --   config = function()
  --     vim.defer_fn(function() require("copilot").setup() end, 100)
  --   end,
  --   requires = {
  --     'zbirenbaum/copilot-cmp',
  --     after = { "copilot.lua", "nvim-cmp" }
  --   },
  -- }

  -- Use LuaSnip as snippet provider
  use {
    'L3MON4D3/LuaSnip',
    config = function() require('plugins.luasnip') end,
    requires = 'rafamadriz/friendly-snippets'
  }

  -- Snippet and completion integration
  use {
    'hrsh7th/nvim-cmp',
    config = function() require('plugins.cmp') end,
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-buffer',
      'saadparwaiz1/cmp_luasnip',
    }
  }
end

return {
  setup = function(run_sync)
    local config = packer.startup({
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
    end

    return config
  end
}

