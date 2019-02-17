setlocal iskeyword-=:
setlocal iskeyword-=#
setlocal define=^\\s*\\(function\\\|command\\)

nnoremap <buffer> <silent> g? :set <C-r><C-w>?<CR>
nnoremap <buffer> <silent> <C-]> :call lookup#lookup()<CR>
nnoremap <buffer> <silent> <C-t> :call lookup#pop()<CR>
nnoremap <buffer> <silent> \o :call x2a#utils#plugins#OpenPluginRepoInBrowser()<CR>
