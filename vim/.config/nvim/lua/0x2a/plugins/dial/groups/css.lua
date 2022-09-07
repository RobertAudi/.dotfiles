-- Module: 0x2a.plugins.dial.groups.css
-- Plugin: monaqa/dial.nvim
-- Description: Enhanced increment/decrement plugin for Neovim
-- URL: https://github.com/monaqa/dial.nvim

local augend = require("dial.augend")

return {
  augend.constant.new({ elements = { "top", "bottom", "right", "left" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "margin", "padding" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "inline", "block", "inline-block", "flex", "none" }, word = true, cyclic = true }),
}
