""" ncm2 plugin settings
if exists("g:ncm2_configuration_loaded")
    finish
endif
let g:ncm2_configuration_loaded = 1

let g:ncm2#auto_popup = 0
let g:ncm2#manual_complete_length = 1
inoremap <C-Space> <c-r>=ncm2#manual_trigger()<cr>

augroup enable_ncm2
    autocmd FileType python call ncm2#enable_for_buffer()
augroup end
