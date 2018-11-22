let g:commentary_map_backslash = 0
nmap gx gccyypgcc
xmap <silent> gx y<C-o>Pgvgcgv<Esc>j^
xmap <silent> gX ypgvgc2<C-o>^

if has('gui_running') && has('gui_macvim')
  nmap <D-/> gcc
  imap <D-/> <C-o>gcc
  vmap <D-/> gc
endif
