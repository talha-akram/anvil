""" LanguageClient-neovim configuration
if exists("g:UltiSnips_configuration_loaded")
    finish
endif
let g:UltiSnips_configuration_loaded = 1

let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/snippets']
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"
