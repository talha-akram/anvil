""" vim_clap configuration
if exists("g:vim_clap_configuration_loaded")
    finish
endif
let g:vim_clap_configuration_loaded = 1

let g:clap_search_box_border_symbols = {
    \ 'arrow': ["\ue0b2", "\ue0b0"],
    \ 'curve': ["\ue0b6", "\ue0b4"],
    \ 'nil': ['', '']
    \ }

let g:clap_spinner_frames = ['⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏']
