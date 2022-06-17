-- Consider `!` and `?` as part of a word text object.
vim.opt_local.iskeyword:append({ "!", "?" })

-- `,` is NEVER a keyword. WTF!
vim.opt_local.iskeyword:remove({ "," })

vim.cmd([[iabbrev <buffer> #! #!/usr/bin/env ruby<CR><C-O>:normal "_cc<CR>]])
