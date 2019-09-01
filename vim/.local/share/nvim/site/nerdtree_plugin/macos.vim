if exists('g:loaded_nerdtree_macos')
  finish
endif
let g:loaded_nerdtree_macos = 1

if !x2a#utils#os#is_mac()
  finish
endif

call NERDTreeAddKeyMap(
      \ {
      \   'key': '<Space>',
      \   'scope': 'FileNode',
      \   'callback': 'x2a#nerdtree#macos#PreviewFileNodeInQuickLook',
      \   'quickhelpText': 'Preview the file in QuickLook'
      \ })

call NERDTreeAddKeyMap(
      \ {
      \   'key': 'gf',
      \   'scope': 'FileNode',
      \   'callback': 'x2a#nerdtree#macos#RevealFileNodeInFinder',
      \   'quickhelpText': 'Reveal file in Finder'
      \ })

call NERDTreeAddKeyMap(
      \ {
      \   'key': has('gui_vimr') ? '<D-p>' : '<Leader>p',
      \   'scope': 'FileNode',
      \   'callback': 'x2a#nerdtree#macos#PreviewInMarked',
      \   'quickhelpText': 'Preview the markdown file in Marked'
      \ })
