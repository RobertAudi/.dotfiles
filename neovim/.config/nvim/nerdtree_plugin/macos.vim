if exists('g:loaded_nerdtree_macos')
  finish
endif
let g:loaded_nerdtree_macos = 1

if has("gui_mac") || has("gui_macvim") || has("mac")
  function! NERDTreePreviewFileNodeInQuickLook(filenode)
    if a:filenode != {}
      call macos#PreviewInQuickLook(a:filenode.path.str())
    endif
  endfunction

  function! NERDTreeRevealFileNodeInFinder(filenode)
    if a:filenode != {}
      call macos#RevealInFinder(a:filenode.path.str())
    endif
  endfunction

  call NERDTreeAddKeyMap(
        \ {
        \   'key': '<Space>',
        \   'scope': 'FileNode',
        \   'callback': 'NERDTreePreviewFileNodeInQuickLook',
        \   'quickhelpText': 'Preview the file in QuickLook'
        \ })

  call NERDTreeAddKeyMap(
        \ {
        \   'key': 'gf',
        \   'scope': 'FileNode',
        \   'callback': 'NERDTreeRevealFileNodeInFinder',
        \   'quickhelpText': 'Reveal file in Finder'
        \ })
endif
