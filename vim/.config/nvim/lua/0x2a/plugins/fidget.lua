-- Module: 0x2a.plugins.fidget
-- Plugin: j-hui/fidget.nvim
-- Description: Standalone UI for nvim-lsp progress
-- URL: https://github.com/j-hui/fidget.nvim

local M = {}

M.config = function()
  require("fidget").setup({
    text = {
      spinner = "dots",
      done = require("0x2a.symbols").done,
    },

    sources = {
      ["null-ls"] = {
        ignore = true,
      },
    },
  })
end

return M
