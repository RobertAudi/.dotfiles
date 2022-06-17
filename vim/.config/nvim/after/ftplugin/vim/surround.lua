-- Plugin: vim-surround
-- Description: Quoting/parenthesizing made simple
-- URL: https://github.com/tpope/vim-surround

vim.b["surround_" .. string.byte("i")] = "if \1if: \1 \r endif"
vim.b["surround_" .. string.byte("T")] = "try \r endtry"
