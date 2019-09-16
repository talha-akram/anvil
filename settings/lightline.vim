""" LightLine settings
if exists("g:lightline_configuration_loaded")
    finish
endif
let g:lightline_configuration_loaded = 1

let g:lightline = {}

let g:lightline.active = {
    \ 'left': [ [ 'mode', 'paste' ],
    \           [ 'filestate' ],
    \           [ 'error', 'warning', 'info', 'hint', 'fix' ],
    \           [ 'leftbfrs', 'currentbfr', 'rightbfrs' ] ],
    \ 'right': [ [ 'lineinfo' ],
    \            [ 'percent' ],
    \            [ 'filetype', 'fileformat', 'fileencoding' ],
    \            [ 'status' ],
    \            [ 'collapse' ] ] }

let g:lightline.inactive = {
    \ 'left': [ [ 'filestate' ] ],
    \ 'right': [ [ 'lineinfo' ],
    \            [ 'percent' ] ] }

let g:lightline.tabline = {
    \ 'left': [ [ 'tabs' ] ],
    \ 'right': [] }

let g:lightline.component = {
    \ 'percent'     : '--%1p%%--',
    \ 'collapse'    : '%<' }

let g:lightline.component_function = {
    \ 'status'      : 'LightlineStatus',
    \ 'filestate'   : 'LightlineFileState' }

let g:lightline.component_expand = {
    \ 'error'       : 'LightlineErrors',
    \ 'warning'     : 'LightlineWarnings',
    \ 'info'        : 'LightlineInfos',
    \ 'hint'        : 'LightlineHints',
    \ 'fix'         : 'LightlineFixes',
    \ 'leftbfrs'    : 'LightlineBuffersPrev',
    \ 'currentbfr'  : 'LightlineCurrentBuffer',
    \ 'rightbfrs'   : 'LightlineBuffersNext' }

let g:lightline.component_type = {
    \ 'error'       : 'error',
    \ 'warning'     : 'warning',
    \ 'info'        : 'info',
    \ 'hint'        : 'middle',
    \ 'fix'         : 'middle',
    \ 'leftbfrs'    : 'inactive',
    \ 'currentbfr'  : 'active',
    \ 'rightbfrs'   : 'inactive' }

let g:lightline.mode_map = {
    \ 'n'           : 'N',
    \ 'i'           : 'I',
    \ 'R'           : 'R',
    \ 'v'           : 'V',
    \ 'V'           : 'V-L',
    \ "\<C-v>"      : 'V-B',
    \ 'c'           : 'C',
    \ 's'           : 'S',
    \ 'S'           : 'S-L',
    \ "\<C-s>"      : 'S-B',
    \ 't'           : 'T' }

let g:lightline.colorscheme = 'functional'

function! LightlineBuffersPrev() abort
    let bfrs = ''
    for nr in range(1, bufnr('$'))
        if nr == bufnr('')
            return trim(bfrs)
        endif
        if (buflisted(nr) == 1)
            let bfrs = bfrs . nr . '  '
        endif
    endfor
    return ''
endfunction

function! LightlineCurrentBuffer() abort
    return bufnr('')
endfunction

function! LightlineBuffersNext() abort
    let bfrcnt = bufnr('$')
    let bfrs = ''
    for nr in range(bufnr('$'), 1, -1)
        if nr == bufnr('')
            return trim(bfrs)
        endif
        if (buflisted(nr) == 1)
            let bfrs = nr . '  ' . bfrs
        endif
    endfor
    return ''
endfunction

function! LightlineFileState() abort
    let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
    let md = &modified ? ' +' : ''
    let ro = &readonly ? ' -' : ''
    return filename . md . ro
endfunction


