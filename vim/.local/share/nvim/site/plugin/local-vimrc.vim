" Plugin: local-vimrc
" Description: KISS local vimrc with hash protection
" URL: https://github.com/RobertAudi/local-vimrc

let g:local_vimrc = {
      \   'cache_file': $XDG_CACHE_HOME . '/local-vimrc/rc_cache',
      \   'ignore': ['~/Developer/ghq']
      \ }

if empty(finddir(fnamemodify(g:local_vimrc.cache_file, ":h")))
  call mkdir(fnamemodify(g:local_vimrc.cache_file, ":h"), 'p', 0700)
endif
