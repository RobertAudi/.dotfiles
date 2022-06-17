-- Plugin: vim-surround
-- Description: Quoting/parenthesizing made simple
-- URL: https://github.com/tpope/vim-surround

vim.b["surround_" .. string.byte("#")] = "#{\r}"
vim.b["surround_" .. string.byte("i")] = "if \1if: \1 \r end"
vim.b["surround_" .. string.byte("u")] = "unless \1unless: \1 \r end"
vim.b["surround_" .. string.byte("m")] = "module \1module: \1 \r end"

vim.b.surround_indent = true
