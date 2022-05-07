-- Module: 0x2a.notifications
-- Requires:
--   - 0x2a.symbols
--   - 0x2a.utils
--   - 0x2a.utils.string
--   - rcarriga/nvim-notify

local symbols = require("0x2a.symbols")
local utils = require("0x2a.utils")
local string_utils = require("0x2a.utils.string")
local notify = require("notify")

local M = {}

local function normalize_options(message, notification_type, opts)
  message = message or ""
  notification_type = notification_type or "info"
  opts = utils.normalize_options(opts)

  if not opts.title or opts.title == "" then
    opts.title = string_utils.capitalize_first(notification_type)
  end

  if notification_type == "error" and message == "" then
    message = "Something went wrong"
  end

  if not utils.table_has_value(opts, "render") and message == "" and opts.title ~= "" then
    message = opts.title
    opts.render = require("0x2a.notify.render.minimal")
  end

  return message, opts
end

M.error = function(message, opts)
  message, opts = normalize_options(message, "error", opts)

  notify(message, "error", opts)
end

M.warning = function(message, opts)
  message, opts = normalize_options(message, "warning", opts)

  notify(message, "warn", opts)
end

M.warn = M.warning

M.debug = function(message, opts)
  message, opts = normalize_options(message, "debug", opts)

  notify(message, "debug", opts)
end

M.trace = function(message, opts)
  message, opts = normalize_options(message, "trace", opts)

  notify(message, "trace", opts)
end

M.info = function(message, opts)
  message, opts = normalize_options(message, "info", opts)

  notify(message, "info", opts)
end

M.success = function(message, opts)
  message, opts = normalize_options(message, "success", opts)

  opts.icon = opts.icon or symbols.codicon.SUCCESS

  notify(message, "info", opts)
end

--- Display a notification to the user.
---
--- This function can be overridden by plugins to display notifications using a
--- custom provider (such as the system notification provider). By default,
--- writes to |:messages|.
---
---@param msg string Content of the notification to show to the user.
---@param level number|nil One of the values from |vim.log.levels|.
---@param opts table|nil Optional parameters. Unused by default.
M.provider = function(msg, level, opts)
  local summary = msg:sub(1, 30)

  if msg:len() > 30 then
    summary = summary .. "…"
  end

  if level == vim.log.levels.ERROR then
    M.error(summary, { title = "An error occurred. See :messages for details" })
    vim.api.nvim_err_writeln(msg)
  elseif level == vim.log.levels.WARN then
    M.warning(summary)
    vim.api.nvim_echo({ { msg, "WarningMsg" } }, true, {})
  else
    M.info(summary)
    vim.api.nvim_echo({ { msg } }, true, {})
  end
end

return M
