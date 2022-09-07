-- Module: 0x2a.plugins.dial.groups.vim
-- Plugin: monaqa/dial.nvim
-- Description: Enhanced increment/decrement plugin for Neovim
-- URL: https://github.com/monaqa/dial.nvim

local augend = require("dial.augend")

return {
  augend.case.new({ types = { "camelCase", "snake_case", "PascalCase" }, cyclic = true }),

  augend.constant.new({ elements = { "&&", "||" }, word = false, cyclic = true }),

  augend.constant.new({ elements = { "g:", "b:", "l:", "s:" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "v:true", "v:false" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "<special>", "<silent>", "<buffer>", "<expr>" }, word = true, cyclic = true }),

  augend.constant.new({
    elements = { "map", "nmap", "imap", "vmap", "smap", "xmap", "cmap", "omap" },
    word = true,
    cyclic = true,
  }),

  augend.constant.new({
    elements = { "noremap", "nnoremap", "inoremap", "vnoremap", "snoremap", "xnoremap", "cnoremap", "onoremap" },
    word = true,
    cyclic = true,
  }),

  augend.constant.new({
    elements = { "unmap", "nunmap", "iunmap", "vunmap", "sunmap", "xunmap", "cunmap", "ounmap" },
    word = true,
    cyclic = true,
  }),
}
