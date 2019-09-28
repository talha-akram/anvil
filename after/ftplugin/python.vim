" Additions to Vim's filetype plugin for Python, to use custome
" compiler for python files (run unit tests and populate quickfix)
" Set the compiler

if !exists("current_compiler")
  compiler python
endif

" Use black to format python code
setlocal formatprg=black\ --quiet\ -\ 2>\ /dev/null
" Use indent level as fold markers
setlocal foldmethod=indent
" Only fold up to method level
setlocal foldnestmax=2
" Don't  fold docstrings
setlocal foldignore=\"\"\"


" Rest of the changes have been moved to the compiler file
" Find: ~/.config/nvim/compiler/python.vim
" setlocal makeprg=python\ -m\ unittest
