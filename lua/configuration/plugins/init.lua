local gitsigns = require('configuration.plugins.gitsigns');
local picker = require('configuration.plugins.picker');
local snippets = require('configuration.plugins.friendly-snippets');
local treesitter = require('configuration.plugins.treesitter');
local undotree = require('configuration.plugins.undotree');


vim.pack.add({
  'https://github.com/talha-akram/noctis.nvim',
  -- 'https://github.com/norcalli/nvim-colorizer.lua',
  gitsigns,
  picker,
  snippets,
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

    local build_cmd = data.build_cmd
    if build ~= nil and type(setup) == 'string' then
      vim.cmd(build_cmd)
    end
  end
});
