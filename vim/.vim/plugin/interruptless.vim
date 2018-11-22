if exists('g:loaded_interruptless') && g:loaded_interruptless
  finish
endif
let g:loaded_interruptless = 1

let s:save_cpo = &cpo
set cpo&vim

function! s:file_changed()
  let v:fcs_choice = 'just do nothing'
  let filename = expand('<afile>')
  " how to detect file created event?
  if v:fcs_reason ==# 'conflict'
    echohl WarningMsg
    echo 'Warning: File "'.filename.'" has changed and the buffer was changed in Vim as well'
    echohl None
  endif
endfunction

augroup RAPluginsInterruptless
  autocmd!
  autocmd FileChangedShell * call <SID>file_changed()
augroup END

let &cpo = s:save_cpo
unlet s:save_cpo
