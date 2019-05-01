function! x2a#vim#remove_timeout() abort
  set timeoutlen=0
endfunction

function! x2a#vim#restore_timeout() abort
  let &timeoutlen = get(g:, 'default_timeoutlen', 1000)
endfunction
