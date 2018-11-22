function! x2a#ctrlp#user_command#fd() abort
  if executable('fd')
    return 'fd'
          \ . ' --hidden'
          \ . ' --type f'
          \ . ' --color=never'
          \ . ' --no-ignore-vcs'
          \ . ' "" %s'
  else
    throw 'Command not found: fd'
  endif
endfunction

function! x2a#ctrlp#user_command#rg() abort
  if executable('rg')
    return 'rg'
          \ . ' %s'
          \ . ' --smart-case'
          \ . ' --hidden'
          \ . ' --files'
          \ . ' --color=never'
          \ . ' --glob ""'
  else
    throw 'Command not found: rg'
  endif
endfunction

function! x2a#ctrlp#user_command#ag() abort
  if executable('ag')
    return 'ag'
          \ . ' %s'
          \ . ' --hidden'
          \ . ' --smart-case'
          \ . ' --nocolor'
          \ . ' --nogroup'
          \ . ' -g ""'
  else
    throw 'Command not found: ag'
  endif
endfunction
