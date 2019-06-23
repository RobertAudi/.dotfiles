function! x2a#fuzzy#denite#commands#fd()
  return  [
        \   'fd',
        \   '--hidden',
        \   '--type', 'file',
        \   '--no-ignore-vcs',
        \   '--ignore-file ' . $NVIM_CONFIG_HOME . '/.fdignore',
        \   '--color=never',
        \   '',
        \ ]
endfunction

function! x2a#fuzzy#denite#commands#ag()
  return  [
        \   'ag',
        \   '--hidden',
        \   '--follow',
        \   '--files-with-matches',
        \   '--skip-vcs-ignores',
        \   '--ignore "/sandbox/"',
        \   '--nocolor',
        \   '--nogroup',
        \   '-g', '',
        \ ]
endfunction

function! x2a#fuzzy#denite#commands#rg()
  return  [
        \   'rg',
        \   '--smart-case',
        \   '--hidden',
        \   '--files',
        \   '--no-ignore-vcs',
        \   '--glob "/sandbox/"',
        \   '--color=never',
        \ ]
endfunction
