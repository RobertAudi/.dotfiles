" t9md/vim-choosewin
" ------------------------------------------------------------------------------
nmap + <Plug>(choosewin)

let g:choosewin_overlay_enable = 0
let g:choosewin_blink_on_land  = 0
let g:choosewin_return_on_single_win = 1

let s:ignore_filtype = ['nerdtree']

let g:choosewin_hook = {}
function! g:choosewin_hook.filter_window(winnums)
  return filter(a:winnums, "index(s:ignore_filtype, getwinvar(v:val, '&filetype')) == -1")
endfunction
