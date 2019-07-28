function! s:exec(cmd) abort
  let l:eventignore_keep = &eventignore
  let l:lazyredraw_keep  = &lazyredraw
  set eventignore=all
  set lazyredraw

  execute a:cmd

  let &eventignore = l:eventignore_keep
  let &lazyredraw  = l:lazyredraw_keep
endfunction

function! x2a#nerdtree#CopyNodePath(node) abort
  let l:path = a:node.path.str()
  call setreg('*', l:path)
  redraw
  echomsg 'Copied to clipboard: ' . l:path
endfunction

function! x2a#nerdtree#CopyPath() abort
  call x2a#nerdtree#CopyNodePath(g:NERDTreeFileNode.GetSelected())
endfunction

function! x2a#nerdtree#Refresh(...) abort
  if !exists('g:NERDTree') || !g:NERDTree.IsOpen()
    return
  endif

  if a:0
    let l:pathStr = !empty(a:1) ? a:1 : expand('%:p')
  else
    let l:pathStr = expand('%:p')
  endif

  if empty(l:pathStr)
    call nerdtree#echo#Warning('no file for the current buffer')
    return
  endif

  try
    let l:pathStr = g:NERDTreePath.Resolve(l:pathStr)
    let l:pathObj = g:NERDTreePath.New(l:pathStr)
  catch /^NERDTree.InvalidArgumentsError/
    call nerdtree#echo#Warning('invalid path')
    return
  endtry

  let l:NERDTree = g:NERDTree.ForCurrentTab()

  if !l:pathObj.isUnder(l:NERDTree.root.path) || l:pathObj.isHiddenUnder(l:NERDTree.root.path)
    return
  endif

  let l:node = l:NERDTree.root.findNode(l:pathObj)

  try
    if l:node.path && !l:node.path.isDirectory
      let l:node = l:node.parent
    endif

    call l:node.refresh()
  catch /.*/
    call x2a#utils#echo#Warning('DAFUQ: NERDTree Refresh failed')
  endtry

  let l:curWin = winnr()
  let l:cmd = 'keepjumps keepalt ' . g:NERDTree.GetWinNum() . 'wincmd w'
  let l:cmd .= ' | call b:NERDTree.render()'
  let l:cmd .= ' | keepjumps keepalt ' . l:curWin . 'wincmd w'

  call s:exec(l:cmd)

  redraw

  call nerdtree#echo('Refreshing node. This could take a while... DONE')
endfunction
