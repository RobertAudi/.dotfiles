-- Module: 0x2a.plugins.luasnip.utils
-- Requires:
--   - L3MON4D3/LuaSnip

local M = {}

M.TM_FILENAME = function()
  return function(_, snip)
    return snip.env.TM_FILENAME
  end
end

M.CLIPBOARD = function(options)
  local clipboard = vim.fn.getreg("*", 1, true)[1]

  if not clipboard or clipboard == "" then
    clipboard = vim.fn.getreg("+", 1, true)[1]
  end

  if not clipboard then
    return ""
  elseif type(options) == "table" and options.strip then
    clipboard = string.gsub(clipboard, "%s+", "")
  end

  return clipboard
end

M.same = function(index)
  return require("luasnip").function_node(function(args)
    return args[1]
  end, { index })
end

return M
