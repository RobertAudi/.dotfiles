setlocal iskeyword-=:
setlocal iskeyword-=#

" Source: https://sanctum.geek.nz/cgit/dotfiles.git
"         https://sanctum.geek.nz/cgit/dotfiles.git/tree/vim/after/ftplugin/vim.vim#n1
"
" Use Vint as a syntax checker
if bufname('%') !=# 'command-line' && executable('vint')
  compiler vint
endif

nnoremap <buffer> <silent> g? :set <C-r><C-w>?<CR>
nnoremap <buffer> <silent> <C-]> <Cmd>call lookup#lookup()<CR>
nnoremap <buffer> <silent> <C-t> <Cmd>call lookup#pop()<CR>
nnoremap <buffer> <silent> \o <Cmd>call x2a#utils#plugins#OpenPluginRepoInBrowser()<CR>
