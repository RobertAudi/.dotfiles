" Vim filetype plugin
" Language:  Brewfile
" Mantainer: Baptiste Fontaine <b@ptistefontaine.fr>
" URL:       https://github.com/bfontaine/Brewfile.vim

autocmd BufNewFile,BufRead Brewfile,.Brewfile,*.brewfile set filetype=ruby syntax=brewfile
