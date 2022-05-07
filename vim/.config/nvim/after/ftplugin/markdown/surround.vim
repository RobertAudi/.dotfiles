" Plugin: vim-surround
" Description: Quoting/parenthesizing made simple
" URL: https://github.com/tpope/vim-surround

let b:surround_{char2nr('*')} = "*\r*"
let b:surround_{char2nr('_')} = "_\r_"
let b:surround_{char2nr('i')} = "_\r_"
let b:surround_{char2nr('b')} = "**\r**"

" Easy bold and italic
xmap <buffer> <C-b> Sb
xmap <buffer> <C-i> Si
