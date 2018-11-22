" tpope/vim-eunuch
" ------------------------------------------------------------------------------
nnoremap \rf :Rename <C-r>=expand("%:t")<CR>

Autocmd BufWritePost * call utils#MakeScriptExecutable()
