-- Module: 0x2a.utils.fs
-- Requires:
--   - 0x2a.utils
--   - 0x2a.utils.string
--   - 0x2a.utils.table
--   - 0x2a.notifications
--   - nvim-lua/plenary.nvim

local Path = require("plenary.path")
local Job = require("plenary.job")

local M = {}

M.current_file = function()
  local f = {}

  f.path = vim.fn.expand("%:p")
  f.name = vim.fn.fnamemodify(f.path, ":t")
  f.extension = vim.fn.fnamemodify(f.path, ":e")
  f.directory = vim.fn.fnamemodify(f.path, ":h")

  return f
end

M.is_directory = function(path)
  return require("0x2a.utils").is_present(path) and vim.fn.isdirectory(path) > 0
end

M.file_exists = function(path)
  return require("0x2a.utils").is_present(path) and vim.loop.fs_stat(path) ~= nil
end

M.is_executable = function(cmd)
  -- vim.loop.fs_access(cmd, "X")
  return cmd and cmd ~= "" and vim.fn.executable(cmd) > 0
end

-- Make a file executable
M.make_executable = function(file)
  file = file or M.current_file().path

  local file_path = Path:new(file):expand()

  if vim.fn.filereadable(file_path) == 0 then
    require("0x2a.notifications").error("The file doesn't exist or is not readable")
    return false
  end

  local first_line = vim.fn.readfile(file, "", 1)[1]
  local string_utils = require("0x2a.utils.string")

  if first_line ~= nil and string_utils.starts_with(first_line, "#!") and not M.is_executable(file_path) then
    vim.cmd.Chmod("+x " .. file_path)
  end
end

M.rm = function(path)
  local utils = require("0x2a.utils")

  vim.validate({
    path = {
      path,
      function(path)
        return utils.is_present(path)
      end,
    },
  })

  path = M.absolute_path(path)

  vim.validate({
    file = {
      path,
      function(path)
        return M.file_exists(path)
      end,
    },
  })

  local ok, err, _ = vim.loop.fs_unlink(path)

  if not ok then
    return utils.fatal(err)
  end

  return true
end

M.shorten_path = function(file_or_directory, len, exclude)
  file_or_directory = file_or_directory or M.current_file().path
  len = len or 1
  exclude = exclude or { -1 }

  local shortened_path = Path:new(file_or_directory):shorten(len, exclude)

  -- Remove the leading "./"
  shortened_path = string.gsub(shortened_path, "^(%./)(.*)", "%2")

  return shortened_path
end

M.absolute_path = function(path, ...)
  vim.validate({ path = { path, { "string", "nil" } } })

  path = require("0x2a.utils").if_blank(path, M.current_file().path, path)
  path = Path:new(path, ...):expand()

  return Path:new(path):absolute()
end

M.relative_path = function(path, ...)
  vim.validate({ path = { path, { "string", "nil" } } })

  path = require("0x2a.utils").if_blank(path, M.current_file().path, path)
  path = Path:new(path, ...):expand()

  return Path:new(path):make_relative()
end

M.copy_absolute_file_path = function(file)
  local utils = require("0x2a.utils")
  local file_path = M.absolute_path(file)
  local notifications = require("0x2a.notifications")

  utils.copy_to_clipboard(file_path, {
    success = function()
      notifications.success("File path copied: " .. file_path)
    end,

    failure = function()
      notifications.error("Failed to copy file path")
    end,
  })
end

M.copy_relative_file_path = function(file)
  local utils = require("0x2a.utils")
  local file_path = M.relative_path(file)
  local notifications = require("0x2a.notifications")

  utils.copy_to_clipboard(file_path, {
    success = function()
      notifications.success("File path copied: " .. file_path)
    end,

    failure = function()
      notifications.error("Failed to copy file path")
    end,
  })
end

M.dotfiles_directory = function(subdir)
  vim.validate({ subdir = { subdir, { "string", "nil" } } })

  local utils = require("0x2a.utils")
  local dir = os.getenv("DOTFILES_DIR") or vim.fn.expand("~/.dotfiles")

  if utils.is_blank(subdir) then
    return dir
  else
    dir = Path:new(dir):absolute()

    local subdir = Path:new(dir, subdir):absolute()

    if M.is_directory(subdir) then
      return subdir
    else
      return dir
    end
  end
end

M.in_dotfiles_directory = function()
  return vim.loop.cwd() == M.dotfiles_directory()
end

M.ghq_roots = function()
  local utils = require("0x2a.utils")
  local dir = os.getenv("GHQ_ROOT")

  if M.is_directory(dir) then
    return { dir }
  end

  local job = Job:new({ command = "git", args = { "config", "--global", "--get-all", "--includes", "ghq.root" } })
  job:sync()

  if job.code == 0 then
    return require("0x2a.utils.table").map(job:result(), function(_, v)
      return M.absolute_path(v)
    end)
  else
    vim.defer_fn(function()
      local result = job:result()

      if utils.is_blank(result) then
        result = job:stderr_result()
      end

      if utils.is_present(result) then
        local msg = table.concat(result, "\n")

        vim.api.nvim_err_writeln(msg)
        vim.v.errmsg = msg
      end
    end, 100)

    return {}
  end
end

M.ghq_root = function()
  local ghq_roots = M.ghq_roots()

  return ghq_roots[#ghq_roots]
end

M.in_ghq_root = function()
  return require("0x2a.utils.table").has_value(M.ghq_roots(), vim.loop.cwd())
end

M.in_ghq_directory = function(opts)
  if M.in_ghq_root() then
    return false
  end

  vim.validate({
    opts = { opts, { "string", "boolean", "table", "nil" } },
  })

  local utils = require("0x2a.utils")
  local path
  local strict = false
  local opts_type = type(opts)

  if opts_type == "string" then
    path = utils.if_present(opts, opts, vim.loop.cwd())
  elseif opts_type == "boolean" then
    path = vim.loop.cwd()
    strict = opts
  elseif opts_type == "table" then
    path = utils.if_present(opts.path, opts.path, vim.loop.cwd())
    strict = utils.if_nil(opts.strict, strict, opts.strict)
  else
    path = vim.loop.cwd()
  end

  local string_utils = require("0x2a.utils.string")
  local dir

  for _, ghq_root in ipairs(M.ghq_roots()) do
    if string_utils.starts_with(path, ghq_root) then
      dir = path:sub(#ghq_root + 1)
      break
    end
  end

  if not dir then
    return false
  end

  local segments = require("0x2a.utils.table").compact(string_utils.split(dir, "/"))

  return strict and #segments == 3 or #segments >= 3
end

M.ghq_directory = function(path)
  path = require("0x2a.utils").if_present(path, path, vim.loop.cwd())

  if M.in_ghq_root() or not M.in_ghq_directory(path) then
    return
  end

  local string_utils = require("0x2a.utils.string")
  local dir

  for _, ghq_root in ipairs(M.ghq_roots()) do
    if string_utils.starts_with(path, ghq_root) then
      dir = path:sub(#ghq_root + 1)
      break
    end
  end

  if not dir then
    return
  end

  local segments = require("0x2a.utils.table").compact(string_utils.split(dir, "/"))

  return segments[2] .. "/" .. segments[3]
end

-- safe_encode returns a string which is safe to
-- use as a filesystem name.
--
-- this is helpful when encoding filesystem paths
-- to a string that can be used as a filename.
--
-- the encoding is just a sub-set of URL encoding.
--
-- @param str (string) The string to encode.
M.safe_encode = function(str)
  vim.validate({ str = { str, "string" } })

  str, _ = string.gsub(str, "/", "%%2F")
  str, _ = string.gsub(str, " ", "%%20")
  str, _ = string.gsub(str, ":", "%%3A")
  return str
end

-- decodes a string encoded by safe_encode.
-- see safe_encode for details.
M.safe_decode = function(str)
  vim.validate({ str = { str, "string" } })

  str, _ = string.gsub(str, "%%2F", "/")
  str, _ = string.gsub(str, "%%20", " ")
  str, _ = string.gsub(str, "%%3A", ":")
  return str
end

return M
