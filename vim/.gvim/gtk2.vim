if !has('gui_running') && !(has('gui_gtk') && has('gui_gtk2'))
  finish
endif

set guifont=Input\ 11

" Disable the menu bar
set guioptions-=m
set guioptions-=g

" Disable the Toolbar
set guioptions-=T
set guioptions-=t