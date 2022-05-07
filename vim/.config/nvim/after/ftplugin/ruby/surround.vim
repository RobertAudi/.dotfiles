" Plugin: vim-surround
" Description: Quoting/parenthesizing made simple
" URL: https://github.com/tpope/vim-surround

let b:surround_{char2nr('#')} = "#{\r}"
let b:surround_{char2nr('i')} = "if \1if: \1 \r end"
let b:surround_{char2nr('u')} = "unless \1unless: \1 \r end"
let b:surround_{char2nr('m')} = "module \1module: \1 \r end"

let b:surround_indent = 1
