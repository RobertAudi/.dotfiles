" Plugin: vim-auto-cursorline
" Description: Show / hide cursorline automatically
" URL: https://github.com/delphinus/vim-auto-cursorline

let g:auto_cursorline_wait_ms = 1200

augroup RAPluginsVimAutoCursoline
  autocmd!

  autocmd FileType NvimTree,vista,TelescopePrompt,TelescopeResults,floaterm,gitblame,git,ctrlsf
        \ :let b:auto_cursorline_disabled = 1
augroup END
