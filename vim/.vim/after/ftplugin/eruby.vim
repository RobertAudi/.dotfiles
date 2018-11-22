" Don't scan included files
setlocal complete-=i

setlocal foldmethod=manual
setlocal matchpairs-=<:>

" vim-surround
let b:surround_{char2nr('#')} = "#{\r}"
let b:surround_{char2nr('%')} = "<% \r %>"
let b:surround_{char2nr('=')} = "<%= \r %>"

" AutoPairs
let b:AutoPairs = get(b:, 'AutoPairs', g:AutoPairs)
let b:AutoPairs['|'] = '|'
