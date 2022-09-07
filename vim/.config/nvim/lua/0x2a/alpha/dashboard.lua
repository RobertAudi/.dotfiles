-- Module: 0x2a.alpha.dashboard
-- Requires:
--   - 0x2a.utils
--   - 0x2a.utils.string
--   - 0x2a.utils.headers
--   - 0x2a.plugins.alpha.buttons

local utils = require("0x2a.utils")
local string_utils = require("0x2a.utils.string")
local headers = require("0x2a.utils.headers")
local buttons = require("0x2a.alpha.buttons")

local M = {}

local defaults = {
  header = string_utils.split(headers.h1("Neovim"), "\n"),
  buttons = {
    buttons.recent_files,
    buttons.file_tree,
    buttons.restore_session,
  },

  footer = false,
}

local normalize_string = function(item)
  local item_type = type(item)

  if item_type == "string" then
    return { item }
  elseif item_type == "function" then
    return item()
  else
    return item
  end
end

M.build = function(opts)
  opts = opts or {}

  local layout = {}

  table.insert(layout, { type = "padding", val = 2 })

  if opts.header ~= false then
    local header = normalize_string(opts.header) or defaults.header

    if header ~= false then
      table.insert(layout, {
        type = "text",
        val = header,
        opts = { position = "center", hl = "Type" },
      })
    end
  end

  table.insert(layout, { type = "padding", val = 2 })

  table.insert(layout, {
    type = "group",
    val = opts.buttons or defaults.buttons,
    opts = { spacing = 1 },
  })

  if opts.footer ~= false then
    local footer = normalize_string(opts.footer) or defaults.footer

    if footer ~= false then
      table.insert(layout, {
        type = "text",
        val = footer,
        opts = { position = "center", hl = "Number" },
      })
    end
  end

  return {
    layout = layout,
    opts = { margin = 5 },
  }
end

return M
