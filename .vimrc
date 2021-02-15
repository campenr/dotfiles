set nocompatible              "  be iMproved, required


"""""""""""
" Plugins "
"""""""""""

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

" general awesomeness
Plugin 'tpope/vim-fugitive'
Plugin 'preservim/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'

" themeing
Plugin 'notpratheek/vim-luna'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'


call vundle#end()
filetype plugin indent on


set number                    "  show numbers
set relativenumber            "  and have numbers relative to current position
set autoread                  "  detect when a file has changed
set tabstop=4                 "  tabs are four spaces
set expandtab                 "  no really.
set shiftwidth=4              "  so are shifts
set showmatch                 "  highlight matching parentheses etc.

"""""""""""
" Airline "
"""""""""""

set t_Co=256
let g:airline_powerline_fonts = 1
let g:airline_theme='luna'

"""""""""
" CtrlP "
"""""""""

" remove limit on how many files to search against
let g:ctrlp_max_files=0
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|__pycache__'


""""""""""""
" NERDTree "
""""""""""""

" Start NERDTree. If a file is specified, move the cursor to its window.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" If another buffer tries to replace NERDTree, put it in the other window, and  bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 | let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

