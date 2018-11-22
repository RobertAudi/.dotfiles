"
" Bulk command abbreviations
"
" Usage: call abolish#commands({cmd}, <abbr...>)
"        call abolish#commands("wqa", "Wqa", "WQa", "WQA")
"
function! abolish#commands(expansion, ...) abort
  for l:abbreviation in a:000
    execute 'cabbrev ' . l:abbreviation
          \ . ' <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "'
          \ . a:expansion . '" : "' . l:abbreviation . '"<CR>'
  endfor
endfunction
