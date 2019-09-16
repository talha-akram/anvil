""" coc plugin settings
if exists("g:coc_configuration_loaded")
    finish
endif
let g:coc_configuration_loaded = 1

let g:suppress_coc_lightline_diagnostics = 0
" let g:suppress_lightline_coc_info_diagnostics = 1

" Highlight symbol under cursor on CursorHold
augroup coc_symbol_highlight
    autocmd!
    autocmd CursorHold * silent call CocActionAsync('highlight')
    autocmd User CocDiagnosticChange call lightline#update()
augroup END

" Look up documentation for word under cursor
nmap <Leader>k :call <SID>cocAction('doHover')<CR>

" Use <C-Space> to trigger completion.
inoremap <silent><expr> <C-Space> coc#refresh()

" Make coc highlighting less obnoxious
highlight CocErrorSign      ctermfg=203 guifg=#FF6E6E
highlight CocWarningSign    ctermfg=215 guifg=#FFB86C
highlight CocHintSign       ctermfg=142 guifg=#ABB2BF
highlight CocInfoSign       ctermfg=239 guifg=#44475A
highlight CocHighlightRead  ctermbg=0   guibg=#1F1F1F
highlight CocHighlightWrite ctermbg=0   guibg=#1F1F1F

" highlight link CocErrorHighlight    NONE
highlight link CocWarningHighlight  NONE
highlight link CocInfoHighlight     NONE
highlight link CocHintHighligh      NONE

" Use K to show documentation in preview window
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

function! s:lightline_coc_diagnostic(kind, sign) abort
    if g:suppress_coc_lightline_diagnostics == 1
        return ''
    endif
    let info = get(b:, 'coc_diagnostic_info', 0)
    if empty(info) || get(info, a:kind, 0) == 0
        return ''
    endif
    return printf('%s%d', a:sign, info[a:kind])
endfunction
" Diagnostic error messages count
function! LightlineErrors() abort
    return s:lightline_coc_diagnostic('error', 'E')
endfunction

" Diagnostic warning messages count
function! LightlineWarnings() abort
    return s:lightline_coc_diagnostic('warning', 'W')
endfunction

" Diagnostic informational messages count
function! LightlineInfos() abort
    " if g:suppress_lightline_coc_info_diagnostics == 1
    "     return ''
    " endif
    return s:lightline_coc_diagnostic('information', 'I')
endfunction

" Diagnostic hint's count
function! LightlineHints() abort
    return s:lightline_coc_diagnostic('hints', 'H')
endfunction

" Language Server Status
function! LightlineStatus() abort
    let ft = &filetype
    if (ft != 'python')
        return ' '
    endif
    return get(g:, 'coc_status', '')
endfunction

