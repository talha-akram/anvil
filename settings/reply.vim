""" Reply configuration
if exists("g:reply_configuration_loaded")
    finish
endif
let g:reply_configuration_loaded = 1

nmap <Plug>(repl_start) <Space>e
nmap <Plug>(repl_quit) <Space>x
nnoremap <Space>e :Repl<Cr>
vnoremap <Space>e :ReplSend<Cr>
" nnoremap <Space> :ReplStop<Cr>
