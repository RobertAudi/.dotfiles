-- Word wrap without line breaks
vim.opt_local.wrap = false
vim.opt_local.linebreak = true
vim.opt_local.textwidth = 0
vim.opt_local.wrapmargin = 0
vim.opt_local.spell = true

vim.opt_local.formatoptions:remove({
  "t", -- Don't auto-wrap text using textwidth
  "l", -- Don't format long lines automatically
})

-- Headings with ease!
vim.keymap.set("n", "<LocalLeader>3", "I###<Space><Esc>", { buffer = true, noremap = true })
vim.keymap.set("n", "<LocalLeader>4", "I####<Space><Esc>", { buffer = true, noremap = true })
vim.keymap.set("n", "<LocalLeader>5", "I#####<Space><Esc>", { buffer = true, noremap = true })
vim.keymap.set("n", "<LocalLeader>6", "I######<Space><Esc>", { buffer = true, noremap = true })

-- ---
-- Stolen from gabrielelana/vim-markdown
--   https://github.com/gabrielelana/vim-markdown/blob/08e0731ce2c0b541ea335c782c59bb2e870730d4/ftplugin/markdown.vim#L159-L160
-- ---
vim.keymap.set({ "n", "v", "o" }, "][", "<Nop>", { buffer = true, silent = true, noremap = true })
vim.keymap.set({ "n", "v", "o" }, "[]", "<Nop>", { buffer = true, silent = true, noremap = true })
