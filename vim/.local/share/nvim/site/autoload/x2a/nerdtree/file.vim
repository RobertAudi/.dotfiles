function! x2a#nerdtree#file#Reveal() abort
    if exists('b:NERDTree')
      call x2a#utils#echo#Warning('Already inside a NERDTree')
      return
    endif

    silent! NERDTreeFind
    normal! zz
endfunction
