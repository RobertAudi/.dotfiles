-- Module: 0x2a.plugins.hydra.hydras.telescope-menu
-- Plugin: anuvyklack/hydra.nvim
-- Description: Bind a bunch of key bindings together
--              Create custom submodes
-- URL: https://github.com/anuvyklack/hydra.nvim
-- Requires:
--   - 0x2a.utils.string
--   - 0x2a.utils.table
--   - 0x2a.utils.fs
--   - 0x2a.plugins.hydra.utils
--   - 0x2a.plugins.hydra.components
--   - nvim-telescope/telescope.nvim
--   - axieax/urlview.nvim

local Hydra = require("hydra")
local fsutils = require("0x2a.utils.fs")
local string_utils = require("0x2a.utils.string")
local table_utils = require("0x2a.utils.table")
local hydra_utils = require("0x2a.plugins.hydra.utils")
local components = require("0x2a.plugins.hydra.components")
local pickers = require("0x2a.plugins.hydra.pickers")

local M = {}

M.hint = string_utils.trim_lines([[
  ^   _f_: Files         _s_: Sandbox  ^
  ^   _o_: Old files
  ^
  ^   _g_: Git status    _G_: Git
  ^   _c_: Conflicts
]])

M.heads = {
  { "f", pickers.builtin("find_files") },
  { "o", pickers.builtin("oldfiles", { cwd_only = true }), { desc = "Recently opened files" } },
  { "g", pickers.builtin("git_status") },
  {
    "G",
    function()
      require("0x2a.plugins.hydra.hydras.git").activate()
    end,
  },

  { "c", pickers.conflicts(), { desc = "Git conflicts" } },
}

if fsutils.in_dotfiles_directory() then
  table.insert(M.heads, { "s", pickers.sandbox(), { desc = "Sandbox files" } })
else
  M.hint = hydra_utils.remove_head_from_hint(M.hint, "s", "Sandbox")
end

M.setup = function()
  local dismiss = components.dismiss({ pad = { around = 1 } })
  local show_more = components.dismiss({
    key = "<Space>",
    title = "Show more",
    pad = { top = 1 },
    callback = function()
      hydra_utils.activate("telescope-menu-extended")
    end,
  })

  local hint = table.concat({ M.hint, show_more.hint, dismiss.hint }, "\n")
  hint = hydra_utils.prepend_header(hint, "[Pickers]")

  local heads = table_utils.append(M.heads, {
    show_more.head,
    dismiss.head,
  })

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
    body = "<Space>",
    heads = heads,
  })

  return M.hydra
end

return M
