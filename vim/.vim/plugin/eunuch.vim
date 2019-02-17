" Plugin: vim-eunuch
" Description: Helpers for UNIX
" URL: https://github.com/tpope/vim-eunuch

" Make scripts executable on save
function! s:MakeScriptExecutable()
  let file = expand('%:p')
  if getline(1) =~# '^#!' && !executable(file)
    silent! Chmod +x
  endif
endfunction

augroup RAPluginsUnix
  autocmd!
  autocmd BufWritePost * call s:MakeScriptExecutable()
augroup END

nnoremap \rf :Rename <C-r>=expand("%:t")<CR>

