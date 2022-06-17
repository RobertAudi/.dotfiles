-- Module: 0x2a.utils
-- Requires:
--   - nvim-lua/plenary.nvim
--   - wbthomason/packer.nvim

local Job = require("plenary.job")
local M = {}

local next = next

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

M.RELOAD = function(...)
  return require("plenary.reload").reload_module(...)
end

M.R = function(name)
  M.RELOAD(name)
  return require(name)
end

M.normalize_options = function(opts)
  local opts_type = type(opts)

  if not opts or opts_type ~= "table" then
    opts = {}
  end

  return opts
end

M.table_has_key = function(tbl, key)
  return tbl[key] ~= nil
end

M.table_has_value = function(tbl, value)
  for _, v in ipairs(tbl) do
    if v == value or (type(v) == "table" and M.table_has_value(v, value)) then
      return true
    end
  end

  return false
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

-- load plugin after entering vim ui
-- Source: https://github.com/NvChad/NvChad/blob/f9f03e7eaf095607f90ec4df96f786acc8427edc/lua/core/utils.lua#L99,107
M.packer_lazy_load = function(plugin, timer)
  if plugin then
    timer = timer or 0
    vim.defer_fn(function()
      require("packer").loader(plugin)
    end, timer)
  end
end

-- M.setup = function(plugin)
--   if M.is_empty(plugin) then
--
--   end
--
--   require("0x2a.plugins." .. plugin)
-- end

return M
