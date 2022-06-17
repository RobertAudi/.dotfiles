-- Module: 0x2a.utils.files
-- Requires:
--   - 0x2a.utils
--   - 0x2a.utils.string
--   - 0x2a.notifications
--   - nvim-lua/plenary.nvim

local utils = require("0x2a.utils")
local string_utils = require("0x2a.utils.string")
local notifications = require("0x2a.notifications")
local Path = require("plenary.path")

local M = {}

M.is_directory = function(path)
  return vim.fn.isdirectory(path) > 0
end

M.file_exists = function(path)
  return vim.fn.filereadable(path) > 0
end

M.is_executable = function(cmd)
  -- vim.loop.fs_access(cmd, "X")
  return cmd and cmd ~= "" and vim.fn.executable(cmd) > 0
end

-- Source: https://github.com/AstroNvim/AstroNvim/blob/db0fe6085afd69706cf02f85765d25c71279d7a0/lua/core/utils.lua#L8,10
M.is_empty = function(path)
  return vim.fn.empty(vim.fn.glob(path)) > 0
end

-- Make a file executable
M.make_executable = function(file)
  file = file or vim.fn.expand("%", false, false)

  local file_path = Path:new(file):expand()

  if vim.fn.filereadable(file_path) == 0 then
    notifications.error("The file doesn't exist or is not readable")
    return false
  end

  local first_line = vim.fn.readfile(file, "", 1)[1]

  if string_utils.starts_with(first_line, "#!") and not M.is_executable(file_path) then
    vim.api.nvim_command("Chmod +x " .. file_path)
  end
end

M.shorten_path = function(file_or_directory, len, exclude)
  file_or_directory = file_or_directory or vim.fn.expand("%", false, false)
  len = len or 1
  exclude = exclude or { -1 }
  shortened_path = Path:new(file_or_directory):shorten(len, exclude)

  -- Remove the leading "./"
  shortened_path = string.gsub(shortened_path, "^(%./)(.*)", "%2")

  return shortened_path
end

M.absolute_path = function(file_or_directory)
  file_or_directory = file_or_directory or vim.fn.expand("%", false, false)

  return Path:new(file_or_directory):absolute()
end

M.relative_path = function(file_or_directory)
  file_or_directory = file_or_directory or vim.fn.expand("%", false, false)

  return Path:new(file_or_directory):make_relative()
end

M.copy_absolute_file_path = function(file)
  local file_path = M.absolute_path(file)

  utils.copy_to_clipboard(file_path, {
    success = function()
      notifications.success("File path copied: " .. file_path)
    end,

    failure = function()
      notifications.error("Failed to copy file path")
    end,
  })
end

M.copy_relative_file_path = function()
  local file_path = M.relative_path(file)

  utils.copy_to_clipboard(file_path, {
    success = function()
      notifications.success("File path copied: " .. file_path)
    end,

    failure = function()
      notifications.error("Failed to copy file path")
    end,
  })
end

return M
