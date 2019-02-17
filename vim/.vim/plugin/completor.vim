" Plugin: completor.vim
" Description: Async completion framework made ease.
" URL: https://github.com/maralla/completor.vim

" <TAB>: completion.
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>smart_return()<CR>
function! s:smart_return()
  return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
