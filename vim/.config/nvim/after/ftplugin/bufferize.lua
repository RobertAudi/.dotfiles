vim.o.timeoutlen = 0

vim.keymap.set("n", "q", "<Cmd>quit<CR>", { buffer = true, noremap = true, silent = true })
vim.keymap.set("n", "Q", "<Cmd>bwipeout!<CR>", { buffer = true, noremap = true, silent = true })

vim.keymap.set("n", "<Space>", "<Cmd>nohlsearch<Bar>echo<CR>", { buffer = true, noremap = true, silent = true })
vim.keymap.set("n", "<S-Space>", "<Cmd>nohlsearch<Bar>echo<CR>", { buffer = true, noremap = true, silent = true })

vim.keymap.set(
  { "n", "v", "o" },
  "d",
  "<C-d>:call x2a#movements#window#CenterCursorAesthetically()<CR>",
  { buffer = true, noremap = true, silent = true }
)

vim.keymap.set(
  { "n", "v", "o" },
  "u",
  "<C-u>:call x2a#movements#window#CenterCursorAesthetically()<CR>",
  { buffer = true, noremap = true, silent = true }
)

vim.keymap.set(
  { "n", "v", "o" },
  "<Space>",
  "<C-d>:call x2a#movements#window#CenterCursorAesthetically()<CR>",
  { buffer = true, remap = true, silent = true }
)

vim.keymap.set(
  { "n", "v", "o" },
  "<S-Space>",
  "<C-u>:call x2a#movements#window#CenterCursorAesthetically()<CR>",
  { buffer = true, remap = true, silent = true }
)
