""" Auto commands
if exists("g:custom_autocmds_loaded")
  finish
endif
let g:custom_autocmds_loaded = 1

" Highlight current line on active window only
augroup line_highlight
    autocmd!
    autocmd WinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END
" Use vertical splits
augroup vertical_help
    autocmd!
    autocmd FileType help wincmd L
augroup END
" Trim whitespapes for specified file types upon write
" augroup trim_white_space
"     autocmd!
"     autocmd FileType vim,c,cpp,css,java,php,javascript,python autocmd BufWritePre <buffer> %s/\s\+$//e
" augroup END

