if exists('g:loaded_nerdtree_choosewin_open')
  finish
endif
let g:loaded_nerdtree_choosewin_open = 1

call NERDTreeAddKeyMap(
      \ {
      \   'key':      'O',
      \   'scope':    'FileNode',
      \   'callback': 'x2a#NERDTree#ChooseWin#Open',
      \   'override': 1
      \ })
