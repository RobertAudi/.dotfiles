if !x2a#utils#os#is_mac()
  finish
endif

function! x2a#nerdtree#macos#PreviewFileNodeInQuickLook(filenode) abort
  if a:filenode != {}
    let l:filepath = a:filenode.path.str()

    if fnamemodify(l:filepath, ':e') =~? 'md\|mkd\|mkdn\|mdwn\|mdown\|markdown'
      call x2a#macos#markdown#PreviewInMarked(l:filepath)
    else
      call x2a#macos#PreviewInQuickLook(l:filepath)
    endif
  endif
endfunction

function! x2a#nerdtree#macos#RevealFileNodeInFinder(filenode) abort
  if a:filenode != {}
    call x2a#macos#RevealInFinder(a:filenode.path.str())
  endif
endfunction

function! x2a#nerdtree#macos#PreviewInMarked(filenode) abort
  if a:filenode != {}
    let l:filepath = a:filenode.path.str()

    if fnamemodify(l:filepath, ':e') =~? 'md\|mkd\|mkdn\|mdwn\|mdown\|markdown'
      call x2a#macos#markdown#PreviewInMarked(l:filepath)
    else
      call x2a#utils#echo#Warning('not a markdown file')
    endif
  endif
endfunction
