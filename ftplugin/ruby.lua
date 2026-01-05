local options = require('configuration.lsp')

if (vim.fn.executable('ruby-lsp') == 1) then
  vim.lsp.start({
    name = 'ruby-lsp',
    filetypes = {'ruby', 'eruby'},
    cmd = {'ruby-lsp'},
    root_dir = vim.fs.root(0, {'Gemfile', 'Gemfile.lock'}),
    on_attach = options.on_attach,
    capabilities = options.capabilities,
  })
elseif (vim.fn.executable('rubocop') == 1) then
  vim.lsp.start({
    name = 'rubocop',
    filetypes = {'ruby', 'eruby'},
    cmd = {'bundle', 'exec', 'rubocop', '--lsp'},
    root_dir = vim.fs.root(0, {'Gemfile', 'Gemfile.lock'}),
    root_dir = vim.fs.root(0, {'.rubocop.yml', '.git'}),
    on_attach = options.on_attach,
    capabilities = options.capabilities,
  })
end
