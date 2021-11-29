-- Base NeoVim configuration

local fn = vim.fn
local vim_cmd = vim.cmd

-- Only load plugins when not runing as root
if (fn.exists('$SUDO_USER') == 0) then
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  local run_sync = false

  -- install packer for package management, if missing
  if (fn.empty(fn.glob(install_path)) > 0) then
    run_sync = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  end

  require('plugins').setup(run_sync)
end

vim.cmd([[
  " Set fish as default shell
  set shell=fish

  " Set colorscheme
  set background=dark
  let g:gruvbox_material_background = 'medium'
  try
    colorscheme gruvbox-material
    catch
  endtry

  " Enable autocommands
  source ~/.config/nvim/startup/AutoCommands.vim

  " Setup keybindings
  source ~/.config/nvim/startup/Keybindings.vim
]])

-- Configure NeoVim
require('configuration').setup()

