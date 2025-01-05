-- Plugins
local fn = vim.fn;
local install_path = fn.stdpath('data') .. '/lazy/lazy.nvim';

if not vim.loop.fs_stat(install_path) then
  vim.notify('Installing Plugins... please wait!')

  fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    install_path,
  });
end

vim.opt.rtp:prepend(install_path);

require('lazy').setup({
  change_detection = {
    enabled = false,
    notify = false,
  },

  -- Load plugin spec files
  { import = 'plugins' },

  -- Other plugins ------------------------------------------------------------
  -- Color schemes
  'talha-akram/noctis.nvim',
  -- -- Preview colors (useful for developing themes)
  -- {
  --   'norcalli/nvim-colorizer.lua',
  --   enabled = false,
  --   config = true,
  -- },
});
