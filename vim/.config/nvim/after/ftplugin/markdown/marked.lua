-- Plugin: vim-marked
-- Description: Open the current Markdown buffer in Marked.app
-- URL: https://github.com/itspriddle/vim-marked

vim.keymap.set(
  "n",
  "<Leader>p",
  "<Cmd>MarkedOpen<CR>",
  { buffer = true, noremap = true, desc = "Preview file in Marked" }
)
