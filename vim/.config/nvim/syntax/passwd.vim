" Vim syntax file
" Language: /etc/passwd file
" Maintainer: Jacob Lerner <qlerner@netvision.net.il>
" Last change: 2004 Jan 26

if exists('b:current_syntax')
  finish
endif

syntax match passwdLogin        /^[^:]*/          nextgroup=passwdSep1
syntax match passwdSep1         /:/     contained nextgroup=passwdPassword
syntax match passwdPassword     /[^:]*/ contained nextgroup=passwdSep2
syntax match passwdSep2         /:/     contained nextgroup=passwdUID
syntax match passwdUID          /[^:]*/ contained nextgroup=passwdSep3
syntax match passwdSep3         /:/     contained nextgroup=passwdGID
syntax match passwdGID          /[^:]*/ contained nextgroup=passwdSep4
syntax match passwdSep4         /:/     contained nextgroup=passwdGCOS
syntax match passwdGCOS         /[^:]*/ contained nextgroup=passwdSep5
syntax match passwdSep5         /:/     contained nextgroup=passwdHomeDir
syntax match passwdHomeDir      /[^:]*/ contained nextgroup=passwdSep6
syntax match passwdSep6         /:/     contained nextgroup=passwdShell
syntax match passwdShell        /[^:]*/ contained nextgroup=passwdSep7Optional
syntax match passwdSep7Optional /:\|$/  contained nextgroup=passwdTrailing
syntax match passwdTrailing     /.*$/   contained
syntax match passwdNISLine      /^+$/
syntax match passwdBadLine      /^[^+]\([^:]*:\)\{0,5\}[^:]*$/
syntax match passwdBadLine      /^:.*$/


highlight link passwdLogin        Identifier
highlight link passwdSep1         Special
highlight link passwdPassword     Comment
highlight link passwdUID          Number
highlight link passwdSep2         Special
highlight link passwdNISLine      Special
highlight link passwdSep3         Special
highlight link passwdGID          Number
highlight link passwdSep4         Special
highlight link passwdGCOS         Comment
highlight link passwdSep5         Special
highlight link passwdBadLine      Error
highlight link passwdHomeDir      Type
highlight link passwdSep6         Special
highlight link passwdShell        Label
highlight link passwdSep7Optional Special
highlight link passwdTrailing     Error

let b:current_syntax = 'passwd'

" vim: set filetype=vim :
