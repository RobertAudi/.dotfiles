"
" Bulk command abbreviations
"
" Usage: call x2a#abolish#commands({cmd}, <abbr...>)
"        call x2a#abolish#commands("wqa", "Wqa", "WQa", "WQA")
"
function! x2a#abolish#commands(expansion, ...) abort
  for l:abbreviation in a:000
    execute 'cabbrev ' . l:abbreviation
          \ . ' <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "'
          \ . a:expansion . '" : "' . l:abbreviation . '"<CR>'
  endfor
endfunction
