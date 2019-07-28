" ============================================================================
" File:        copy_path.vim
" Description: plugin for NERD Tree that copies selected path to clipboard
" Usage:       The following additional key-mappings will be automatically
"              available whenever NERDTree is activated:
"
"               Key | Menu | Action
"              -----|------|--------
"                y  | yes  | Copy path to clipboard
"               yy  | no   | Copy path to clipboard
"
" ============================================================================

if exists('g:loaded_nerdtree_copy_path')
  finish
endif
let g:loaded_nerdtree_copy_path = 1

" Add menu item to NERDTree to copy selected item's path to clipboard.
if has('clipboard')
  call NERDTreeAddMenuItem({
        \   'scope':    'Node',
        \   'shortcut': 'y',
        \   'callback': 'x2a#nerdtree#CopyPath',
        \   'text':     '(y)copy path to clipboard'
        \ })

  call NERDTreeAddKeyMap({
        \   'scope':         'Node',
        \   'key':           'yy',
        \   'callback':      'x2a#nerdtree#CopyNodePath',
        \   'quickhelpText': 'copy path to clipboard'
        \ })
endif
