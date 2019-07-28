" expanderrific.vim
" https://github.com/cowboy/dotfiles
"
" Allow right/left to expand/collapse NERDTree dirs in a more meaningful way.

" Ben Alman
" http://benalman.com/

if exists('g:loaded_nerdtree_expanderrific')
  finish
endif
let g:loaded_nerdtree_expanderrific = 1

let s:expanderrific_expand   = ['l', '<Right>']
let s:expanderrific_collapse = ['h', '<Left>']

for s:key in s:expanderrific_expand
  call NERDTreeAddKeyMap({
        \   'key': s:key,
        \   'scope': 'DirNode',
        \   'callback': 'x2a#nerdtree#Expanderrific#expand'
        \ })
endfor

for s:key in s:expanderrific_collapse
  call NERDTreeAddKeyMap({
        \   'key': s:key,
        \   'scope': 'Node',
        \   'callback': 'x2a#nerdtree#Expanderrific#collapse'
        \ })
endfor

for s:key in s:expanderrific_expand
  call NERDTreeAddKeyMap({
        \   'key': s:key,
        \   'scope': 'FileNode',
        \   'callback': 'x2a#nerdtree#Expanderrific#activate'
        \ })
endfor
