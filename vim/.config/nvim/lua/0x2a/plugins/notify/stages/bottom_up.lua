-- Module: 0x2a.plugins.notify.stages.bottom_up
-- Description: This is the same stage as the default "slide" stage
--              The only difference is the stages_util.DIRECTION.BOTTOM_UP
--              passed to the until function to get the next available row on the screen.
-- Source: https://github.com/rcarriga/nvim-notify/issues/94#issuecomment-1146777125
-- Requires:
--   - rcarriga/nvim-notify

local stages_util = require("notify.stages.util")

return {
  function(state)
    local next_height = state.message.height + 2
    local next_row = stages_util.available_slot(state.open_windows, next_height, stages_util.DIRECTION.BOTTOM_UP) - 2

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
