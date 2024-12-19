local common_options = require('configuration.lsp');
local lsp = require('lspconfig');

-- Languange Servers we want to enable
local language_servers = {
  ts_ls = common_options,
  dartls = common_options,
  vuels = common_options,
  rust_analyzer = common_options,
};

-- Setup and configure language servers
for server, options in pairs(language_servers) do
  lsp[server].setup(options);
end
