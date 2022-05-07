-- Module: 0x2a.plugins.notify.utils
-- Requires:
--   - rcarriga/nvim-notify
--   - 0x2a.utils

local utils = require("0x2a.utils")
local config = require("notify.config")

local M = {}

-- Source: https://stackoverflow.com/questions/1426954/split-string-in-lua#comment73602874_7615129
local function split(inputstr, sep)
  sep = sep or "%s"

  local t = {}

  for field, s in string.gmatch(inputstr, "([^" .. sep .. "]*)(" .. sep .. "?)") do
    table.insert(t, field)

    if s == "" then
      return t
    end
  end
end

-- Source: https://stackoverflow.com/q/32031473/123016
local function wrap(inputstr, limit, indent, indent1)
  assert(type(inputstr) == "string", "inputstr is not a string")
  assert(type(limit) == "number", "limit is not a number")

  indent = indent or ""
  indent1 = indent1 or indent

  local here = 1 - #indent1

  return indent1
    .. inputstr:gsub("(%s+)()(%S+)()", function(sp, st, word, fi)
      if fi - here > limit then
        here = st - #indent

        return "\n" .. indent .. word
      end
    end)
end

M.wrap = function(notif, opts)
  opts = utils.normalize_options(opts)

  local max_width = config.max_width() or math.ceil(math.max(vim.opt.columns:get() / 3, 10))
  local indent = 0
  local t = {}

  if opts.icon then
    indent = vim.str_utfindex(notif.icon)
    notif.message[1] = notif.icon .. " " .. notif.message[1]
  end

  for i = 1, #notif.message do
    local messages = split(wrap(notif.message[i], max_width, " "), "\n")

    for j = 1, #messages do
      if opts.icon and ((i == 1 and j > 1) or i > 1) then
        messages[j] = string.rep(" ", indent) .. " " .. messages[j]
      end

      messages[j] = " " .. messages[j] .. " "

      table.insert(t, messages[j])
    end
  end

  return t
end

return M
