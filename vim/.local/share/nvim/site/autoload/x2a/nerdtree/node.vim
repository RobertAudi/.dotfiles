function! x2a#nerdtree#node#Preview(node) abort
  if a:node.path.isDirectory
    if !a:node.isOpen
      call a:node.open()
    endif

    call a:node.closeChildren()
    call b:NERDTree.render()
    call a:node.putCursorHere(0, 0)
  else
    call a:node.open({ 'stay': 1, 'where': 'p', 'keepopen': 1 })
  endif
endfunction

function! x2a#nerdtree#node#OpenInVerticalSplit(target) abort
  if a:target.path.isDirectory
    call x2a#utils#echo#Warning("Can't open a directory in a vertical split!")
    return 0
  endif

  call a:target.activate({ 'where': 'v' })
endfunction

function! x2a#nerdtree#node#PreviewInVerticalSplit(target) abort
  if a:target.path.isDirectory
    call x2a#utils#echo#Warning("Can't preview a directory in a vertical split!")
    return 0
  endif

  call a:target.activate({ 'where': 'v', 'stay': 1 })
endfunction

function! x2a#nerdtree#node#OpenInHorizontalSplit(target) abort
  if a:target.path.isDirectory
    call x2a#utils#echo#Warning("Can't open a directory in a horizontal split!")
    return 0
  endif

  call a:target.activate({ 'where': 'h' })
endfunction

function! x2a#nerdtree#node#PreviewInHorizontalSplit(target) abort
  if a:target.path.isDirectory
    call x2a#utils#echo#Warning("Can't preview a directory in a horizontal split!")
    return 0
  endif

  call a:target.activate({ 'where': 'h', 'stay': 1 })
endfunction
