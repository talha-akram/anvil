local options = require('configuration.lsp');

if (vim.fn.executable('vls') == 1) then
  vim.lsp.start({
    name = 'vuels',
    cmd = {'vls'},
    filetypes = {'vue'},
    root_dir = vim.fs.root(0, {'package.json', 'vue.config.js'}),
    init_options = {
      config = {
        vetur = {
          useWorkspaceDependencies = false,
          validation = {
            template = true,
            style = true,
            script = true,
          },
          completion = {
            autoImport = false,
            useScaffoldSnippets = false,
            tagCasing = 'kebab',
          },
          format = {
            defaultFormatter = {
              js = 'none',
              ts = 'none',
            },
            defaultFormatterOptions = {},
            scriptInitialIndent = false,
            styleInitialIndent = false,
          },
        },
        css = {},
        html = {
          suggest = {},
        },
        javascript = {
          format = {},
        },
        typescript = {
          format = {},
        },
        emmet = {},
        stylusSupremacy = {},
      },
    },
    on_attach = options.on_attach,
    capabilities = options.capabilities,
  })
end
