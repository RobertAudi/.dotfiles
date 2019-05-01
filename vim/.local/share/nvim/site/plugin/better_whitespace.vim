" Plugin: vim-better-whitespace
" Description: Better whitespace highlighting for Vim
" URL: https://github.com/ntpeters/vim-better-whitespace

let g:strip_whitespace_on_save = 0
let g:better_whitespace_filetypes_blacklist =
      \ [
      \   'help',
      \   'qf',
      \   'man',
      \   'ctrlsf',
      \   'nerdtree',
      \   'vim-plug',
      \   'diff',
      \   'gitcommit',
      \   'gitrebase'
      \ ]
