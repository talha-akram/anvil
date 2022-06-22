-- Base NeoVim configuration

-- Only load plugins when not runing as root
if (vim.fn.exists('$SUDO_USER') == 0) then
  require('plugins')
end

-- Set colorscheme
vim.cmd([[
  try
    colorscheme everforest
    catch
  endtry
]])

-- Configure NeoVim
require('configuration')

