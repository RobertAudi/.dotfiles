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
      \   "callback":         "x2a#NERDTree#chmod#removeExecutableBits",
      \   "isActiveCallback": "x2a#NERDTree#chmod#isExecutable"
      \ })

call NERDTreeAddMenuItem({
      \   "text":             "(x)chmod +x",
      \   "shortcut":         "x",
      \   "callback":         "x2a#NERDTree#chmod#addExecutableBits",
      \   "isActiveCallback": "x2a#NERDTree#chmod#isNotExecutable"
      \ })


