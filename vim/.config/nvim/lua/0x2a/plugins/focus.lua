-- Module: focus
-- Plugin: focus.lua
-- Description: Auto-Focusing and Auto-Resizing Splits/Windows
-- URL: https://github.com/beauwilliams/focus.nvim

local M = {}

M.config = function()
  require("focus").setup({
    number = false,
    signcolumn = false,
    excluded_filetypes = {
      "NvimTree",
      "Trouble",
      "aerial",
      "TelescopePrompt",
      "TelescopeResults",
      "toggleterm",
      "ctrlsf",
      "packer",
      "diff",
      "help",
      "qf",
      "man",
      "git",
      "gitblame",
      "gitcommit",
      "gitrebase",
    },

    excluded_buftypes = {
      "help",
      "nofile",
      "prompt",
      "popup",
      "terminal",
      "acwrite",
      "qf",
    },
  })
end

return M
