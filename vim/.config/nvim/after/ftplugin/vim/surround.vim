" Plugin: vim-surround
" Description: Quoting/parenthesizing made simple
" URL: https://github.com/tpope/vim-surround

let b:surround_{char2nr('i')} = "if \1if: \1 \r endif"
let b:surround_{char2nr('T')} = "try \r endtry"
