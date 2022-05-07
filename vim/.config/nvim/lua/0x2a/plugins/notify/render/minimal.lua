-- Module: 0x2a.plugins.notify.render.minimal
-- Description: This is the minimal renderer that comes with the plugin with
--              the following extra features:
--              - Add the icon to the left of the first line
--              - Add word wrap to the message
--              - Add padding around the message
-- Source: https://github.com/rcarriga/nvim-notify/blob/7fed925c82f6c199728ebed91fae1edb3b62dc17/lua/notify/render/minimal.lua
-- Requires:
--   - rcarriga/nvim-notify
--   - 0x2a.plugins.notify.utils

local base = require("notify.render.base")
local wrap = require("0x2a.plugins.notify.utils").wrap

return function(bufnr, notif, highlights)
  notif.message = wrap(notif, { icon = true })

  local namespace = base.namespace()

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, notif.message)

  vim.api.nvim_buf_set_extmark(bufnr, namespace, 0, 0, {
    hl_group = highlights.icon,
    end_line = #notif.message - 1,
    end_col = #notif.message[#notif.message],
  })
end
