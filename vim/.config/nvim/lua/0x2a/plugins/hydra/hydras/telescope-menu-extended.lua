-- Module: 0x2a.plugins.hydra.hydras.telescope-menu-extended
-- Plugin: anuvyklack/hydra.nvim
-- Description: Bind a bunch of key bindings together
--              Create custom submodes
-- URL: https://github.com/anuvyklack/hydra.nvim
-- Requires:
--   - 0x2a.utils.string
--   - 0x2a.utils.table
--   - 0x2a.plugins.hydra.utils
--   - 0x2a.plugins.hydra.components
--   - nvim-telescope/telescope.nvim
--   - axieax/urlview.nvim

local Hydra = require("hydra")
local string_utils = require("0x2a.utils.string")
local table_utils = require("0x2a.utils.table")
local hydra_utils = require("0x2a.plugins.hydra.utils")
local components = require("0x2a.plugins.hydra.components")
local pickers = require("0x2a.plugins.hydra.pickers")

local M = {}

M.hint = string_utils.trim_lines([[
  ^   _u_: URLs          _S_: Symbols
  ^   _R_: Registers     _'_: Marks
  ^
  ^   _h_: Vim help      _m_: Man pages  ^
]])

M.heads = {
  { "u", pickers.urlview(), { desc = "URLs" } },
  { "R", pickers.builtin("registers") },
  { "S", pickers.builtin("symbols"), { desc = "Symbols" } },
  { "'", pickers.builtin("marks"), { desc = "Marks" } },
  { "h", pickers.builtin("help_tags"), { desc = "Vim help" } },
  { "m", pickers.builtin("man_pages"), { desc = "Man pages" } },
}

M.setup = function()
  local telescope_menu = require("0x2a.plugins.hydra.hydras.telescope-menu")
  local dismiss = components.dismiss({ pad = { around = 1 } })
  local show_less = components.dismiss({
    key = "<Space>",
    title = "Show less",
    pad = { top = 1 },
    callback = function()
      hydra_utils.activate("telescope-menu")
    end,
  })

  local hint = telescope_menu.hint .. "\n^\n" .. M.hint

  hint = hydra_utils.prepend_header(hint, "[Pickers]")
  hint = table.concat({ hint, show_less.hint, dismiss.hint }, "\n")

  local heads = table_utils.append(telescope_menu.heads, M.heads)
  heads = table_utils.append(heads, { show_less.head, dismiss.head })

  M.hydra = Hydra({
    name = "Telescope menu",
    hint = hint,
    config = {
      color = "teal",
      invoke_on_body = true,
      hint = {
        position = "middle",
        border = "single",
      },
    },

    mode = "n",
    heads = heads,
  })

  return M.hydra
end

return M
