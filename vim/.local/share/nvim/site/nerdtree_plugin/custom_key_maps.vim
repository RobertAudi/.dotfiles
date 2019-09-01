if exists('g:loaded_nerdtree_custom_key_maps')
  finish
endif
let g:loaded_nerdtree_custom_key_maps = 1

call NERDTreeAddKeyMap(
      \ {
      \   'key': 'q',
      \   'override': 1,
      \   'scope': 'all',
      \   'callback': 'x2a#nerdtree#Close',
      \   'quickhelpText': 'Close the NERDTree window',
      \ })

call NERDTreeAddKeyMap(
      \ {
      \   'key': 'go',
      \   'override': 1,
      \   'scope': 'Node',
      \   'callback': 'x2a#nerdtree#node#Preview',
      \   'quickhelpText': 'Preview',
      \ })

call NERDTreeAddKeyMap(
      \ {
      \   'key': 's',
      \   'override': 1,
      \   'scope': 'Node',
      \   'callback': 'x2a#nerdtree#node#OpenInVerticalSplit',
      \   'quickhelpText': 'Open in vsplit',
      \ })

call NERDTreeAddKeyMap(
      \ {
      \   'key': 'gs',
      \   'override': 1,
      \   'scope': 'Node',
      \   'callback': 'x2a#nerdtree#node#PreviewInVerticalSplit',
      \   'quickhelpText': 'Preview in vsplit',
      \ })

call NERDTreeAddKeyMap(
      \ {
      \   'key': 'i',
      \   'override': 1,
      \   'scope': 'Node',
      \   'callback': 'x2a#nerdtree#node#OpenInHorizontalSplit',
      \   'quickhelpText': 'Open in split',
      \ })

call NERDTreeAddKeyMap(
      \ {
      \   'key': 'gi',
      \   'override': 1,
      \   'scope': 'Node',
      \   'callback': 'x2a#nerdtree#node#PreviewInHorizontalSplit',
      \   'quickhelpText': 'Preview in split',
      \ })

" Note: The <nowait> is a hack to bypass other mappings that start with 'v'
call NERDTreeAddKeyMap(
      \ {
      \   'key': '<nowait> v',
      \   'scope': 'Node',
      \   'callback': 'x2a#nerdtree#node#OpenInVerticalSplit',
      \   'quickhelpText': 'Open in vsplit'
      \ })

call NERDTreeAddKeyMap(
      \ {
      \   'key': 'V',
      \   'scope': 'Node',
      \   'callback': 'x2a#nerdtree#node#PreviewInVerticalSplit',
      \   'quickhelpText': 'Preview in vsplit'
      \ })

call NERDTreeAddKeyMap(
      \ {
      \   'key': 'gv',
      \   'scope': 'Node',
      \   'callback': 'x2a#nerdtree#node#PreviewInVerticalSplit',
      \   'quickhelpText': 'Preview in vsplit'
      \ })
