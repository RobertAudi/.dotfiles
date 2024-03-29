-- Plugin: akinsho/toggleterm.nvim
-- Description: A neovim lua plugin to help easily manage multiple terminal windows
-- URL: https://github.com/akinsho/toggleterm.nvim

vim.keymap.set("n", "q", "<Cmd>ToggleTerm<CR>", { buffer = true, noremap = true })
vim.keymap.set("n", "<Esc>", "<Cmd>ToggleTerm<CR>", { buffer = true, noremap = true })
vim.keymap.set("t", "<C-t>", "<Cmd>ToggleTerm<CR>", { buffer = true, noremap = true })
