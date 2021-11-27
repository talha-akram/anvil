""" Auto commands use sparingly, having auto commands that trigger often will
""" slow down nvim

" Limit file from being sourced multiple times
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

" Use vertical splits for help windows
augroup vertical_help
    autocmd!
    autocmd FileType help wincmd L
augroup END

" Auto Populate loclist with table of content in manpages
augroup man_toc
    autocmd!
    autocmd FileType man normal gO
    autocmd FileType man lclose
augroup END

" Trim whitespapes for specified file types upon write
" augroup trim_white_space
"     autocmd!
"     autocmd FileType vim,c,cpp,css,java,php,javascript,python autocmd BufWritePre <buffer> %s/\s\+$//e
" augroup END

