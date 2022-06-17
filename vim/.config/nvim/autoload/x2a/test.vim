function! x2a#test#ToggleTermStrategy(cmd) abort
  execute ':TermExec cmd="' . a:cmd . '"'
endfunction
