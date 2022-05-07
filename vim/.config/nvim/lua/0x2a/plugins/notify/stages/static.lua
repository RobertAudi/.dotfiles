-- Module: 0x2a.plugins.notify.stages.static
-- Description: This is the same stage as the "static" stage
--              that comes with the plugin but it adds a small margin
--              to the right of the notification
-- Source: https://github.com/rcarriga/nvim-notify/blob/2c8f744de34c72a5a1fabcc66da11aa017ffab88/lua/notify/stages/static.lua
-- Requires:
--   - rcarriga/nvim-notify

local stages_util = require("notify.stages.util")

return {
  function(state)
    local next_height = state.message.height + 2
    local next_row = stages_util.available_slot(state.open_windows, next_height, stages_util.DIRECTION.TOP_DOWN)

    if not next_row then
      return nil
    end

    return {
      relative = "editor",
      anchor = "NE",
      width = state.message.width,
      height = state.message.height,
      col = vim.opt.columns:get() - 2,
      row = next_row,
      border = "rounded",
      style = "minimal",
    }
  end,

  function()
    return {
      col = { vim.opt.columns:get() - 2 },
      time = true,
    }
  end,
}
