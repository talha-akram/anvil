local gitsigns = require('configuration.plugins.gitsigns');
local picker = require('configuration.plugins.picker');
local snippets = require('configuration.plugins.friendly-snippets');
local textobjects = require('configuration.plugins.textobjects');
local treesitter = require('configuration.plugins.treesitter');
local undotree = require('configuration.plugins.undotree');


vim.pack.add({
  -- 'https://github.com/talha-akram/noctis.nvim',
  -- 'https://github.com/norcalli/nvim-colorizer.lua',
  gitsigns,
  picker,
  snippets,
  textobjects,
  treesitter,
  undotree,
},{
  load = function(plug)
    local data = plug.spec.data or {}
    local setup = data.setup

    vim.cmd.packadd(plug.spec.name)

    if setup ~= nil and type(setup) == 'function' then
      setup()
    end
  end
});
