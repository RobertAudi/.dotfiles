-- Module: 0x2a.utils.headers
-- Requires:
--   - figlet
--   - nvim-lua/plenary.nvim
--   - 0x2a.utils
--   - 0x2a.utils.string

local Job = require("plenary.job")
local utils = require("0x2a.utils")
local string_utils = require("0x2a.utils.string")

local M = {}

M.figlet = function(text, opts)
  vim.validate({ text = { text, "string" } })

  opts = opts or {}
  opts.font = opts.font or "big"

  local job = Job:new({ command = "figlet", args = { "-f", opts.font, text } })
  job:sync()

  if job.code == 0 then
    return string_utils.trim_lines(table.concat(job:result(), "\n"))
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

    return ""
  end
end

M.h1 = function(text)
  return M.figlet(text, { font = "ANSI Shadow" })
end

M.h2 = function(text)
  return M.figlet(text, { font = "larry3d" })
end

M.h3 = function(text)
  return M.figlet(text, { font = "pagga" })
end

M.h4 = function(text)
  return M.figlet(text, { font = "future" })
end

return M
