" Show git branch with ctrl-g info
function! x2a#gitbranch#ctrl_g(count) abort
  redir => msg | silent execute "normal! 2\<C-g>" | redir END
  echo gitbranch#name() msg[2:] (a:count ? strftime('%Y-%m-%d %H:%M', getftime(expand('%:p'))) : '')
endfunction
