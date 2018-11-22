autocmd BufRead,BufNewFile *gitattributes setlocal filetype=gitattributes syntax=gitignore
autocmd BufRead,BufNewFile .git/info/attributes setlocal filetype=gitconfig
