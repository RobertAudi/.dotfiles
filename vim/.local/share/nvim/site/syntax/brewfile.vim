" Vim syntax file
" Language:    Brewfile
" Maintainer:  Baptiste Fontaine <b@ptistefontaine.fr>
" URL:         https://github.com/bfontaine/Brewfile.vim
" Last Change: 2018 May 2
"
" Improved with changes from github.com/kassio/nvimfiles
"   https://github.com/kassio/nvimfiles/blob/master/syntax/brewfile.vim
"   https://github.com/kassio/nvimfiles/blob/8737ac41c49fcedfedb5089df4efac826619444d/syntax/brewfile.vim

if exists('b:current_syntax')
  finish
endif

" Load ruby syntax
source $VIMRUNTIME/syntax/ruby.vim
unlet b:current_syntax

syntax keyword Brewfile_tap tap
syntax keyword Brewfile_brew brew
syntax keyword Brewfile_cask cask
syntax keyword Brewfile_mas mas

highlight def link Brewfile_tap Statement
highlight def link Brewfile_brew Function
highlight def link Brewfile_cask Special
highlight def link Brewfile_mas Keyword

let b:current_syntax = 'brewfile'
