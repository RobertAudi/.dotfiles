vim.opt_local.iskeyword:remove({ "$" })

vim.cmd([[iabbrev <buffer> #! #!/usr/bin/env zsh<CR><C-O>:normal "_cc<CR>]])
