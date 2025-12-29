-- Base neovim configuration

-- Configure neovim options
require('configuration.options')

-- Enable custom statusline
require('configuration.statusline')

-- Enable custom autocommands (nvim >= 0.7)
require('configuration.autocommands')

-- Set custom keymaps (nvim >= 0.7)
require('configuration.keymaps')

-- Only load plugins when not runing as root
if (vim.fn.exists('$SUDO_USER') == 0) then
  -- Enable Plugins
  if vim.fn.has("nvim-0.12") == 1 then
    require('configuration.plugins')
  end
end
