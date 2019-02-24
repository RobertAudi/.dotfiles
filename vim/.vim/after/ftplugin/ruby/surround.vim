" Plugin: vim-surround
" Description: Quoting/parenthesizing made simple
" URL: https://github.com/tpope/vim-surround

let b:surround_{char2nr('#')} = "#{\r}"  " String interpolation
let b:surround_{char2nr('i')} = "%i[\r]" " Array of symbols
let b:surround_{char2nr('W')} = "%W[\r]" " Array of words as if double-quoted
let b:surround_{char2nr('w')} = "%w[\r]" " Array of words as if single-quoted
let b:surround_{char2nr('Q')} = "%Q{\r}" " Double-quoted string
let b:surround_{char2nr('q')} = "%q{\r}" " Single-quoted string
let b:surround_{char2nr('r')} = "%r{\r}" " Regular expression
let b:surround_{char2nr('s')} = "%s{\r}" " Symbol
let b:surround_{char2nr('x')} = "%x[\r]" " System command (backticks)

" Easy bold and italic
xmap <buffer> <C-i> Si
xmap <buffer> <C-b> Sb

if has("gui_running") && has("gui_macvim")
  xmap <buffer> <D-b> Sb
  xmap <buffer> <D-i> Si
endif
