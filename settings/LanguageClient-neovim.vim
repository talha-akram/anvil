""" LanguageClient-neovim configuration
if exists("g:languageclient_configuration_loaded")
    finish
endif
let g:languageclient_configuration_loaded = 1

" For debugging LacnguageClient issues
" let g:LanguageClient_loggingFile = '/tmp/LC-vim.log'
" let g:LanguageClient_loggingLevel = 'DEBUG'

" Stop annoying diagnostics sign popups, use virtual text with prefix instead
let g:LanguageClient_diagnosticsSignsMax = 0
let g:LanguageClient_hasSnippetSupport = 1
let g:LanguageClient_useFloatingHover = 1
let g:LanguageClient_useVirtualText = 1
let g:LanguageClient_hasSnippetSupport = 1
let g:LanguageClient_changeThrottle = 0.5
let g:LanguageClient_virtualTextPrefix = "    ••➜ "
let g:LanguageClient_diagnosticsList = "Location"
let g:LanguageClient_selectionUI = "location-list"
let g:LanguageClient_hoverpreview = "Always"
" Share Language Server config between vscode and neovim
let g:LanguageClient_settingsPath = $WORKSPACE_DIR . "/.vscode/settings.json"

" Custom color highlight for virtual text
highlight LCErrorHighlight  ctermfg=203 guifg=#FF6E6E
highlight LCWarnHighlight   ctermfg=215 guifg=#FFB86C
highlight LCHintHighlight   ctermfg=142 guifg=#ABB2BF
highlight LCInfoHighlight   ctermfg=239 guifg=#44475A

let g:LanguageClient_serverCommands = {
    \     "typescript": ["~/.config/nvim/plugins/javascript-typescript-langserver/lib/language-server-stdio.js"],
    \     "javascript": ["~/.config/nvim/plugins/javascript-typescript-langserver/lib/language-server-stdio.js"],
    \     "javascript.jsx": ["~/.config/nvim/plugins/javascript-typescript-langserver/lib/language-server-stdio.js"],
    \     "python": ["pyls"],
    \ }
let g:LanguageClient_diagnosticsDisplay = {
    \      1: {
    \          "name": "Error",
    \          "texthl": "Underline",
    \          "signText": "✗",
    \          "signTexthl": "LCErrorHighlight",
    \          "virtualTexthl": "LCErrorHighlight",
    \      },
    \      2: {
    \          "name": "Warning",
    \          "texthl": "",
    \          "signText": "‼",
    \          "signTexthl": "LCWarnHighlight",
    \          "virtualTexthl": "LCWarnHighlight",
    \      },
    \      3: {
    \          "name": "Information",
    \          "texthl": "",
    \          "signText": "‽",
    \          "signTexthl": "LCInfoHighlight",
    \          "virtualTexthl": "LCInfoHighlight",
    \      },
    \      4: {
    \          "name": "Hint",
    \          "texthl": "",
    \          "signText": "»",
    \          "signTexthl": "LCHintHighlight",
    \          "virtualTexthl": "LCHinthighlight",
    \      }
    \  }

" Use language server (LS) when avaible
function! LanguageClientMaps()
    if has_key(g:LanguageClient_serverCommands, &filetype)
        nnoremap <silent> <Leader>k :call LanguageClient#textDocument_hover()<CR>
        nnoremap <silent> <Leader>j :call LanguageClient#textDocument_definition()<CR>
        nnoremap <silent> <Leader>r :call LanguageClient#textDocument_references()<CR>
        nnoremap <silent> <F2>      :call LanguageClient#textDocument_rename()<CR>
        set completefunc=LanguageClient#complete
        " set formatexpr=LanguageClient#textDocument_rangeFormatting_sync()
        nmap <C-F2> :call g:LanguageClient#textDocument_rename()<CR>
        nnoremap <C-Space> :call g:LanguageClient_contextMenu()<CR>
    endif
endfunction

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
    return g:LanguageClient#serverStatusMessage()
    " return LanguageClient#serverStatus() == 0 ? 'LS:Idle' : 'LS:Busy'
endfunction

" Bindings for LanguageClient-neovim
augroup bind_ls_actions
    autocmd!
    " Use language server with supported file types
    autocmd FileType javascript,python call LanguageClientMaps()
    autocmd FileType javascript,python setlocal omnifunc=LanguageClient#complete
    " Update lightline on LC diagnostic update
    autocmd User LanguageClientDiagnosticsChanged call lightline#update()
augroup end

