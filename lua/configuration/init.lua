-- Base neovim configuration
local Options = require('configuration.options')
local StatusLine = require('configuration.statusline')
local autocommands = require('configuration.autocommands')
local keymaps = require('configuration.keymaps')

return {
  Options = Options,
  StatusLine = StatusLine,
  setup = function()
    -- Configure neovim options
    Options.setup()
    -- Enable custom statusline
    StatusLine.setup()
    -- Enable custom autocommands (nvim >= 0.7)
    autocommands.setup()
    -- Set custom keymaps (nvim >= 0.7)
    keymaps.setup()
  end
}

