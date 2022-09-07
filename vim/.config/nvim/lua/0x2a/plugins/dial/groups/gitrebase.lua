-- Module: 0x2a.plugins.dial.groups.gitrebase
-- Plugin: monaqa/dial.nvim
-- Description: Enhanced increment/decrement plugin for Neovim
-- URL: https://github.com/monaqa/dial.nvim

local augend = require("dial.augend")

return {
  augend.constant.new({
    elements = { "pick", "reword", "edit", "squash", "fixup", "exec", "drop", "label", "reset", "merge" },
    word = true,
    cyclic = true,
  }),
}
