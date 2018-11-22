if !has('gui_running')
  finish
endif

" Don't focus the window when the mouse pointer is moved.
set nomousefocus

" Hide mouse pointer on insert mode.
set mousehide

" Disable visual tabs
set guioptions-=e

" Disable ALL scrollbars
set guioptions-=r
set guioptions-=L

" Use console dialogs instead of popups
set guioptions+=c

" Disable all blinking
set guicursor+=a:blinkon0

" Disable all the fucking beeps, bells and flashes, ALL THE FUCKING TIME!
set novisualbell
set t_vb=

source ~/.gvim/gtk2.vim
source ~/.gvim/macvim.vim
