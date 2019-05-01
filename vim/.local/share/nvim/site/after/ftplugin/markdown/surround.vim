" Plugin: vim-surround
" Description: Quoting/parenthesizing made simple
" URL: https://github.com/tpope/vim-surround

let b:surround_{char2nr('*')} = "*\r*"
let b:surround_{char2nr('i')} = "*\r*"
let b:surround_{char2nr('b')} = "**\r**"

" Easy bold and italic
xmap <buffer> <C-b> Sb
xmap <buffer> <C-i> Si

if has('gui_vimr')
  xmap <buffer> <D-b> <C-b>
  xmap <buffer> <D-i> <C-i>
endif
