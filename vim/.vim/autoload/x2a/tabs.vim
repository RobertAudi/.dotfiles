" Author: Barry Arthur (@dahu)
" URL:    https://github.com/dahu/tabby/
"         https://github.com/dahu/tabby/blob/7f204e829ebd410a8ee6816c74e19b70fb3530b8/plugin/tabby.vim#L14-L19
function! x2a#tabs#TabForward(nr) abort
  let l:lastpage = tabpagenr('$')
  let l:newpage = (tabpagenr() + a:nr) % l:lastpage
  let l:newpage = l:newpage == 0 ? l:lastpage : l:newpage
  execute 'tabnext ' . l:newpage
endfunction

function! x2a#tabs#TabBaward(nr) abort
  let l:lastpage = tabpagenr('$')
  let l:newpage = tabpagenr() - a:nr
  let l:newpage = l:newpage < 1 ? l:lastpage + l:newpage : l:newpage
  execute 'tabnext ' . l:newpage
endfunction
