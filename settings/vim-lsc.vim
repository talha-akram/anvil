""" vim-lsc configuration
if exists("g:LSC_configuration_loaded")
    finish
endif
let g:LSC_configuration_loaded = 1

let g:lsc_server_commands = {
    \ 'python': {
    \    'command': 'pyls',
    \    'workspace_config': {
    \        'clippy_preference': 'on',
    \        'python.linting.pylintEnabled': v:true,
    \        'python.linting.enabled': v:true,
    \        'python.linting.pydocstyleEnabled': v:true,
    \    },
    \  },
    \ 'javascript': "/home/talha/.config/nvim/plugins/javascript-typescript-langserver/lib/language-server-stdio.js",
    \ 'php': {
    \        'command': "/home/talha/.local/bin/php_ls_serenata.phar --uri=tcp://127.0.0.1:11111"
    \  }
    \}

let g:lsc_enable_snippet_support = v:true
let g:lsp_ultisnips_integration = 1
let g:lsc_enable_autocomplete = v:false

highlight lscDiagnosticError   ctermfg=203 guifg=#FF6E6E
highlight lscDiagnosticWarning ctermfg=215 guifg=#FFB86C
highlight lscDiagnosticHint    ctermfg=142 guifg=#ABB2BF
highlight lscDiagnosticInfo    ctermfg=228 guifg=#F1FA8C
highlight link lscReference         CursorColumn
highlight link lscCurrentParameter  CursorColumn

let g:lsc_auto_map = {
    \ 'GoToDefinition': '<Space>d',
    \ 'GoToDefinitionSplit': ['<Space><S-D>'],
    \ 'FindReferences': '<Space>r',
    \ 'NextReference': ']r',
    \ 'PreviousReference': '[r',
    \ 'FindImplementations': '<Space>i',
    \ 'FindCodeActions': '<Space>a',
    \ 'Rename': '<F2>',
    \ 'ShowHover': v:true,
    \ 'DocumentSymbol': '<Space>v',
    \ 'WorkspaceSymbol': '<Space><S-v>',
    \ 'SignatureHelp': '<Space>m',
    \ 'Completion': 'omnifunc',
    \}

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
    return LSCServerStatus()
endfunction

augroup exec_lsc_actions
    autocmd!
    " Update lightline on LSC diagnostic update
    autocmd User LSCDiagnosticsChange call lightline#update()
augroup end
