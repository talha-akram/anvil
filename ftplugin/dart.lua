local options = require('configuration.lsp');

vim.lsp.start({
  name = 'dartls',
  filetypes = {'dart'},
  cmd = {'dart', 'language-server', '--protocol=lsp'},
  root_dir = vim.fs.root(0, {'pubspec.yaml', '.git'}),
  init_options = {
    onlyAnalyzeProjectsWithOpenFiles = true,
    suggestFromUnimportedLibraries = true,
    closingLabels = true,
    outline = true,
    flutterOutline = true,
  },
  settings = {
    dart = {
      completeFunctionCalls = true,
      showTodos = true,
    },
  },
  on_attach = options.on_attach,
  capabilities = options.capabilities,
})

-- set comment string for dart files
vim.bo.commentstring = '// %s'
