local common_options = require('plugins.lsp');
local lsp = require('lspconfig');

-- Languange Servers we want to enable
local language_servers = {
  ts_ls = common_options,
  rubocop = common_options,
  ruby_lsp = common_options,
  gopls = common_options,
  dartls = common_options,
  vuels = common_options,
  rust_analyzer = common_options,
  coffeesense = {
    cmd = { 'coffeesense-language-server', '--stdio' },
    filetypes = { 'coffee', 'vue' },
    single_file_support = true,
    on_attach = common_options.on_attach,
    capabilities = common_options.capabilities,
  },
};

-- Setup and configure language servers
for server, options in pairs(language_servers) do
  lsp[server].setup(options);
end
