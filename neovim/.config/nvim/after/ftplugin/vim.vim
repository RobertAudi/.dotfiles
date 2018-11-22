setlocal define=^\\s*\\(function\\\|command\\)

nnoremap <buffer> <silent> g? :set <C-r><C-w>?<CR>
nnoremap <buffer> <silent> \o :call utils#OpenPluginRepoInBrowser()<CR>
