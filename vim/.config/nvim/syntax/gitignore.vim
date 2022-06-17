" Vim syntax file
" Language:   .gitignore
" Maintainer: gisphm <phmfk@hotmail.com>
" URL:        https://github.com/gisphm/vim-gitignore

" Quit when a (custom) syntax file was already loaded
if exists('b:current_syntax')
  finish
endif

syntax keyword gitignoreTodo contained TODO FIXME XXX
" Avoid matching "text#text", used in /etc/disktab and /etc/gettytab
syntax match gitignoreComment "^#.*" contains=gitignoreTodo
syntax match gitignoreComment "\s#.*"ms=s+1 contains=gitignoreTodo
syntax match gitignoreFile "^\(#\)\@!.*\(/\)\@<!$"
syntax match gitignoreDirectory "^\(#\)\@!.*\/$"

" Define the default highlighting.
" Only used when an item doesn't have highlighting yet
highlight def link gitignoreComment Comment
highlight def link gitignoreTodo Todo
highlight def link gitignoreDirectory Constant
highlight def link gitignoreFile Type

let b:current_syntax = 'gitignore'
