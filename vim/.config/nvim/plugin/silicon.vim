" Plugin: segeljakt/vim-silicon
" Description: Vim plugin for generating images of source code using Aloxaf/silicon
" URL: https://github.com/segeljakt/vim-silicon
" URL: https://github.com/Aloxaf/silicon

let g:silicon = {
      \   'theme':              'TwoDark',
      \   'font':               'JetBrains Mono',
      \   'background':         '#A8C3E1',
      \   'shadow-color':       '#555555',
      \   'line-pad':                   2,
      \   'pad-horiz':                 80,
      \   'pad-vert':                 100,
      \   'shadow-blur-radius':         0,
      \   'shadow-offset-x':            0,
      \   'shadow-offset-y':            0,
      \   'line-number':           v:true,
      \   'round-corner':          v:true,
      \   'window-controls':       v:true,
      \ }

let g:silicon['default-file-pattern'] = '~/Pictures/Screenshots/silicon-{time:%Y-%m-%d-%H%M%S}.png'
