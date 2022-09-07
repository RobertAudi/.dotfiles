-- Module: 0x2a.plugins.dial.groups.visual
-- Plugin: monaqa/dial.nvim
-- Description: Enhanced increment/decrement plugin for Neovim
-- URL: https://github.com/monaqa/dial.nvim

local augend = require("dial.augend")

return {
  augend.case.new({
    types = { "camelCase", "snake_case", "kebab-case", "PascalCase", "SCREAMING_SNAKE_CASE" },
    cyclic = true,
  }),

  augend.constant.new({ elements = { "true", "false" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "TRUE", "FALSE" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "and", "or" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "AND", "OR" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "yes", "no" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "YES", "NO" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "show", "hide" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "min", "max" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "minimum", "maximum" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "asc", "desc" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "ASC", "DESC" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "ascending", "descending" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "horizontal", "vertical" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "&&", "||" }, word = false, cyclic = true }),
  augend.constant.new({ elements = { "!=", "==" }, word = false, cyclic = true }),
  augend.constant.new({ elements = { "!==", "===" }, word = false, cyclic = true }),
}
