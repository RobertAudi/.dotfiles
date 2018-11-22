" Quit when a (custom) syntax file was already loaded
if exists('b:current_syntax')
  finish
endif

" FIXME: This file is far from complete.

" Strings
syntax region pekString start=+'+ end=+'+ contains=pekEscape
syntax region pekString start=+"+ end=+"+ contains=pekEscape

" String Escapes
syntax match pekEscape +\\[abfnrtv'"\\]+ contained

" Single line comments.
syntax match pekComment +#.*$+ contains=pekTodo,@Spell
syntax match pekComment +//.*$+ contains=pekTodo,@Spell

" Multi-line comments
syntax region pekComment start=+/\*+ end=+\*/+ contains=pekTodo,@Spell

syntax keyword pekTodo FIXME NOTE NOTES TODO XXX contained

" Rules for all
syntax keyword pekRule INCLUDE

" Key groups
syntax keyword pekGroup Global MoveResize InputDialog Menu

" autoproperties groups
syntax keyword pekGroup Require Property
" autoproperties rules
syntax keyword pekRule Sticky Shaded MaximizedVertical MaximizedHorizontal Iconified Border Titlebar FrameGeometry
syntax keyword pekRule ClientGeometry Layer Workspace Skip Fullscreen PlaceNew FocusNew Focusable CfgDeny
syntax keyword pekRule ApplyOn Title Role Group Templates

" menu rules
syntax keyword pekRule Submenu Entry Actions Icon Separator

highlight def link pekString String
highlight def link pekComment Comment
highlight def link pekTodo Todo
highlight def link pekGroup Function
highlight def link pekRule Keyword

let b:current_syntax = 'pekwm'
