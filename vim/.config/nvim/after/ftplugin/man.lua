vim.o.timeoutlen = 0

vim.opt_local.keywordprg = ":man"
vim.opt_local.cursorline = false
vim.opt_local.readonly = true
vim.opt_local.modifiable = false
vim.opt_local.list = false
vim.opt_local.wrap = true
vim.opt_local.bufhidden = "hide"
vim.opt_local.colorcolumn = nil

vim.keymap.set("n", "q", "<Cmd>quit<CR>", { buffer = true, noremap = true, silent = true })
vim.keymap.set("n", "Q", "<Cmd>bwipeout!<CR>", { buffer = true, noremap = true, silent = true })

vim.keymap.set("n", "<CR>", "<C-]>", { buffer = true, remap = true, silent = true })
vim.keymap.set("n", "<CR>", "<Cmd>nohlsearch<Bar>echo<CR>", { buffer = true, remap = true, silent = true })

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
