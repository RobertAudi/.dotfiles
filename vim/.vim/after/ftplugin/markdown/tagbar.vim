" Plugin: tagbar
" Description: Vim plugin that displays tags in a window, ordered by scope
" URL: https://github.com/majutsushi/tagbar

scriptencoding utf-8

let g:tagbar_type_markdown = {
      \   'ctagstype': 'markdown',
      \   'ctagsbin': 'markdown2ctags.py',
      \   'ctagsargs': '-f - --sort=yes --sro=»',
      \   'kinds': [
      \     's:sections',
      \     'i:images'
      \   ],
      \   'sro': '»',
      \   'kind2scope' : {
      \     's': 'section',
      \   },
      \   'sort': 0,
      \ }
