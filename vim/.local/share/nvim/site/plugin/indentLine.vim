" Plugin: indentLine
" Description: A vim plugin to display the indention levels with thin vertical lines
" URL: https://github.com/Yggdroot/indentLine

let g:indentLine_leadingSpaceEnabled = 0
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_first_char = '│'
let g:indentLine_char = '│'

augroup RAPluginsIndentLine
  autocmd!

  " Disable indentLine in special buffers
  autocmd BufEnter NERD_tree_\d\+\|__vista__ let b:indentLine_enabled = 0
augroup END
