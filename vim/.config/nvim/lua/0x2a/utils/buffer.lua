-- Module: 0x2a.utils.buffer

local M = {}

local original_guicursor = ""
-- hide_cursor will dynamically create the RACursorHide hi and
-- set the guicursor option to this hi group.
--
-- the RACursorHide hi has the same bg/fg as the CursorLine hi which
-- is used inside the LITEE.nvim windows.
--
-- this effectively hides the cursor by making it blend into the cursor
-- line.
--
-- hide : bool - if true hides the cursor if false sets the guicursor
-- option back to the value when Neovim started.
--
-- Source: https://github.com/ldelossa/litee.nvim/blob/2d257af35e90b1ee6017481b7fd82878d8f0e5ff/lua/litee/lib/util/buffer.lua#L4-L37
M.hide_cursor = function(hide)
  if original_guicursor == "" then
    for _, section in ipairs(vim.opt.guicursor:get()) do
      original_guicursor = original_guicursor .. section .. ","
    end
  end

  if not hide then
    vim.cmd("set guicursor=" .. original_guicursor)
    return
  end

  local colors_rgb = vim.api.nvim_get_hl_by_name("CursorLine", true)
  local colors_256 = vim.api.nvim_get_hl_by_name("CursorLine", false)
  local hi = string.format(
    "hi RACursorHide cterm=None ctermbg=%s ctermfg=%s gui=None guibg=%s guifg=%s",

    (function()
      if colors_256.background ~= nil then
        return colors_256.background
      else
        return "None"
      end
    end)(),

    (function()
      if colors_256.foreground ~= nil then
        return colors_256.foreground
      else
        return "None"
      end
    end)(),

    (function()
      if colors_rgb.background ~= nil then
        return string.format("#%x", colors_rgb.background)
      else
        return "None"
      end
    end)(),

    (function()
      if colors_rgb.foreground ~= nil then
        return string.format("#%x", colors_rgb.foreground)
      else
        return "None"
      end
    end)()
  )

  vim.cmd(hi)

  local cursorgui = "set guicursor=n:RACursorHide"

  vim.cmd(cursorgui)
end

return M
