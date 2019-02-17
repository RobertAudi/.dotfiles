" Plugin: vim-navmode
" Description: Navigation mode for Vim
" URL: https://github.com/fcpg/vim-navmode

command! -nargs=0 Navmode call Navmode()

call x2a#abolish#commands('Navmode', 'Nav', 'nav', 'navmode')
