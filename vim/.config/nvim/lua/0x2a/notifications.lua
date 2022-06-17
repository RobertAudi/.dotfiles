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

local instances = {}

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

local instance = function(stages)
  if not stages then
    return
  end

  if instances[stages] then
    return instances[stages]
  end

  local ok, custom_stages = pcall(require, "0x2a.plugins.notify.stages." .. stages)

  if ok then
    instances[stages] = notify.instance({ stages = custom_stages }, true)
  end

  return instances[stages]
end

M.notify = function(message, level, opts, stages)
  message, opts = normalize_options(message, level, opts)

  local notify_instance = instance(stages)

  if notify_instance then
    notify_instance.notify(message, level, opts)
  else
    notify(message, level, opts)
  end
end

M.fatal = function(message, opts, stages)
  message, opts = normalize_options(message, "error", opts)

  local notify_instance = instance(stages)

  if notify_instance then
    notify_instance.notify(message, "error", opts)
  else
    notify(message, "error", opts)
  end

  vim.defer_fn(function()
    vim.api.nvim_err_writeln(message)
  end, 100)
end

M.error = function(message, opts, stages)
  message, opts = normalize_options(message, "error", opts)

  local notify_instance = instance(stages)

  if notify_instance then
    notify_instance.notify(message, "error", opts)
  else
    notify(message, "error", opts)
  end

  vim.defer_fn(function()
    vim.api.nvim_echo({ { message, "WarningMsg" } }, true, {})
  end, 100)
end

M.warning = function(message, opts, stages)
  message, opts = normalize_options(message, "warning", opts)

  local notify_instance = instance(stages)

  if notify_instance then
    notify_instance.notify(message, "warn", opts)
  else
    notify(message, "warn", opts)
  end

  vim.defer_fn(function()
    vim.api.nvim_echo({ { message, "WarningMsg" } }, true, {})
  end, 100)
end

M.warn = M.warning

M.debug = function(message, opts, stages)
  message, opts = normalize_options(message, "debug", opts)

  local notify_instance = instance(stages)

  if notify_instance then
    notify_instance.notify(message, "debug", opts)
  else
    notify(message, "debug", opts)
  end

  vim.defer_fn(function()
    vim.api.nvim_echo({ { message } }, true, {})
  end, 100)
end

M.trace = function(message, opts, stages)
  message, opts = normalize_options(message, "trace", opts)

  local notify_instance = instance(stages)

  if notify_instance then
    notify_instance.notify(message, "trace", opts)
  else
    notify(message, "trace", opts)
  end

  vim.defer_fn(function()
    vim.api.nvim_echo({ { message } }, true, {})
  end, 100)
end

M.info = function(message, opts, stages)
  message, opts = normalize_options(message, "info", opts)

  local notify_instance = instance(stages)

  if notify_instance then
    notify_instance.notify(message, "info", opts)
  else
    notify(message, "info", opts)
  end

  vim.defer_fn(function()
    vim.api.nvim_echo({ { message } }, true, {})
  end, 100)
end

M.success = function(message, opts)
  message, opts = normalize_options(message, "success", opts)
  opts.icon = opts.icon or symbols.codicon.SUCCESS
  notify(message, "info", opts)

  vim.defer_fn(function()
    vim.api.nvim_echo({ { message } }, true, {})
  end, 100)
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
    M.notify(summary, "error", { title = "An error occurred. See :messages for details" })

    vim.defer_fn(function()
      vim.api.nvim_err_writeln(msg)
    end, 100)
  elseif level == vim.log.levels.WARN then
    M.notify(summary, "warn")

    vim.defer_fn(function()
      vim.api.nvim_echo({ { msg, "WarningMsg" } }, true, {})
    end, 100)
  else
    M.notify(summary, "info")

    vim.defer_fn(function()
      vim.api.nvim_echo({ { msg } }, true, {})
    end, 100)
  end
end

return M
