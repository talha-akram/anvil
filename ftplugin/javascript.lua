local options = require('configuration.lsp');

require('ftplugin.typescript')

vim.lsp.start({
  cmd = { 'quick-lint-js', '--lsp-server' },
  filetypes = { 'javascript', 'typescript' },
  root_dir = vim.fs.root(0, {'tsconfig.json', 'jsconfig.json', 'package.json', '.git'}),
  single_file_support = true,
  on_attach = options.on_attach,
  capabilities = options.capabilities,
})
