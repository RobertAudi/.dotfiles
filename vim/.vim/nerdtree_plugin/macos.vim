if exists('g:loaded_nerdtree_macos')
  finish
endif
let g:loaded_nerdtree_macos = 1

if !has("gui_mac") && !has("gui_macvim") && !has("mac")
  finish
endif

call NERDTreeAddKeyMap(
      \ {
      \   'key': '<Space>',
      \   'scope': 'FileNode',
      \   'callback': 'x2a#NERDTree#macos#PreviewFileNodeInQuickLook',
      \   'quickhelpText': 'Preview the file in QuickLook'
      \ })

call NERDTreeAddKeyMap(
      \ {
      \   'key': 'gf',
      \   'scope': 'FileNode',
      \   'callback': 'x2a#NERDTree#macos#RevealFileNodeInFinder',
      \   'quickhelpText': 'Reveal file in Finder'
      \ })
