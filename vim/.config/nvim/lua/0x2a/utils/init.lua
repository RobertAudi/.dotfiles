-- Module: 0x2a.utils
-- Requires:
--   - 0x2a.utils.fs
--   - 0x2a.notifications
--   - nvim-lua/plenary.nvim
--   - wbthomason/packer.nvim

local Path = require("plenary.path")
local Job = require("plenary.job")
local M = {}

local next = next

M.noop = function() end

-- Source: https://github.com/anuvyklack/dotfiles/blob/baf8b43e3d91236a3bd773278fd01895959f894e/roles/neovim/files/lua/util.lua#L9,14
--- @class Void Void has eveything and nothing
M.void = setmetatable({}, { ---@type Void
  __newindex = function() end,
  __call = function() end,
  __index = function(self)
    return self
  end,
})

M.keymap = {}

-- Source: https://github.com/anuvyklack/dotfiles/blob/baf8b43e3d91236a3bd773278fd01895959f894e/roles/neovim/files/lua/util.lua#L62-L64
M.keymap.cmd = function(command)
  vim.validate({ command = { command, "string" } })

  return table.concat({ "<Cmd>", command, "<CR>" })
end

--- Determine if a value of any type is empty
--- @param item any
--- @return boolean
M.is_empty = function(item)
  local thing_type = type(item)

  return not item or (thing_type == "string" and item == "") or (thing_type == "table" and next(item) == nil)
end

M.is_blank = function(item)
  if type(item) == "string" and string.match(item, "%S") == nil then
    return true
  else
    return M.is_empty(item)
  end
end

M.is_present = function(item)
  return not M.is_blank(item)
end

M.if_empty = function(val, was_empty, was_not_empty)
  if M.is_empty(val) then
    return was_empty
  else
    return was_not_empty
  end
end

M.if_blank = function(val, was_blank, was_not_blank)
  if M.is_blank(val) then
    return was_blank
  else
    return was_not_blank
  end
end

M.if_present = function(val, was_present, was_not_present)
  return M.if_blank(val, was_not_present, was_present)
end

M.if_nil = vim.F.if_nil

M.presence = function(val)
  if M.is_blank(val) then
    return nil
  else
    return val
  end
end

-- Source: http://lua-users.org/wiki/RangeIterator
--
-- range(start)             returns an iterator from 1 to a (step = 1)
-- range(start, stop)       returns an iterator from a to b (step = 1)
-- range(start, stop, step) returns an iterator from a to b, counting by step.
M.range = function(start, stop, step)
  -- range(--[[ no args ]]) -> return "nothing" to fail the loop in the caller
  if start == nil then
    return
  end

  if not stop then
    stop = start
    start = stop == 0 and 0 or (stop > 0 and 1 or -1)
  end

  -- we don't have to do the to == 0 check
  -- 0 -> 0 with any inc would never iterate
  step = step or (start < stop and 1 or -1)

  -- step back (once) before we start
  start = start - step

  return function()
    if start == stop then
      return nil
    end

    start = start + step

    return start, start
  end
end

M.RELOAD = function(...)
  return require("plenary.reload").reload_module(...)
end

M.R = function(name)
  M.RELOAD(name)
  return require(name)
end

M.fatal = function(msg)
  vim.api.nvim_err_writeln(msg)
  vim.v.errmsg = msg
  error(msg)
  return false
end

M.error = function(msg)
  vim.api.nvim_echo({ { msg, "WarningMsg" } }, true, {})
  vim.v.errmsg = msg
end

M.normalize_options = function(opts)
  vim.validate({ opts = { opts, { "table", "nil" } } })

  return M.if_nil(opts, {}, opts)
end

M.get_default_register = function()
  local clipboardFlags = vim.split(vim.opt.clipboard, ",")

  if vim.tbl_contains(clipboardFlags, "unnamedplus") then
    return "+"
  end

  if vim.tbl_contains(clipboardFlags, "unnamed") then
    return "*"
  end

  return "\""
end

M.copy_to_clipboard = function(str, callbacks)
  Job
    :new({
      command = "copy-text",
      args = { tostring(str) },
      on_exit = function(_, return_val)
        if M.is_empty(callbacks) then
          return
        end

        if return_val == 0 then
          if callbacks.success then
            callbacks.success()
          end
        else
          if callbacks.failure then
            callbacks.failure()
          end
        end
      end,
    })
    :sync()
end

M.is_mac = function()
  return vim.loop.os_uname().sysname == "Darwin"
end

M.browse = function(url, opts)
  vim.validate({ url = { url, "string" } })

  local fsutils = require("0x2a.utils.fs")
  local notifications = require("0x2a.notifications")

  opts = M.normalize_options(opts)

  local ok, urlview = pcall(require, "urlview.utils")

  if ok then
    ok, _ = pcall(urlview.navigate_url, url)

    if ok then
      return
    end
  end

  local browser = os.getenv("BROWSER")

  if M.is_empty(browser) then
    if fsutils.is_executable("launch") then
      browser = "launch"
    elseif fsutils.is_executable("open") then
      browser = "open"
    else
      notifications.warning("Unable to resolve web browser or URL handler")
      return
    end
  end

  if not fsutils.is_executable(browser) then
    notifications.warning("Web browser or URL handler not executable: " .. browser)
    return
  end

  local args = {}

  if opts.background then
    if browser == "launch" then
      table.insert(args, "-b")
    elseif browser == "open" then
      table.insert(args, "-g")
    else
      opts.background = false
    end
  end

  table.insert(args, url)

  Job
    :new({
      command = browser,
      args = args,
      on_exit = function(_, return_val)
        if return_val == 0 then
          if opts.background then
            notifications.info(url, { title = "URL opened in the browser" })
          end
        else
          notifications.error("Unable to open URL in the browser")
        end
      end,
    })
    :sync()
end

M.fortune = function(collection)
  if M.is_blank(collection) then
    collection = "all"
  else
    local fsutils = require("0x2a.utils.fs")
    local fortunes_dir = os.getenv("FORTUNES_DIR")

    if M.is_blank(fortunes_dir) then
      fortunes_dir = Path:new(os.getenv("XDG_DATA_HOME"), "fortunes"):expand()
    end

    collection = Path:new(fortunes_dir, collection):expand()

    if not fsutils.is_directory(fortunes_dir) or not Path:new(collection):is_file() then
      collection = "all"
    end
  end

  local job = Job:new({ command = "fortune", args = { collection } })
  job:sync()

  if job.code == 0 then
    return require("0x2a.utils.string").trim_lines(table.concat(job:result(), "\n"))
  else
    vim.defer_fn(function()
      local result = job:result()

      if M.is_blank(result) then
        result = job:stderr_result()
      end

      if M.is_present(result) then
        local msg = table.concat(result, "\n")

        vim.api.nvim_err_writeln(msg)
        vim.v.errmsg = msg
      end
    end, 100)

    return ""
  end
end

M.hide_cursor = function()
  require("0x2a.colors.utils").highlight("Cursor", { fg = "white", bg = "black", blend = 100 })
  vim.opt.guicursor:append({ "a:Cursor/lCursor" })
end

M.show_cursor = function()
  require("0x2a.colors.utils").restore_highlight("Cursor")
  vim.opt.guicursor:remove({ "a:Cursor/lCursor" })
end

-- Source: https://github.com/kristijanhusak/neovim-config/blob/20cd27b0386acf5106c9faab51bdc6f8b2b3cc10/nvim/lua/partials/search.lua#L44-L56
M.get_visual_selection = function()
  if vim.api.nvim_get_mode().mode ~= "v" then
    return ""
  end

  local s_start = vim.fn.getpos("'<")
  local s_end = vim.fn.getpos("'>")
  local n_lines = math.abs(s_end[2] - s_start[2]) + 1
  local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)

  lines[1] = string.sub(lines[1] or "", s_start[3], -1)

  if n_lines == 1 then
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
  else
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
  end

  return table.concat(lines, "\n")
end

M.longest_line = function(value)
  vim.validate({ value = { value, { "table", "string" } } })

  if type(value) == "string" then
    value = require("0x2a.utils.string").split(value, "\n")
  else
    local table_utils = require("0x2a.utils.table")

    vim.validate({
      value = {
        value,

        function(tbl)
          return table_utils.is_array(tbl, { "string" })
        end,

        "an array of strings",
      },
    })
  end

  local longest = { contents = "", length = 0 }

  for _, v in pairs(value) do
    local width = vim.fn.strdisplaywidth(v)

    if width > longest.length then
      longest.contents = v
      longest.length = width
    end
  end

  return longest
end

return M
