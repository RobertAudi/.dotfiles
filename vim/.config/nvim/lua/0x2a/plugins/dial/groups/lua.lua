-- Module: 0x2a.plugins.dial.groups.lua
-- Plugin: monaqa/dial.nvim
-- Description: Enhanced increment/decrement plugin for Neovim
-- URL: https://github.com/monaqa/dial.nvim

local augend = require("dial.augend")

return {
  augend.case.new({
    types = { "camelCase", "snake_case", "PascalCase", "SCREAMING_SNAKE_CASE" },
    cyclic = true,
  }),

  augend.constant.new({ elements = { "true", "false" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "and", "or" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "min", "max" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "minimum", "maximum" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "ascending", "descending" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "horizontal", "vertical" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "==", "~=" }, word = false, cyclic = true }),
  augend.constant.new({ elements = { ":append", ":prepend", ":remove" }, word = false, cyclic = true }),
  augend.constant.new({ elements = { "vim.opt.", "vim.opt_local.", "vim.opt_global." }, word = false, cyclic = true }),
}
