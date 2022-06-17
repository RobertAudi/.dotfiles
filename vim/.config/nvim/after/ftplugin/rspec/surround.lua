-- Plugin: vim-surround
-- Description: Quoting/parenthesizing made simple
-- URL: https://github.com/tpope/vim-surround

vim.b["surround_" .. string.byte("#")] = "#{\r}"
vim.b["surround_" .. string.byte("d")] = "describe do \r end"
vim.b["surround_" .. string.byte("c")] = "context do \r end"

vim.b.surround_indent = true
