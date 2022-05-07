" Show git branch with ctrl-g info
function! x2a#gitbranch#ctrl_g(count) abort
  let l:msg = x2a#utils#Redir('silent execute "normal! 2\<C-g>"')
  echo gitbranch#name() l:msg[1:] (a:count ? strftime('%Y-%m-%d %H:%M', getftime(expand('%:p'))) : '')
endfunction
