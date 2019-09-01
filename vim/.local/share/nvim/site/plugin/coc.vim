" Plugin: coc.nvim
" Description: Intellisense engine for neovim, full language server protocol support as VSCode
" URL: https://github.com/neoclide/coc.nvim

let g:coc_global_extensions = [
      \   'coc-gitignore',
      \   'coc-tag',
      \   'coc-ultisnips',
      \   'coc-solargraph',
      \   'coc-vimlsp',
      \   'coc-json',
      \   'coc-css',
      \   'coc-html',
      \   'coc-tsserver',
      \   'coc-yaml',
      \ ]

function! s:check_back_space() abort
  let l:col = col('.') - 1

  return !l:col || getline('.')[l:col - 1]  =~# '\s'
endfunction

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent> <expr> <Tab> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<Tab>" : coc#refresh()
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <C-Space> to trigger completion.
inoremap <silent> <expr> <C-Space> coc#refresh()

" Use <CR> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
