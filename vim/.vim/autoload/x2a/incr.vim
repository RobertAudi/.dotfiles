" increment selected column of numbers
function! x2a#incr#Incr(vcount) abort
  let a = (line('.') - line("'<")) + a:vcount
  let c = virtcol("'<")
  if a > 0
    execute 'normal! ' . c . '|' . a . "\<C-a>"
  endif
  normal! `<
endfunction
