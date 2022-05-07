function! x2a#vim#remove_timeout() abort
  set timeoutlen=0
endfunction

function! x2a#vim#restore_timeout() abort
  let &timeoutlen = get(g:, 'default_timeoutlen', 1000)
endfunction

" Source: https://sanctum.geek.nz/cgit/dotfiles.git
"         https://sanctum.geek.nz/cgit/dotfiles.git/tree/vim/autoload/reload.vim
function! x2a#vim#reload_fileType() abort
  if exists('g:did_load_filetypes')
    doautocmd filetypedetect BufRead
  endif
endfunction
