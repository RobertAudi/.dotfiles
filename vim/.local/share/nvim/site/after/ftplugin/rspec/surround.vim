" Plugin: vim-surround
" Description: Quoting/parenthesizing made simple
" URL: https://github.com/tpope/vim-surround

let b:surround_{char2nr('#')} = "#{\r}"
let b:surround_{char2nr('d')} = "describe do \r end"
let b:surround_{char2nr('c')} = "context do \r end"

let b:surround_indent = 1
