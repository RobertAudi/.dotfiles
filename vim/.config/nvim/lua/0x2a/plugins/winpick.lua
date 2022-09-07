-- Module: 0x2a.plugins.winpick.nvim
-- Plugin: gbrlsnchs/winpick.nvim
-- Description: PLUGIN DESCRIPTION
-- URL: https://github.com/gbrlsnchs/winpick.nvim
-- Requires:
--   - ...

local M = {}

M.config = function()
  local winpick = prequire("winpick")

  if not winpick then
    return
  end

  winpick.setup({
    border = "single",
    filter = winpick.defaults.filter, -- filters preview window and quickfix
    prompt = "Pick a window: ",
    format_label = function(label, winID)
      return label
    end, -- formatted as "<label>: <buffer name>"
  })
end

return M
