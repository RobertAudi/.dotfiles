" Plugin: vim-auto-cursorline
" Description: Show / hide cursorline automatically
" URL: https://github.com/delphinus/vim-auto-cursorline

let g:auto_cursorline_wait_ms = 1200

autocmd FileType nerdtree :let b:auto_cursorline_disabled = 1
