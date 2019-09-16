""" NeoVim Options
if exists("g:custom_options_loaded")
  finish
endif
let g:custom_options_loaded = 1

" Use filetypes
filetype on
" Use plugins
filetype plugin indent on
" Dissable modelines
set nomodeline
" Restrict existing tab to width of 4 spaces
set tabstop=4
" Use 4 spaces for tabs
set shiftwidth=4
" Always expand tabs to spaces
set expandtab
" Show line numders
set number
" Highlight line containing the cursor
set cursorline
" But only the visual line, not the complete physical line (not supported yet)
" set cursorlineopt=screenline
" Enable mouse interaction
set mouse=a
" Use English dictionary
set spelllang=en_gb
" Hide buffers with unsaved changes without being prompted
set hidden
" Dissable Background Color Erase, filling background with current themes color
set t_ut=
" Auto-complete on tab, while in command mode
set wildmenu
" Ignore case when completing in command mode
set wildignorecase
" Donot use popup menu for completions in command mode
set wildoptions=tagfile
" Auto select the first entry but don't insert
set completeopt=noinsert,menuone,preview
" Stop popup menu messages (like: match 1 of 2, The only match etc.)
set shortmess+=c
" Use interactive replace
set inccommand=split
" Use interactive search
set incsearch
" Don't update screen while macro or command/script is executing
set lazyredraw
" Larger command input hight to better display messages
" set cmdheight=2
" Don't show mode as it is already displayrd in status line
set noshowmode
" Always show diagnostics column
set signcolumn=yes
" Minimum number of lines to keep before scrolling
set scrolloff=6
" Max number of items visible in popup menu
set pumheight=12
" Trigger CursorHold event if nothing is typed for the duration
set updatetime=1000
" Settings for better diffs
set diffopt=filler,vertical,hiddenoff,foldcolumn:0,algorithm:patience
" Show whitespace characters
set list
" Only show tabs and trailing spaces
set listchars=tab:▶-,trail:●,extends:◣,precedes:◢
" Default search is not case sensitive
set ignorecase
" Search will be case sensitive if uppercase character is entered
set smartcase
" Automatically Read changes made to file outside of Vim
set autoread
" Don't wrap long lines
set nowrap
" Tell neovim where to look for tags file
set tags=/tmp/tags
" Number of columns to scroll horizontally when cursor is moved off the screen
set sidescroll=5
" Minimum number of columns to keep towards the right of the cursor
set sidescrolloff=5
" Enable True Color support
if (has("termguicolors"))
  set termguicolors
endif
" Undotree settings
if has("persistent_undo")
    set undodir=~/.config/nvim/undodir/
    set undofile
endif
" dissable some features when running as Root
if exists('$SUDO_USER')
    set noswapfile
    set nobackup
    set nowritebackup
    set noundofile
    set viminfo=
endif
" Use ripgrep as the grep program
if executable("rg" )
    set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
endif
" Set up highlighting for trailing whitespace
highlight Whitespace    guifg=#6272A4   guibg=#282A36
" configure highlights for wild menu (command mode completions)
highlight StatusLine    guibg=#3E4452   ctermbg=240
highlight WildMenu      guifg=#50FA7B   guibg=#3E4452   ctermfg=76     ctermbg=240

