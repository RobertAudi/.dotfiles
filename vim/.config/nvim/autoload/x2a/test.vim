function! x2a#test#ToggleTermStrategy(cmd) abort
  let l:cmd = a:cmd

  if filereadable('.envrc')
    let l:cmd = 'DIRENV_LOG_FORMAT= direnv exec . ' . l:cmd
  endif

  execute ':TermExec cmd="' . l:cmd . '"'
endfunction
