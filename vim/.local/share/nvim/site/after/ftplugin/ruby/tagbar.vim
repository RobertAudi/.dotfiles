" Plugin: tagbar
" Description: Vim plugin that displays tags in a window, ordered by scope
" URL: https://github.com/majutsushi/tagbar

if executable('ripper-tags')
  let g:tagbar_type_ruby = {
        \   'kinds': [
        \     'm:modules',
        \     'c:classes',
        \     'C:constants',
        \     'F:singleton methods',
        \     'f:methods',
        \     'a:aliases'
        \   ],
        \   'kind2scope': {
        \     'c': 'class',
        \     'm': 'class'
        \   },
        \   'scope2kind': {
        \     'class': 'c'
        \   },
        \   'ctagsbin': 'ripper-tags',
        \   'ctagsargs': [
        \     '-f',
        \     '-'
        \   ]
        \ }
else
  let g:tagbar_type_ruby = {
        \   'kinds': [
        \     'm:modules',
        \     'c:classes',
        \     'f:methods',
        \     'F:singleton methods'
        \   ]
        \ }
endif
