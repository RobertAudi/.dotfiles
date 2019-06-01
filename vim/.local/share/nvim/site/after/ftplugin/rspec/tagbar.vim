" Plugin: tagbar
" Description: Vim plugin that displays tags in a window, ordered by scope
" URL: https://github.com/majutsushi/tagbar

let g:tagbar_type_rspec = {
      \   'kinds': [
      \     'm:modules',
      \     'c:classes',
      \     'd:describes',
      \     'C:contexts',
      \     'f:methods',
      \     'F:singleton methods'
      \   ]
      \ }
