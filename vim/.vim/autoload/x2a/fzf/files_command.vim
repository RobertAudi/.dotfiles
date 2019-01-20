function! x2a#fzf#files_command#fd() abort
  if executable('fd')
    return 'fd'
          \ . ' --hidden'
          \ . ' --type file'
          \ . ' --no-ignore-vcs'
          \ . ' --color=never'
  else
    throw 'Command not found: fd'
  endif
endfunction

function! x2a#fzf#files_command#rg() abort
  if executable('rg')
    return 'rg'
          \ . ' --smart-case'
          \ . ' --hidden'
          \ . ' --files'
          \ . ' --no-ignore-vcs'
          \ . ' --color=never'
  else
    throw 'Command not found: rg'
  endif
endfunction

function! x2a#fzf#files_command#ag() abort
  if executable('ag')
    return 'ag'
          \ . ' --smart-case'
          \ . ' --hidden'
          \ . ' --files-with-matches'
          \ . ' --skip-vcs-ignores'
          \ . ' --nocolor'
          \ . ' --nogroup'
          \ . ' -g ""'
  else
    throw 'Command not found: ag'
  endif
endfunction
