vim.opt_local.iskeyword:append({ "$" })

vim.cmd([[iabbrev <buffer> #! #!/usr/bin/env bash<CR><C-O>:normal "_cc<CR>]])
