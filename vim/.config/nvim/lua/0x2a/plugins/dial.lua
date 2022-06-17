-- Module: 0x2a.plugins.dial.lua
-- Plugin: monaqa/dial.nvim
-- Description: Enhanced increment/decrement plugin for Neovim
-- URL: https://github.com/monaqa/dial.nvim

local M = {}

M.config = function()
  local augend = require("dial.augend")

  require("dial.config").augends:register_group({
    default = {
      augend.integer.alias.decimal,
      augend.date.alias["%Y/%m/%d"],
    },

    visual = {
      augend.integer.alias.decimal,
      augend.date.alias["%Y/%m/%d"],
    },

    switch = {
      augend.constant.new({
        elements = { "true", "false" },
        word = true,
        cyclic = true,
      }),

      augend.constant.new({
        elements = { "TRUE", "FALSE" },
        word = true,
        cyclic = true,
      }),

      augend.constant.new({
        elements = { "and", "or" },
        word = true,
        cyclic = true,
      }),

      augend.constant.new({
        elements = { "AND", "OR" },
        word = true,
        cyclic = true,
      }),

      augend.constant.new({
        elements = { "show", "hide" },
        word = true,
        cyclic = true,
      }),

      augend.constant.new({
        elements = { "min", "max" },
        word = true,
        cyclic = true,
      }),

      augend.constant.new({
        elements = { "&&", "||" },
        word = false,
        cyclic = true,
      }),

      augend.constant.new({
        elements = { "!=", "==" },
        word = true,
        cyclic = true,
      }),

      augend.constant.new({
        elements = { "!==", "===" },
        word = true,
        cyclic = true,
      }),
    },
  })

  local dial_map = require("dial.map")

  vim.keymap.set("n", "<C-a>", dial_map.inc_normal(), { noremap = true })
  vim.keymap.set("n", "<C-x>", dial_map.dec_normal(), { noremap = true })

  vim.keymap.set("n", "[s", dial_map.inc_normal("switch"), { noremap = true })
  vim.keymap.set("n", "]s", dial_map.dec_normal("switch"), { noremap = true })

  vim.keymap.set("v", "<C-a>", dial_map.inc_visual(), { noremap = true })
  vim.keymap.set("v", "<C-x>", dial_map.dec_visual(), { noremap = true })
  vim.keymap.set("v", "g<C-a>", dial_map.inc_gvisual(), { noremap = true })
  vim.keymap.set("v", "g<C-x>", dial_map.dec_gvisual(), { noremap = true })
end

return M
