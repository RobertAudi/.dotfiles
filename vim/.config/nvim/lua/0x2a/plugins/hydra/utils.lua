-- Module: 0x2a.plugins.hydra.utils
-- Plugin: anuvyklack/hydra.nvim
-- Description: Bind a bunch of key bindings together
--              Create custom submodes
-- URL: https://github.com/anuvyklack/hydra.nvim
-- Requires:
--   - 0x2a.utils
--   - 0x2a.utils.string

local M = {}

M.activate = function(hydra)
  require("0x2a.plugins.hydra.hydras." .. hydra).hydra:activate()
end

M.remove_head_from_hint = function(hint, key, label)
  vim.validate({
    hint = { hint, "string" },
    key = { key, "string" },
    label = { label, "string" },
  })

  local head = "_" .. key .. "_: " .. label

  return hint:gsub(head, string.rep(" ", vim.fn.strdisplaywidth(head) - 2))
end

M.prepend_header = function(hint, header)
  vim.validate({
    hint = { hint, "string" },
    header = { header, "string" },
  })

  local utils = require("0x2a.utils")
  local string_utils = require("0x2a.utils.string")

  local longest_line = utils.longest_line(hint)
  local number_of_underscores = string_utils.count(longest_line.contents, "_")
  local longest_line_length = math.max(utils.longest_line(hint).length - number_of_underscores - 1, 0)
  local header_length = vim.fn.strdisplaywidth(header)

  local padding = math.floor(longest_line_length / 2) - math.floor(header_length / 2)
  padding = math.max(padding, 0)

  return "^" .. string.rep(" ", padding) .. header .. "\n^\n" .. hint
end

-- TODO: Add left and right pads
M.pad_hint = function(hint, values)
  local utils = require("0x2a.utils")
  local string_utils = require("0x2a.utils.string")
  local table_utils = require("0x2a.utils.table")

  vim.validate({
    hint = { hint, "string" },
    values = { values, "table" }
  })

  vim.validate({
    around = { values.around, { "number", "nil" } },
    top = { values.top, { "number", "nil" } },
    bottom = { values.bottom, { "number", "nil" } },
    values = {
      values,
      function(val)
        if utils.is_present(val.around) and (utils.is_present(val.top) or utils.is_present(val.bottom)) then
          return false
        end

        local valuescount = table_utils.len(values)

        if valuescount < 1 or valuescount > 2 then
          return false
        end

        if utils.is_present(table_utils.subtract(table_utils.keys(val), { "around", "top", "bottom" })) then
          return false
        end

        return true
      end
    },
  })

  if values.around then
    return "^\n" .. hint .. "\n^"
  end

  if values.top then
    hint = "^\n" .. hint
  end

  if values.bottom then
    hint = hint .. "\n^"
  end

  return hint
end

return M
