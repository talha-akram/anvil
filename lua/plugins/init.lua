-- PLUGIN SETTINGS
-- Configure plugins, plugin specific functions and autocommands are to be
-- written in the corresponding files (makes debuging and trying out plugins easier)

-- load packer
local packer = require('packer');

-- add plugins
local function on_startup(use)

  -- set packer to manage itself
  use { 'wbthomason/packer.nvim' }

  -- TreeSitter for improved syntax highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function() require('plugins.treesitter') end
  }

  -- color themes
  use { 'sainnhe/everforest' }
  use { 'sainnhe/gruvbox-material' }

  -- syntax support
  use { 'dag/vim-fish' }
  use { 'MaxMEllon/vim-jsx-pretty' }
  use { 'pangloss/vim-javascript' }

  -- ask for the right file to open in case wrong name is used.
  use { 'EinfachToll/DidYouMean' }

  -- visualise and control undo history in tree form.
  use {
    'mbbill/undotree',
    config = function()
      vim.api.nvim_set_keymap('n', ',r', ':UndotreeToggle<CR>', { noremap = true })
    end
  }

  -- comment/Uncomment blocks of code using gc (or CTRL+/).
  use {
    'numToStr/Comment.nvim',
    requires = { 'JoosepAlviste/nvim-ts-context-commentstring' },
    config = function() require('plugins.comment') end
  }
  -- use { 'tpope/vim-commentary' }

  -- improved git integration
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim', 'tpope/vim-fugitive' },
    config = function() require('gitsigns').setup({ numhl = true }) end
  }

  -- quick fuzzy selection for files and more, see plugin settings.
  use {
    'nvim-telescope/telescope.nvim',
    config = function() require('plugins.telescope') end,
    requires = {
      { 'nvim-telescope/telescope-live-grep-raw.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    },
  }

  -- REPL integration
  use { 'rhysd/reply.vim', cmd = {'Repl', 'ReplAuto', 'ReplSend'}, config = function() require('plugins.reply') end }

  -- LSP Intigration: for builtin language server support (nvim >= 0.5)
  use { 'neovim/nvim-lspconfig', config = function() require('plugins.lsp') end }

  -- snippet support: Use vim-vsnip as snippet provider
  use {
    'hrsh7th/nvim-cmp',
    run = 'npm install -g typescript; gem install solargraph',
    config = function() require('plugins.cmp') end,
    requires = {
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-vsnip'},
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

