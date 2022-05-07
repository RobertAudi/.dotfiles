-- Module: 0x2a.plugins.notify.stages.slide
-- Description: This is the same stage as the default "slide" stage
--              that comes with the plugin but it adds a small margin
--              to the right of the notification
-- Source: https://github.com/rcarriga/nvim-notify/blob/7fed925c82f6c199728ebed91fae1edb3b62dc17/lua/notify/stages/slide.lua
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
      width = 1,
      height = state.message.height,
      col = vim.opt.columns:get() - 2,
      row = next_row,
      border = "rounded",
      style = "minimal",
    }
  end,

  function(state)
    return {
      width = { state.message.width, frequency = 2 },
      col = { vim.opt.columns:get() - 2 },
    }
  end,

  function()
    return {
      col = { vim.opt.columns:get() - 2 },
      time = true,
    }
  end,

  function()
    return {
      width = {
        1,
        frequency = 2.5,
        damping = 0.9,
        complete = function(cur_width)
          return cur_width < 2
        end,
      },

      col = { vim.opt.columns:get() - 2 },
    }
  end,
}
