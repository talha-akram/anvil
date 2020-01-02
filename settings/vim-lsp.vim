""" vim-lsc configuration
if exists("g:vim_lsp_configuration_loaded")
    finish
endif
let g:vim_lsp_configuration_loaded = 1

" Dracula color theme based highlighting
highlight LspErrorText         ctermfg=203 guifg=#FF6E6E
highlight LspWarningText       ctermfg=215 guifg=#FFB86C
highlight LspHintText          ctermfg=142 guifg=#ABB2BF
highlight LspInformationText   ctermfg=239 guifg=#44475A

highlight lspDiagnosticError    ctermfg=203 guifg=#FF6E6E
highlight lspDiagnosticWarning  ctermfg=215 guifg=#FFB86C
highlight lspDiagnosticHint     ctermfg=142 guifg=#ABB2BF
highlight lspDiagnosticInfo     ctermfg=228 guifg=#F1FA8C

highlight link LspErrorLine        LspErrorText
highlight link LspWarningLine      LspWarningText
highlight link LspHintLine         LspHintText
highlight link LspInformationLine  LspInformationText

highlight link LspErrorHighlight        LspErrorText
highlight link LspWarningHighlight      LspWarningText
highlight link LspHintHighlight         LspHintText
highlight link LspInformationHighlight  LspInformationText

highlight link lspReference             CursorColumn

set foldmethod=expr
  \ foldexpr=lsp#ui#vim#folding#foldexpr()
  \ foldtext=lsp#ui#vim#folding#foldtext()

let g:lsp_highlight_references_enabled = 1
let g:lsp_virtual_text_enabled = 1
let g:lsp_highlights_enabled = 1
let g:lsp_textprop_enabled = 1
let g:lsp_auto_enable = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_enabled = 1
let g:lsp_preview_float = 1
let g:lsp_fold_enabled = 0
let g:lsp_virtual_text_prefix = "    ••➜ "

function! SetupVimLSP() abort
    if has_key(g:LanguageClient_serverCommands, &filetype)
        " 'SignatureHelp': '<Space>m',
        " 'Completion': 'omnifunc',
        nnoremap <silent> <Leader>a     :LspCodeAction<CR>
        nnoremap <silent> <Leader>j     :LspDeclaration<CR>
        nnoremap <silent> <Leader>d     :LspPeekDefinition<CR>
        nnoremap <silent> <Leader><S-d> :LspDefinition<CR>
        nnoremap <silent> <Leader>r     :LspReferences<CR>
        nnoremap <silent> <Leader>i     :LspImplementation<CR>
        nnoremap <silent> <Leader>m     :LspTypeDefinition<CR>
        nnoremap <silent> <Leader>v     :LspDocumentSymbol<CR>
        nnoremap <silent> <Leader><S-v> :LspWorkspaceSymbol<CR>
        nnoremap <silent> <Leader>k     :LspPeekDeclaration<CR>
        nnoremap <silent> <Leader>h     :LspHover<CR>
        nnoremap <silent> <Leader>[     :LspPreviousError<CR>
        nnoremap <silent> <Leader>]     :LspNextError<CR>
        nnoremap <silent> [r            :LspPreviousReference<CR>
        nnoremap <silent> ]r            :LspNextReference<CR>
        nnoremap <silent> <F2>          :LspRename<CR>
        nnoremap <silent> <A-f>         :LspDocumentFormat<CR>
        nnoremap <silent> <C-Space>     :LspCodeAction<CR>
        nmap <C-F2> :call g:LanguageClient#textDocument_rename()<CR>
        set completefunc=LanguageClient#complete
    endif
endfunction


augroup enable_lsp_actions
    autocmd!
    autocmd FileType javascript,python call SetupVimLSP()
    autocmd FileType javascript,python setlocal omnifunc=lsp#complete
    autocmd User LanguageClientDiagnosticsChanged call lightline#update()
augroup end

" Diagnostic error messages count
function! LightlineErrors() abort
  let current_buf_number = bufnr('%')
  let qflist = getloclist(0)
  let current_buf_diagnostics = filter(qflist, {index, dict -> dict['bufnr'] == current_buf_number && dict['type'] == 'E'})
  let count = len(current_buf_diagnostics)
  return count > 0 ? 'E:' . count : ''
endfunction

" Diagnostic warning messages count
function! LightlineWarnings() abort
    let current_buf_number = bufnr('%')
    let qflist = getloclist(0)
    let current_buf_diagnostics = filter(qflist, {index, dict -> dict['bufnr'] == current_buf_number && dict['type'] == 'W'})
    let count = len(current_buf_diagnostics)
    return count > 0 ? 'W:' . count : ''
endfunction

" Diagnostic informational messages count
function! LightlineInfos() abort
    let current_buf_number = bufnr('%')
    let qflist = getloclist(0)
    let current_buf_diagnostics = filter(qflist, {index, dict -> dict['bufnr'] == current_buf_number && dict['type'] == 'I'})
    let count = len(current_buf_diagnostics)
    return count > 0 ? 'I:' . count : ''
endfunction

" Diagnostic hint's count
function! LightlineHints() abort
    let current_buf_number = bufnr('%')
    let qflist = getloclist(0)
    let current_buf_diagnostics = filter(qflist, {index, dict -> dict['bufnr'] == current_buf_number && dict['type'] == 'H'})
    let count = len(current_buf_diagnostics)
    return count > 0 ? 'H:' . count : ''
endfunction

" Language Server Status
function! LightlineStatus() abort
    return ""
endfunction
