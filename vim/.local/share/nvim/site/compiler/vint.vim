" Source: https://sanctum.geek.nz/cgit/dotfiles.git
"         https://sanctum.geek.nz/cgit/dotfiles.git/tree/vim/compiler/vint.vim
"
" :compiler support for Vim script linting with Vint
" <https://github.com/Kuniwak/vint>
if exists('current_compiler') || &compatible || !has('patch-7.4.191')
  finish
endif
let current_compiler = 'vimlint'

CompilerSet makeprg=vint\ --\ %:S
CompilerSet errorformat=%f:%l:%c:\ %m
