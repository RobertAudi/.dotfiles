vim.opt_local.iskeyword:append({ ":", "#", "-" })

vim.opt_local.keywordprg = ":help"
vim.opt_local.cursorline = false
vim.opt_local.readonly = true
vim.opt_local.modifiable = false
vim.opt_local.list = false
vim.opt_local.wrap = true
vim.opt_local.bufhidden = "hide"
vim.opt_local.colorcolumn = nil

vim.opt_local.spell = false
vim.o.timeoutlen = 0

vim.fn["x2a#help#maps#enable"]()
