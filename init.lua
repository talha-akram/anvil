-- Base NeoVim configuration

local fn = vim.fn

-- Only load plugins when not runing as root
if (fn.exists('$SUDO_USER') == 0) then
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  local run_sync = false

  -- install packer for package management, if missing
  if (fn.empty(fn.glob(install_path)) > 0) then
    run_sync = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  end

  require('plugins').setup(run_sync)
  print('Neovim restart required for stabilty')
end


-- Set colorscheme
vim.cmd([[
  try
    colorscheme everforest
    catch
  endtry
]])

-- Configure NeoVim
require('configuration').setup()

