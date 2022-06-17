-- Module: 0x2a.theme.utils

local M = {}

M.highlight = function(group, definitions)
  vim.api.nvim_set_hl(0, group, definitions)
end

M.use = function(name)
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end

  require("0x2a.colors.themes." .. name)
end

return M
