imap <A-Tab>     <Plug>(neosnippet_expand_or_jump)
smap <A-Tab>     <Plug>(neosnippet_expand_or_jump)
xmap <A-Tab>     <Plug>(neosnippet_expand_target)

imap <expr><TAB>
 \ pumvisible() ? "\<C-n>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#scope_aliases = {}
let g:neosnippet#scope_aliases['javascript'] = 'html,javascript'
let g:neosnippet#scope_aliases['javascriptreact'] = 'html,javascript'
