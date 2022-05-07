" Use C++ style comment strings with commentary.vim
setlocal commentstring=//%s

" Search for include files inside frameworks (used for gf etc.)
setlocal includeexpr=substitute(v:fname,'\\([^/]\\+\\)/\\(.\\+\\)','/System/Library/Frameworks/\\1.framework/Headers/\\2','')
