let b:ctrlp_root_markers = ['Rakefile', 'Gemfile', '.ruby-version']

" Consider `!` and `?` as part of a word text object.
setlocal iskeyword+=!,?

" Don't scan included files
setlocal complete-=i

" vim-surround
let b:surround_{char2nr('#')} = "#{\r}"  " String interpolation
let b:surround_{char2nr('i')} = "%i[\r]" " Array of symbols
let b:surround_{char2nr('W')} = "%W[\r]" " Array of words as if double-quoted
let b:surround_{char2nr('w')} = "%w[\r]" " Array of words as if single-quoted
let b:surround_{char2nr('Q')} = "%Q{\r}" " Double-quoted string
let b:surround_{char2nr('q')} = "%q{\r}" " Single-quoted string
let b:surround_{char2nr('r')} = "%r{\r}" " Regular expression
let b:surround_{char2nr('s')} = "%s{\r}" " Symbol
let b:surround_{char2nr('x')} = "%x[\r]" " System command (backticks)

" AutoPairs
let b:AutoPairs = get(b:, 'AutoPairs', g:AutoPairs)
let b:AutoPairs['|'] = '|'
