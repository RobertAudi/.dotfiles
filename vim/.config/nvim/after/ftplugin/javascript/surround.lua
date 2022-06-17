-- Plugin: vim-surround
-- Description: Quoting/parenthesizing made simple
-- URL: https://github.com/tpope/vim-surround

vim.b["surround_" .. string.byte("$")] = "$(\r)"
vim.b["surround_" .. string.byte("c")] = "console.log(\r)"
