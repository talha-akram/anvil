local options = require('configuration.lsp')

if (vim.fn.executable('coffeesense') == 1) then
  vim.lsp.start({
    name = 'coffeesense',
    cmd = {'coffeesense-language-server', '--stdio'},
    filetypes = {'*.coffee', 'coffeescript', 'vue'},
    root_dir = vim.fs.root(0, {'package.json', '.git'}),
    single_file_support = true,
    on_attach = options.on_attach,
    capabilities = options.capabilities,
  })
end
