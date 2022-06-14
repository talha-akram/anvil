-- PLUGIN SETTINGS
-- Configure plugins, plugin specific functions and autocommands are to be
-- written in the corresponding files (makes debuging and trying out plugins easier)

-- load packer
local packer = require('packer');

-- Add plugins
local function on_startup(use)

  -- Set packer to manage itself
  use { 'wbthomason/packer.nvim' }

  -- Color schemes
  use { 'sainnhe/everforest' }
  use { 'sainnhe/gruvbox-material' }

  -- Syntax support
  use { 'dag/vim-fish' }
  use { 'MaxMEllon/vim-jsx-pretty' }
  use { 'pangloss/vim-javascript' }

  -- Ask for the right file to open when file matching name is not found
  use { 'EinfachToll/DidYouMean' }

  -- Visualise and control undo history in tree form.
  use {
    'mbbill/undotree',
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
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-live-grep-args.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    },
  }

  -- Git integration
  use {
    'lewis6991/gitsigns.nvim',
    config = function() require('plugins.gitsigns') end,
    requires = { 'nvim-lua/plenary.nvim', 'tpope/vim-fugitive', 'rbong/vim-flog' }
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
    requires = { 'p00f/nvim-ts-rainbow' }
  }

  -- -- DAP integration
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
      'npm install -g typescript',
      'gem install solargraph',
      'go install golang.org/x/tools/gopls@latest'
    }
  }

  -- Copilot integration
  -- use {
  --   'zbirenbaum/copilot.lua',
  --   config = function()
  --     vim.defer_fn(function() require("copilot").setup() end, 100)
  --   end,
  -- }

  -- Snippet and completion support, uses vim-vsnip as snippet provider
  use {
    'hrsh7th/nvim-cmp',
    config = function() require('plugins.cmp') end,
    requires = {
      {'L3MON4D3/LuaSnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-vsnip'},
      {'saadparwaiz1/cmp_luasnip'},
      -- { 'zbirenbaum/copilot-cmp', after = { "copilot.lua", "nvim-cmp" } },
      {'hrsh7th/vim-vsnip', config = function() require('plugins.vsnip') end }
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

