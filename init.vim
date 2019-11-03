set nocompatible

" Check if vim-plug is installed, if not then install it
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo "$HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
endif

colorscheme slate

" Only load plugins when not runing as root
if $USER != "root"
    call plug#begin('~/.config/nvim/plugins')
    " Color theme
    Plug 'dracula/vim', { 'as': 'dracula' }
    " To asks for the right file to open in case wrong name is used.
    Plug 'EinfachToll/DidYouMean'
    " Visualise and control undo history in tree form.
    Plug 'mbbill/undotree'
    " Comment/Uncomment blocks of code see keybindings to get started.
    Plug 'tpope/vim-commentary'
    " Quick open/fuzzy find files (and more!) see plugin settings: fzf.vim.
    Plug 'junegunn/fzf.vim'
    " Nice highly configurable lightweight status line.
    Plug 'itchyny/lightline.vim'
    " For when there is a need to visualy browse files inside of neovim.
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

    " Use LanguageClient-neovim for completions
    Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}

    " JavaScript/TypeScript language server for LanguageClient-neovim
    Plug 'sourcegraph/javascript-typescript-langserver', {'do': 'yarn install; yarn build'}

    Plug 'ncm2/ncm2'
    Plug 'roxma/nvim-yarp'
    Plug 'ncm2/ncm2-ultisnips'

    " Snippet support
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    call plug#end()

    colorscheme dracula

    """ PLUGIN SETTINGS
    " Configure plugins, plugin specific functions and autocommands are to be
    " written in the corresponding files (makes debuging and trying out
    " plugins easier)
    source ~/.config/nvim/settings/lightline.vim
    source ~/.config/nvim/settings/NERDTree.vim
    source ~/.config/nvim/settings/LanguageClient-neovim.vim
    source ~/.config/nvim/settings/ncm2.vim
    source ~/.config/nvim/settings/UltiSnips.vim
endif

" Set Vim Options
source ~/.config/nvim/startup/Options.vim
" Enable autocommands
source ~/.config/nvim/startup/AutoCommands.vim
" Setup keybindings
source ~/.config/nvim/startup/Keybindings.vim
" Load functions
source ~/.config/nvim/startup/Functions.vim

