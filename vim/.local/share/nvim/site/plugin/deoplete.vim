" Plugin: deoplete.vim
" Description: Dark powered asynchronous completion framework
" URL: https://github.com/Shougo/deoplete.nvim

" Enable deoplete when InsertEnter.
let g:deoplete#enable_at_startup = 0

augroup RAPluginsDeoplete
  autocmd!

  autocmd InsertEnter * call deoplete#enable()
augroup END

call deoplete#custom#option({
      \   'auto_complete_delay': 500,
      \   'smart_case': v:true,
      \   'max_list': 100,
      \ })

" <TAB>: completion.
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
