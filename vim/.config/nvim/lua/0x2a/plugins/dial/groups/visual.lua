-- Module: 0x2a.plugins.dial.groups.visual
-- Plugin: monaqa/dial.nvim
-- Description: Enhanced increment/decrement plugin for Neovim
-- URL: https://github.com/monaqa/dial.nvim

local augend = require("dial.augend")

return {
  augend.integer.alias.decimal,
  augend.date.alias["%Y/%m/%d"],
}
