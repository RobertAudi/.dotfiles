" Assume POSIX by default, not original Bourne shell
let g:is_posix = 1

" Make sure that the shell scripts are properly highlighted.
let g:bash_is_sh = 1

" syntax/sh.vim adds `.` to iskeyword(verify with :verbose set iskeyword?).
" So `w` jumps past it. see :h g:sh_isk
let g:sh_noisk = 1

" Shell script syntax highlighting craps out on some closing parentheses etc?
let g:sh_no_error = 1
