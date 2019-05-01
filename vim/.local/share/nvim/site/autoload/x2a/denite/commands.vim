function! x2a#denite#commands#fd()
  return  [
        \   'fd',
        \   '--hidden',
        \   '--type', 'file',
        \   '--no-ignore-vcs',
        \   '--color=never',
        \   '',
        \ ]
endfunction

function! x2a#denite#commands#ag()
  return  [
        \   'ag',
        \   '--hidden',
        \   '--follow',
        \   '--files-with-matches',
        \   '--skip-vcs-ignores',
        \   '--nocolor',
        \   '--nogroup',
        \   '-g', '',
        \ ]
endfunction

function! x2a#denite#commands#rg()
  return  [
        \   'rg',
        \   '--smart-case',
        \   '--hidden',
        \   '--files',
        \   '--no-ignore-vcs',
        \   '--color=never',
        \ ]
endfunction
