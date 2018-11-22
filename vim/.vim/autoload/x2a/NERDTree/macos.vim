function! x2a#NERDTree#macos#PreviewFileNodeInQuickLook(filenode) abort
  if a:filenode != {}
    call x2a#macos#PreviewInQuickLook(a:filenode.path.str())
  endif
endfunction

function! x2a#NERDTree#macos#RevealFileNodeInFinder(filenode) abort
  if a:filenode != {}
    call x2a#macos#RevealInFinder(a:filenode.path.str())
  endif
endfunction
