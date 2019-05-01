" Plugin: vim-choosewin
" Description: Land on window you chose like tmux's 'display-pane'
" URL: https://github.com/t9md/vim-choosewin

nmap <C-w>/ <Plug>(choosewin)

let g:choosewin_overlay_enable = 0
let g:choosewin_blink_on_land  = 0
let g:choosewin_return_on_single_win = 1
