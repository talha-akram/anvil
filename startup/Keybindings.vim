""" Key maps/bindings that are plugin independent
if exists("g:custom_keymaps_loaded")
  finish
endif
let g:custom_keymaps_loaded = 1

" Set Space as the leader key
let mapleader = "\<Space>"

" Use semicolon to enter command mode
nmap ;          :

nmap <Leader>l  :lli<CR>
nmap <Leader>q  :cli<CR>
nmap <Leader>s  :%s/\s\+$//e<CR>
nmap <Leader>t  :!ctags -R /tmp/tags<CR>

nmap <A-q>      :cope<CR>
nmap <A-l>      :lope<CR>

" For essential Plugins
nmap <Leader>b  :Bu<CR>
nmap <Leader>o  :FZF<CR>
nmap <Leader>f  :Rg<CR>
nmap <F8>       :UndotreeToggle<CR>
nmap <F9>       :NERDTreeToggle<CR>

" Write changes to file
nmap ,w         :w<CR>
" Delete current buffer, (keep window splits)
nmap ,d         :bp\|bd #<CR>
" Exit current window
nmap ,c         :q<CR>
" Close Quickfix list
nmap ,q         :ccl<CR>
" Close Location list
nmap ,l         :lcl<CR>
" Copy to & paste from system clipboard
vmap ,y      "+y
map  ,p      "+p

" Fast * list navigation, inspired by tpope/vim-unimpaired
" [ / ] -> previous / next, Uppercase Modifier -> First / Last
" Quickfix list navigation:
nmap [q         :cpr<CR>
nmap ]q         :cnex<CR>
nmap [Q         :cfir<CR>
nmap ]Q         :cla<CR>
" Location list navigation
nmap [l         :lpr<CR>
nmap ]l         :lne<CR>
nmap [L         :lfir<CR>
nmap ]L         :lla<CR>
" Buffer list navigation
nmap [b         :bp<CR>
nmap ]b         :bn<CR>
nmap [B         :bf<CR>
nmap ]B         :bl<CR>

" use h, j, k & l instead
nmap <UP>       <NOP>
nmap <DOWN>     <NOP>
nmap <LEFT>     <NOP>
nmap <RIGHT>    <NOP>

" Clear search highlighting
nmap <F7>       :nohlsearch<CR>
" Yank current line to system clipboard
nmap <F10>      "+yy
" Exit (n)vim
map  <F11>      :qa<CR>
" Write all changes made to open files
map  <F12>      :wa<CR>

" Use ctrl+space for omnifunc
imap <C-Space> <C-X><C-O>

" Bind Ctrl+/ for commenting/uncommenting
map  <C-_>      gc

" Use alt modifier for scrolling buffer
map  <A-j>      <C-E>
map  <A-k>      <C-Y>

" Move vertically by visual line
nnoremap j      gj
nnoremap k      gk

" Keep current search result centered on the screen
nnoremap n      nzz
nnoremap N      Nzz

" Use q to close help
nnoremap <expr> q (&filetype == 'help' ? ":q\<CR>" : "q")

" Close popup menu and compensate cursor shifting one place left
inoremap <expr> <Esc> (pumvisible() ? "\<Esc>i\<Right>" : "\<Right>\<Esc>")
inoremap <expr> <CR> (pumvisible() ? "\<C-Y>" : "\<CR>")

" Use <C-w> to move between terminal buffer and other buffers
tnoremap <C-w> <C-\><C-n><C-w>

" Use <Leader><Esc> to exit insert mode in terminal buffers
tnoremap <silent> <Leader><C-[> <C-\><C-n>
