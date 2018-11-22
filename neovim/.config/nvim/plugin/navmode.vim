" fcpg/vim-navmode
" ------------------------------------------------------------------------------
command! -nargs=0 Navmode call Navmode()
call abolish#commands('Navmode', 'Nav', 'nav', 'navmode')
