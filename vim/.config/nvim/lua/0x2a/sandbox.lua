-- Module: 0x2a.sandbox
-- Requires:
--   - 0x2a.utils
--   - 0x2a.notifications

local utils = require("0x2a.utils")
local notifications = require("0x2a.notifications")

local M = {}

local dotfiles_dir = os.getenv("DOTFILES_DIR") or vim.fn.expand("~/.dotfiles")

if not utils.is_empty(dotfiles_dir) then
  dotfiles_dir = string.gsub(dotfiles_dir, "/$", "")
end

local function dotfiles_dir_exists()
  return dotfiles_dir and vim.fn.isdirectory(dotfiles_dir) > 0
end

local function check_dotfiles_dir()
  if not dotfiles_dir_exists() then
    notifications.error("~/.dotfiles doesn't exist")
    return false
  end

  return true
end

local function sandbox_path(path)
  if not dotfiles_dir_exists() then
    return false
  end

  path = string.gsub(path, dotfiles_dir .. "/?", "")
  path = string.gsub(path, "^sandbox/?", "")
  path = string.gsub(path, "/$", "")

  return dotfiles_dir .. "/sandbox/" .. path
end

M.move_to_sanbox = function(opts)
  if vim.api.nvim_buf_get_option(0, "buftype") ~= "" then
    notifications.warning("Buffer is not a file")
    return false
  end

  if not check_dotfiles_dir() then
    return false
  end

  local file_name = vim.fn.expand("%:t")
  local file_path = vim.fn.expand("%:p")
  local file_dir = vim.fn.expand("%:p:h")
  local sandbox = sandbox_path(file_dir)
  local sandbox_file_path = sandbox .. "/" .. file_name

  os.execute("mkdir -p " .. sandbox)

  if vim.fn.filereadable(sandbox_file_path) > 0 then
    notifications.error("Sandbox file already exists: " .. sandbox_file_path)
    return false
  end

  opts = opts or {}

  local line1 = tonumber(opts.line1) or 0
  local line2 = tonumber(opts.line2) or 0
  local range = tonumber(opts.range) or 0

  if line1 == line2 then
    if range == 0 then
      line1 = 0
    end

    line2 = 0
  end

  if line1 > 0 then
    local lines = {}

    if line2 > 0 then
      lines = vim.fn.getline(line1, line2)
    else
      lines = vim.fn.getline(line1)
    end

    lines = table.concat(lines, "\n")

    file = io.open(sandbox_file_path, "w")
    file:write(lines)
    file:close()

    notifications.success("Lines copied to the sandbox in: " .. sandbox_file_path)
  elseif opts.move == true then
    os.rename(file_path, sandbox_file_path)

    notifications.success("File moved to the sandbox in: " .. sandbox_file_path)
  else
    local lines = table.concat(vim.fn.getline(1, "$"), "\n")

    file = io.open(sandbox_file_path, "w")
    file:write(lines)
    file:close()

    notifications.success("File copied to the sandbox in: " .. sandbox_file_path)
  end

  return true
end

return M
