" Plugin: vim-marked
" Description: Open the current Markdown buffer in Marked.app
" URL: https://github.com/itspriddle/vim-marked

if has('gui_vimr')
  nnoremap <buffer> <D-p> <Cmd>MarkedOpen<CR>
endif
