-- Base neovim configuration
local Options = require('configuration.options')
local StatusLine = require('configuration.statusline')

return {
  Options = Options,
  StatusLine = StatusLine,
  setup = function()
    -- Configure neovim options
    Options.setup()
    -- Enable custom statusline
    StatusLine.setup()
  end
}

