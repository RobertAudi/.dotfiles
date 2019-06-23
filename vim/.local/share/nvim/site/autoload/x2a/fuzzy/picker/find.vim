function! s:fd_flags() abort
  return  [
        \   '--hidden',
        \   '--type', 'file',
        \   '--no-ignore-vcs',
        \   '--ignore-file ' . $NVIM_CONFIG_HOME . '/.fdignore',
        \   '--color=never',
        \ ]
endfunction

function! s:ag_flags() abort
  return  [
        \   '--hidden',
        \   '--follow',
        \   '--files-with-matches',
        \   '--skip-vcs-ignores',
        \   '--ignore "/sandbox/"',
        \   '--nocolor',
        \   '--nogroup',
        \ ]
endfunction

function! s:rg_flags() abort
  return  [
        \   '--smart-case',
        \   '--hidden',
        \   '--files',
        \   '--no-ignore-vcs',
        \   '--glob "/sandbox/"',
        \   '--color=never',
        \ ]
endfunction

function! x2a#fuzzy#picker#find#flags(executable) abort
  if !(a:executable ==# 'fd' || a:executable ==# 'ag' || a:executable ==# 'rg')
    call x2a#utils#echo#Error('Executable not found: ' . a:executable)
    return
  endif

  let l:FlagFunc = function('<SID>' . a:executable . '_flags')
  let l:flags = l:FlagFunc()

  return join(l:flags)
endfunction
