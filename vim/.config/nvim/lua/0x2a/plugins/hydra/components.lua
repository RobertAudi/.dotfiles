-- Module: 0x2a.plugins.hydra.components
-- Requires:
--   - 0x2a.utils
--   - 0x2a.utils.string
--   - 0x2a.plugins.hydra.utils

local utils = require("0x2a.utils")
local string_utils = require("0x2a.utils.string")
local hydra_utils = require("0x2a.plugins.hydra.utils")

local M = {}

M.dismiss = function(opts)
  opts = utils.normalize_options(opts)

  vim.validate({
    key = { opts.key, { "string", "nil" } },
    title = { opts.title, { "string", "nil" } },
    callback = { opts.callback, { "function", "string", "nil" } },
    pad = { opts.pad, { "table", "nil" } },
  })

  local key = utils.if_nil(opts.key, "<Esc>", opts.key)
  local title = utils.if_nil(opts.title, "Dismiss", opts.title)

  local hint_format_string = "^   _%s_"

  if utils.is_present(title) then
    hint_format_string = hint_format_string .. ": %s"
  end

  hint_format_string = hint_format_string .. "   ^"

  local hint = string.format(hint_format_string, key, title)

  if opts.pad then
    hint = hydra_utils.pad_hint(hint, opts.pad)
  end

  return {
    hint = string_utils.trim_lines(hint),
    head = { key, opts.callback, { exit = true, nowait = true, desc = title } },
  }
end

M.control_center = function(opts)
  opts = utils.normalize_options(opts)

  vim.validate({
    key = { opts.key, { "string", "nil" } },
    pad = { opts.pad, { "table", "nil" } },
  })

  local key = utils.if_nil(opts.key, "<BS>", opts.key)
  local title = "Control Center"
  local hint = string.format("^   _%s_: %s   ^", key, title)
  local callback = function()
    hydra_utils.activate("control-center")
  end

  if opts.pad then
    hint = hydra_utils.pad_hint(hint, opts.pad)
  end

  return {
    hint = string_utils.trim_lines(hint),
    head = { key, callback, { exit = true, nowait = true, desc = title } },
  }
end

return M
