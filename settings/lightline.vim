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

let s:fg     = [ '#abb2bf', 142 ]
let s:blue   = [ '#61afef', 75  ]
let s:green  = [ '#50fa7b', 76  ]
let s:purple = [ '#bd93f9', 176 ]
let s:red    = [ '#ff5555', 168 ]
let s:pink   = [ '#ff79c6', 168 ]
let s:orange = [ '#ffb86c', 168 ]
let s:yellow = [ '#f1fa8c', 180 ]
let s:bg     = [ '#282c34', 235 ]
let s:gray1  = [ '#5c6370', 241 ]
let s:gray2  = [ '#2c323d', 235 ]
let s:gray3  = [ '#3e4452', 240 ]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

let s:p.normal.left     = [ [ s:green,  s:gray2, 'bold' ], [ s:fg, s:gray3 ] ]
let s:p.normal.right    = [ [ s:green,  s:gray2, 'bold' ], [ s:fg, s:gray3 ], [ s:green,  s:bg ] ]
let s:p.normal.error    = [ [ s:red,    s:bg,    'bold' ] ]
let s:p.normal.warning  = [ [ s:orange, s:bg    ] ]
let s:p.normal.info     = [ [ s:yellow, s:bg    ] ]
let s:p.normal.middle   = [ [ s:fg,     s:bg    ] ]
let s:p.normal.inactive = [ [ s:gray1,  s:bg    ] ]
let s:p.normal.active   = [ [ s:blue,   s:gray2 ] ]
let s:p.insert.left     = [ [ s:blue,   s:gray2, 'bold' ], [ s:fg, s:gray3 ] ]
let s:p.insert.right    = [ [ s:blue,   s:gray2, 'bold' ], [ s:fg, s:gray3 ], [ s:blue,   s:bg ] ]
let s:p.replace.left    = [ [ s:orange, s:gray2, 'bold' ], [ s:fg, s:gray3 ] ]
let s:p.replace.right   = [ [ s:orange, s:gray2, 'bold' ], [ s:fg, s:gray3 ], [ s:orange, s:bg ] ]
let s:p.visual.left     = [ [ s:purple, s:gray2, 'bold' ], [ s:fg, s:gray3 ] ]
let s:p.visual.right    = [ [ s:purple, s:gray2, 'bold' ], [ s:fg, s:gray3 ], [ s:purple, s:bg ] ]
let s:p.inactive.left   = [ [ s:gray1,  s:bg    ] ]
let s:p.inactive.middle = [ [ s:gray1,  s:bg    ] ]
let s:p.inactive.right  = [ [ s:gray1,  s:bg    ] ]

let g:lightline#colorscheme#anvil#palette = lightline#colorscheme#flatten(s:p)
let g:lightline.colorscheme = 'anvil'

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

