""" built in nvim LSP configuration
if exists("g:nvim_LSP_configuration_loaded")
    finish
endif
let g:nvim_LSP_configuration_loaded = 1

" use the defaults from the LS
lua << EOF
  local nvim_lsp = require('nvim_lsp')
  nvim_lsp.pyls.setup(nvim_lsp.pyls.template_config.default_config)
EOF

let settings = {
      \   "pyls" : {
      \     "enable" : v:true,
      \     "trace" : { "server" : "verbose", },
      \     "commandPath" : "",
      \     "configurationSources" : [ "pycodestyle" ],
      \     "plugins" : {
      \       "jedi_completion" : { "enabled" : v:true, },
      \       "jedi_hover" : { "enabled" : v:true, },
      \       "jedi_references" : { "enabled" : v:true, },
      \       "jedi_signature_help" : { "enabled" : v:true, },
      \       "jedi_symbols" : {
      \         "enabled" : v:true,
      \         "all_scopes" : v:true,
      \       },
      \       "mccabe" : {
      \         "enabled" : v:true,
      \         "threshold" : 15,
      \       },
      \       "preload" : { "enabled" : v:true, },
      \       "pycodestyle" : { "enabled" : v:true, },
      \       "pydocstyle" : {
      \         "enabled" : v:false,
      \         "match" : "(?!test_).*\\.py",
      \         "matchDir" : "[^\\.].*",
      \       },
      \       "pyflakes" : { "enabled" : v:true, },
      \       "rope_completion" : { "enabled" : v:true, },
      \       "yapf" : { "enabled" : v:true, },
      \     }}}
call nvim_lsp#setup("pyls", settings)
set omnifunc=lsp#omnifunc
