-- Module: 0x2a.abolish
-- Requires:
--   - 0x2a.utils

local utils = require("0x2a.utils")

local M = {}

--- Bulk command abbreviations
---
--- @param input the command to abbreviate
--- @param ... abbreviations
--- @usage command("wqa", "Wqa", "WQa", "WQA")
M.command = function(input, ...)
  local cmd = [[cnoreabbrev %s <C-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "%s" : %s<CR>]]

  for _, abbreviation in pairs({ ... }) do
    vim.cmd(cmd:format(abbreviation, input, abbreviation))
  end
end

return M
