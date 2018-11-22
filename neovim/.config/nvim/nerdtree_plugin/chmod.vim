" ============================================================================
" File:        chmod.vim
" Description: plugin for NERDTree to allow for chmod'ing files in Vim.
" Usage:       The following additional key-mappings will be automatically
"              available whenever NERDTree is activated:
"
"               Key | Menu | Action
"              -----|------|--------
"                x  | yes  | chmod +x or -x

" ============================================================================

if exists("g:loaded_nerdtree_chmod_menuitem")
  finish
endif
let g:loaded_nerdtree_chmod_menuitem = 1

call NERDTreeAddMenuItem({
      \   "text":             "(x)chmod -x",
      \   "shortcut":         "x",
      \   "callback":         "NERDTreeExecFileOff",
      \   "isActiveCallback": "NERDTreeExecFileActiveIncDir"
      \ })

call NERDTreeAddMenuItem({
      \   "text":             "(x)chmod +x",
      \   "shortcut":         "x",
      \   "callback":         "NERDTreeExecFileOn",
      \   "isActiveCallback": "NERDTreeExecFileNotActive"
      \ })

function! NERDTreeExecFileActiveIncDir()
  let curNode = g:NERDTreeFileNode.GetSelected()
  return curNode.path.isExecutable
endfunction

function! NERDTreeExecFileOff()
  let curNode = g:NERDTreeFileNode.GetSelected()
  let chmodArg = input("chmod: ", "-x")
  let cmd = "chmod " . chmodArg . " " . curNode.path.str({ "escape": 1 })

  if cmd != ""
    let success = system(cmd)
    call curNode.refresh()
    call NERDTreeRender()
  else
    echo "Aborted"
  endif
endfunction

function! NERDTreeExecFileNotActive()
  let curNode = g:NERDTreeFileNode.GetSelected()
  return !curNode.path.isExecutable
endfunction

function! NERDTreeExecFileOn()
  let curNode = g:NERDTreeFileNode.GetSelected()
  let chmodArg = input("chmod: ", "+x")
  let cmd = "chmod " . chmodArg . " " . curNode.path.str({ "escape": 1 })

  if cmd != ""
    let success = system(cmd)
    call curNode.refresh()
    call NERDTreeRender()
  else
    echo "Aborted"
  endif
endfunction
