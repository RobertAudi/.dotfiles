-- Module: 0x2a.notifications
-- Requires:
--   - 0x2a.symbols
--   - 0x2a.utils
--   - 0x2a.utils.string
--   - 0x2a.utils.table
--   - rcarriga/nvim-notify

local notify = prequire("notify")

local symbols = require("0x2a.symbols")
local utils = require("0x2a.utils")
local table_utils = require("0x2a.utils.table")
local string_utils = require("0x2a.utils.string")
local log = require("0x2a.log")

local instances = {}

local M = {}

local function normalize_options(message, notification_type, opts)
  vim.validate({
    message = { message, { "string", "nil" } },
    notification_type = { notification_type, { "string", "nil" } },
    opts = { opts, { "table", "nil" } },
  })

  opts = utils.normalize_options(opts)

  vim.validate({
    title = { opts.title, { "string", "nil" } },
    echo = { opts.echo, { "string", "nil" } },
  })

  message = utils.if_blank(message, "", message)
  notification_type = utils.if_blank(notification_type, "info", notification_type)
  opts.title = utils.if_blank(opts.title, string_utils.capitalize_first(notification_type), opts.title)

  if notification_type == "error" and message == "" then
    message = "Something went wrong"
  end

  if not table_utils.has_value(opts, "render") and message == "" and opts.title ~= "" then
    message = opts.title
    opts.render = require("0x2a.notify.render.minimal")
  end

  local echo = opts.echo or message

  opts.echo = nil

  return message, echo, opts
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
  message, _, opts = normalize_options(message, level, opts)

  if notify then
    local notify_instance = instance(stages)

    if notify_instance then
      notify_instance.notify(message, level, opts)
    else
      notify(message, level, opts)
    end
  else
    log.fatal("The notify plugin is not available.")
  end
end

M.fatal = function(message, opts, stages)
  local echo = nil
  message, echo, opts = normalize_options(message, "error", opts)

  if notify then
    local notify_instance = instance(stages)

    if notify_instance then
      notify_instance.notify(message, "error", opts)
    else
      notify(message, "error", opts)
    end
  end

  log.fatal(echo or message)
end

M.error = function(message, opts, stages)
  local echo = nil
  message, echo, opts = normalize_options(message, "error", opts)

  local notify_instance = instance(stages)

  if notify then
    if notify_instance then
      notify_instance.notify(message, "error", opts)
    else
      notify(message, "error", opts)
    end
  end

  log.error(echo or message)
end

M.warning = function(message, opts, stages)
  local echo = nil
  message, echo, opts = normalize_options(message, "warning", opts)

  if notify then
    local notify_instance = instance(stages)

    if notify_instance then
      notify_instance.notify(message, "warn", opts)
    else
      notify(message, "warn", opts)
    end
  end

  log.warn(echo or message)
end

M.warn = M.warning

M.debug = function(message, opts, stages)
  local echo = nil
  message, echo, opts = normalize_options(message, "debug", opts)

  if notify then
    local notify_instance = instance(stages)

    if notify_instance then
      notify_instance.notify(message, "debug", opts)
    else
      notify(message, "debug", opts)
    end
  end

  log.debug(echo or message)
end

M.trace = function(message, opts, stages)
  local echo = nil
  message, echo, opts = normalize_options(message, "trace", opts)

  if notify then
    local notify_instance = instance(stages)

    if notify_instance then
      notify_instance.notify(message, "trace", opts)
    else
      notify(message, "trace", opts)
    end
  end

  log.trace(echo or message)
end

M.info = function(message, opts, stages)
  local echo = nil
  message, echo, opts = normalize_options(message, "info", opts)

  if notify then
    local notify_instance = instance(stages)

    if notify_instance then
      notify_instance.notify(message, "info", opts)
    else
      notify(message, "info", opts)
    end
  end

  log.info(echo or message)
end

M.success = function(message, opts)
  local echo = nil
  message, echo, opts = normalize_options(message, "success", opts)
  opts.icon = opts.icon or symbols.codicon.SUCCESS

  if notify then
    notify(message, "info", opts)
  end

  log.success(echo or message)
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
    log.fatal(msg)
  elseif level == vim.log.levels.WARN then
    M.notify(summary, "warn")
    log.warn(msg)
  else
    M.notify(summary, "info")
    log.print(msg)
  end
end

return M
