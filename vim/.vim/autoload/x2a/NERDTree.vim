function! x2a#NERDTree#CopyNodePath(node) abort
  let l:path = a:node.path.str()
  call setreg('*', l:path)
  redraw
  echomsg 'Copied to clipboard: ' . l:path
endfunction

function! x2a#NERDTree#CopyPath() abort
  call x2a#NERDTree#CopyNodePath(g:NERDTreeFileNode.GetSelected())
endfunction
