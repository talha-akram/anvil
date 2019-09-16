""" nerdtree plugin settings
if exists("g:nerdtree_configuration_loaded")
    finish
endif
let g:nerdtree_configuration_loaded = 1

" Netrw setup to open (if active and envoked) to the side like NerdTree
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
" Dissable netrw plugins
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1

" Set NERDTree to hijack netrw
let NERDTreeHijackNetrw=1

