-- Module: 0x2a.plugins.notify
-- Plugin: rcarriga/nvim-notify
-- Description: A fancy, configurable, notification manager for NeoVim
-- URL: https://github.com/rcarriga/nvim-notify
-- Requires:
--   - 0x2a.symbols
--   - 0x2a.notifications
--   - 0x2a.plugins.notify.stages.static
--   - 0x2a.plugins.notify.render.default

local M = {}

M.config = function()
  local notify = prequire("notify")

  if not notify then
    return
  end

  local symbols = require("0x2a.symbols")

  notify.setup({
    stages = require("0x2a.plugins.notify.stages.static"),
    render = require("0x2a.plugins.notify.render.default"),

    max_width = function()
      return math.ceil(math.max(vim.opt.columns:get() / 3, 10))
    end,

    max_height = function()
      return math.ceil(math.max(vim.opt.lines:get() / 3, 4))
    end,

    timeout = 3000,

    icons = {
      ERROR = symbols.codicon.notifications.ERROR,
      WARN = symbols.codicon.notifications.WARNING,
      INFO = symbols.codicon.notifications.INFO,
      DEBUG = symbols.codicon.notifications.DEBUG,
      TRACE = symbols.codicon.notifications.TRACE,
    },
  })

  vim.notify = require("0x2a.notifications").provider
end

return M
