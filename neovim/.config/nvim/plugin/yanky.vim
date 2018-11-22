" move cursor to the end of selected area after yank
nnoremap <expr> <SID>(YankAndJumpToTailPrerequisite) YankAndJumpToTailPrerequisite()
nnoremap <SID>(g@) g@
nmap gy <SID>(YankAndJumpToTailPrerequisite)<SID>(g@)
xmap gy y`>

function! YankAndJumpToTail(motionwise) abort
  let v = a:motionwise ==# 'char' ? 'v'
        \ : a:motionwise ==# 'line' ? 'V'
        \ : "\<C-v>"

  " use o_v, o_V, o_CTRL-v to keep the marks '<, '>
  execute printf('normal! `["%sy%s`]', v:register, v)

  let key_seq = printf(":call setpos('.', %s)\<CR>:echo \<CR>", string(getpos("']")))
  call feedkeys(key_seq, 'n')
endfunction

function! YankAndJumpToTailPrerequisite() abort
  set operatorfunc=YankAndJumpToTail
  return ''
endfunction
