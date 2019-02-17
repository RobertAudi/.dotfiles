" =============================================================================
" File:          autoload/ctrlp/filetype.vim
" Description:   CtrlP fileTypes plugin. Allows to change the file type.
" =============================================================================

" To load this extension into ctrlp, add this to your vimrc:
"
"     let g:ctrlp_extensions = ['filetype']
"
" For multiple extensions:
"
"     let g:ctrlp_extensions = [
"         \ 'filetype',
"         \ 'another_extension',
"         \ 'yet_another_extension',
"         \ ]
"
" To Create a command to directly call the new search type,
" put this in vimrc or plugin/filetype.vim
"
"     command! CtrlPFileType call ctrlp#init(ctrlp#filetype#id())
"

if exists('g:loaded_ctrlp_filetype') && g:loaded_ctrlp_filetype
  finish
endif
let g:loaded_ctrlp_filetype = 1

call add(g:ctrlp_ext_vars, {
      \   'init': 'ctrlp#filetype#init()',
      \   'accept': 'ctrlp#filetype#accept',
      \   'lname': 'filetype',
      \   'sname': 'filetype',
      \   'type': 'line',
      \   'sort': 0,
      \   'specinput': 0,
      \ })

function! ctrlp#filetype#init() abort
  return getcompletion('', 'filetype')
endfunction

function! ctrlp#filetype#accept(mode, str) abort
  call ctrlp#exit()
  call x2a#filetypes#setFileType(0, a:str)
endfunction

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)

function! ctrlp#filetype#id() abort
  return s:id
endfunction
