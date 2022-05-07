-- Module: 0x2a.plugins.lualine.predicates
-- Requires:
--   - 0x2a.plugins.lualine.config
--   - nvim-lualine/lualine.nvim

local config = require("0x2a.plugins.lualine.config")
local table_has_value = require("0x2a.utils").table_has_value

local M = {}

M.ignore_special_filetype = function(filetype)
  return table_has_value(config.ignored_special_filetypes, filetype)
end

M.ignore_plugin_filetype = function(filetype)
  return table_has_value(config.ignored_plugin_filetypes, filetype)
end

M.ignore_filetype = function(filetype)
  return M.ignore_special_filetype(filetype) or M.ignore_plugin_filetype(filetype)
end

M.is_special_filetype = function(filetype)
  return config.special_filetypes[filetype] ~= nil
end

M.is_plugin_filetype = function(filetype)
  return config.plugin_filetypes[filetype] ~= nil
end

return M
