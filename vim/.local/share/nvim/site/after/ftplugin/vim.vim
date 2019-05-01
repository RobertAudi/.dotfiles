setlocal iskeyword-=:
setlocal iskeyword-=#

nnoremap <buffer> <silent> g? :set <C-r><C-w>?<CR>
nnoremap <buffer> <silent> <C-]> <Cmd>call lookup#lookup()<CR>
nnoremap <buffer> <silent> <C-t> <Cmd>call lookup#pop()<CR>
nnoremap <buffer> <silent> \o <Cmd>call x2a#utils#plugins#OpenPluginRepoInBrowser()<CR>
