-- Module: 0x2a.plugins.dial.groups.javascript
-- Plugin: monaqa/dial.nvim
-- Description: Enhanced increment/decrement plugin for Neovim
-- URL: https://github.com/monaqa/dial.nvim

local augend = require("dial.augend")

return {
  augend.case.new({ types = { "camelCase", "snake_case", "kebab-case", "PascalCase" }, cyclic = true }),

  augend.constant.new({ elements = { "true", "false" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "&&", "||" }, word = false, cyclic = true }),

  augend.constant.new({ elements = { "addClass", "removeClass", "toggleClass" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "let", "const", "var" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "===", "!==" }, word = false, cyclic = true }),
}
