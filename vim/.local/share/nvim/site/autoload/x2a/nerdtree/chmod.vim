function! x2a#nerdtree#chmod#isExecutable() abort
  let l:node = g:NERDTreeFileNode.GetSelected()
  return l:node.path.isExecutable
endfunction

function! x2a#nerdtree#chmod#isNotExecutable() abort
  return !x2a#nerdtree#chmod#isExecutable()
endfunction

function! x2a#nerdtree#chmod#addExecutableBits() abort
  let l:node = g:NERDTreeFileNode.GetSelected()
  let l:arg = input('chmod: ', '+x')
  let l:cmd = 'chmod ' . l:arg . ' ' . l:node.path.str({ 'escape': 1 })

  if l:cmd !=# ''
    let l:success = system(l:cmd)
    call l:node.refresh()
    call NERDTreeRender()
  else
    echo 'Aborted'
  endif
endfunction

function! x2a#nerdtree#chmod#removeExecutableBits() abort
  let l:node = g:NERDTreeFileNode.GetSelected()
  let l:arg = input('chmod: ', '-x')
  let l:cmd = 'chmod ' . l:arg . ' ' . l:node.path.str({ 'escape': 1 })

  if l:cmd !=# ''
    let l:success = system(l:cmd)
    call l:node.refresh()
    call NERDTreeRender()
  else
    echo 'Aborted'
  endif
endfunction
