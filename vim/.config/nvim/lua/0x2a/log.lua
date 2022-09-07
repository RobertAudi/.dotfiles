-- Module: log
-- Requires:
--   - 0x2a.utils.table

local M = {}

M.fatal = function(message)
  vim.validate({ message = { message, "string" } })

  vim.defer_fn(function()
    vim.api.nvim_err_writeln(message)
    vim.v.errmsg = message
  end, 100)
end

M.error = function(message)
  vim.validate({ message = { message, "string" } })

  vim.defer_fn(function()
    vim.api.nvim_echo({ { message, "WarningMsg" } }, true, {})
    vim.v.errmsg = message
  end, 100)
end

M.warn = function(message)
  vim.validate({ message = { message, "string" } })

  vim.defer_fn(function()
    vim.api.nvim_echo({ { message, "WarningMsg" } }, true, {})
  end, 100)
end

M.print = function(message)
  vim.validate({ message = { message, "string" } })

  vim.defer_fn(function()
    vim.api.nvim_echo({ { message } }, true, {})
  end, 100)
end

M.debug = M.print
M.trace = M.print
M.info = M.print
M.success = M.print

setmetatable(M, {
  __call = function(tbl, ...)
    local args = { ... }
    local table_utils = require("0x2a.utils.table")

    vim.validate({
      args_count = {
        table_utils.len(args),
        function(count)
          return count == 2
        end,
      },

      level = {
        args[1],
        function(level)
          return (type(level) == "string" and type(tbl[string.lower(level)]) == "function")
            or (type(level) == "number" and table_utils.find_key(vim.log.levels, level) ~= nil and level ~= vim.log.levels.OFF)
        end,
      },

      message = { args[2], "string" },
    })

    local level = args[1]
    local message = args[2]

    if type(level) == "number" then
      level = table_utils.find_key(vim.log.levels, level)
    end

    tbl[string.lower(level)](message)
  end,

  __metatable = false,
  __newindex = function(_, _, _)
    error("Attempt to modify read-only table")
  end,
})

return M
