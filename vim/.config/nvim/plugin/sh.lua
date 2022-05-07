-- Shell scripts are Bash by default
vim.g.is_bash = true

-- Assume POSIX by default, not original Bourne shell
vim.g.is_posix = true

-- Make sure that the shell scripts are properly highlighted.
vim.g.bash_is_sh = true

-- syntax/sh.vim adds `.` to iskeyword(verify with :verbose set iskeyword?).
-- So `w` jumps past it. see :h g:sh_isk
vim.g.sh_noisk = true

-- Shell script syntax highlighting craps out on some closing parentheses etc?
vim.g.sh_no_error = true
