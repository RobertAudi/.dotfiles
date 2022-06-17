-- Plugin: vim-surround
-- Description: Quoting/parenthesizing made simple
-- URL: https://github.com/tpope/vim-surround

vim.b["surround_" .. string.byte("*")] = "*\r*"
vim.b["surround_" .. string.byte("_")] = "_\r_"
vim.b["surround_" .. string.byte("i")] = "_\r_"
vim.b["surround_" .. string.byte("b")] = "**\r**"

-- Easy bold and italic
vim.keymap.set("x", "<C-b>", "Sb", { remap = true, buffer = true, desc = "Bold" })
vim.keymap.set("x", "<C-i>", "Si", { remap = true, buffer = true, desc = "Italic" })
