" Show git branch with ctrl-g info
function! s:ctrl_g(cnt) abort
  redir => msg | silent execute "norm! 1\<c-g>" | redir END
  echo gitbranch#name() msg[2:] (a:cnt ? strftime('%Y-%m-%d %H:%M', getftime(expand('%:p'))) : '')
endfunction
nnoremap <C-g> :<C-u>call <SID>ctrl_g(v:count)<CR>
