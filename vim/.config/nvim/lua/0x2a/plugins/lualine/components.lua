-- Module: 0x2a.plugins.lualine.predicates
-- Requires:
--   - 0x2a.symbols
--   - 0x2a.utils
--   - 0x2a.plugins.lualine.config
--   - nvim-lualine/lualine.nvim
--   - 0x2a.plugins.lualine.predicates

local symbols = require("0x2a.symbols")
local utils = require("0x2a.utils")

local config = require("0x2a.plugins.lualine.config")
local predicates = require("0x2a.plugins.lualine.predicates")

local lualine = {
  mode = require("lualine.utils.mode"),
  utils = require("lualine.utils.utils"),
}

local M = {}

M.progress = function()
  if predicates.ignore_filetype(vim.bo.filetype) then
    return ""
  else
    local numlines = vim.api.nvim_buf_line_count(0)

    if numlines > 1 then
      return "%3p%%" .. " (" .. numlines .. " lines)"
    else
      return ""
    end
  end
end

M.location = function()
  if predicates.ignore_filetype(vim.bo.filetype) then
    return ""
  else
    return "%3l:%-2v"
  end
end

M.mode = function()
  local filetype = vim.bo.filetype

  if predicates.is_plugin_filetype(filetype) then
    return config.plugin_filetypes[filetype]
  elseif predicates.is_special_filetype(filetype) then
    return config.special_filetypes[filetype]
  elseif predicates.ignore_filetype(filetype) then
    return ""
  else
    return lualine.mode.get_mode()
  end
end

M.paste = function()
  local filetype = vim.bo.filetype

  if predicates.ignore_filetype(filetype) or not vim.o.paste then
    return ""
  else
    return "PASTE"
  end
end

M.filename = function()
  if predicates.ignore_plugin_filetype(vim.bo.filetype) then
    return ""
  end

  local data = lualine.utils.stl_escape(vim.fn.expand("%:t"))

  if utils.is_empty(data) then
    data = "[No Name]"
  end

  if vim.bo.readonly or not vim.bo.modifiable then
    data = symbols.codicon.lock .. " " .. data
  end

  if vim.bo.modified then
    data = data .. " " .. symbols.modified
  end

  return data
end

M.filetype = function()
  local filetype = vim.bo.filetype

  if predicates.is_plugin_filetype(filetype) or predicates.is_special_filetype(filetype) then
    return ""
  end

  local data = lualine.utils.stl_escape(filetype)

  if utils.is_empty(data) then
    return "no ft"
  else
    return "[" .. data .. "]"
  end
end

return M
