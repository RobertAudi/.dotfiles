function! x2a#NERDTree#Expanderrific#activate(filenode) abort
  if a:filenode.path.isDirectory
    call x2a#utils#helpers#Warn("Warn: Can't activate a directory!")
    return 0
  endif

  call a:filenode.activate({ 'reuse': 'all', 'where': 'p' })
endfunction

function! x2a#NERDTree#Expanderrific#expand(dir) abort
  let l:opts = { 'reuse': 1 }
  if g:NERDTreeCascadeOpenSingleChildDir == 0
    call a:dir.open(l:opts)
  else
    call a:dir.openAlong(l:opts)
  endif
  call b:NERDTree.render()
endfunction

function! x2a#NERDTree#Expanderrific#collapse(node) abort
  let l:node = a:node
  if !a:node.path.isDirectory || !a:node.isOpen
    let l:node = a:node.parent
  endif

  if l:node != b:NERDTreeRoot
    call l:node.close()
    call b:NERDTree.render()
    call l:node.putCursorHere(0, 0)
  endif
endfunction
