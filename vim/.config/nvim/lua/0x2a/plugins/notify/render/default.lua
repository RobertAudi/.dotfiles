-- Module: 0x2a.plugins.notify.renderer.default
-- Description: This is the default renderer that comes with the plugin with
--              the following extra features:
--              - Use the (custom) minimal renderer if there is no title
--              - Add word wrap to the message
--              - Add padding around the message
-- Source: https://github.com/rcarriga/nvim-notify/blob/7fed925c82f6c199728ebed91fae1edb3b62dc17/lua/notify/render/default.lua
-- Requires:
--   - 0x2a.utils
--   - rcarriga/nvim-notify
--   - 0x2a.plugins.notify.utils

local config = require("notify.config")
local base = require("notify.render.base")
local wrap = require("0x2a.plugins.notify.utils").wrap
local is_empty = require("0x2a.utils").is_empty

return function(bufnr, notif, highlights)
  if is_empty(notif.title[1]) then
    return require("0x2a.plugins.notify.render.minimal")(bufnr, notif, highlights)
  end

  notif.message = wrap(notif)

  local left_icon = notif.icon .. " "
  local max_message_width = math.max(math.max(unpack(vim.tbl_map(function(line)
    return vim.fn.strchars(line)
  end, notif.message))))

  local right_title = notif.title[2]
  local left_title = notif.title[1]
  local title_accum = vim.str_utfindex(left_icon) + vim.str_utfindex(right_title) + vim.str_utfindex(left_title)

  local left_buffer = string.rep(" ", math.max(0, max_message_width - title_accum))

  local namespace = base.namespace()

  vim.api.nvim_buf_set_lines(bufnr, 0, 1, false, { "", "" })
  vim.api.nvim_buf_set_extmark(bufnr, namespace, 0, 0, {
    virt_text = {
      { " " },
      { left_icon, highlights.icon },
      { left_title .. left_buffer, highlights.title },
    },

    virt_text_win_col = 0,
    priority = 10,
  })

  vim.api.nvim_buf_set_extmark(bufnr, namespace, 0, 0, {
    virt_text = { { " " }, { right_title, highlights.title }, { " " } },
    virt_text_pos = "right_align",
    priority = 10,
  })

  vim.api.nvim_buf_set_extmark(bufnr, namespace, 1, 0, {
    virt_text = {
      {
        string.rep("━", math.max(vim.str_utfindex(left_buffer) + title_accum + 2, config.minimum_width())),
        highlights.border,
      },
    },

    virt_text_win_col = 0,
    priority = 10,
  })

  vim.api.nvim_buf_set_lines(bufnr, 2, -1, false, notif.message)
  vim.api.nvim_buf_set_extmark(bufnr, namespace, 2, 0, {
    hl_group = highlights.body,
    end_line = 1 + #notif.message,
    end_col = #notif.message[#notif.message],
  })
end
