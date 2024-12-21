local options = require('configuration.lsp');
local filetypes = {
  'javascript',
  'javascriptreact',
  'javascript.jsx',
  'typescript',
  'typescriptreact',
  'typescript.tsx',
}

vim.lsp.start({
  name = 'quick-lint',
  cmd = { 'quick-lint-js', '--lsp-server' },
  filetypes = filetypes,
  root_dir = vim.fs.root(0, {'tsconfig.json', 'jsconfig.json', 'package.json', '.git'}),
  single_file_support = true,
  on_attach = options.on_attach,
  capabilities = options.capabilities,
})

vim.lsp.start({
  name = 'ts-ls',
  cmd = {'typescript-language-server', '--stdio'},
  filetypes = filetypes,
  root_dir = vim.fs.root(0, {'tsconfig.json', 'jsconfig.json', 'package.json', '.git'}),
  init_options = {hostInfo = 'neovim'},
  single_file_support = true,
  on_attach = options.on_attach,
  capabilities = options.capabilities,
})
