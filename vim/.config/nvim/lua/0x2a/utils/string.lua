-- Module: 0x2a.utils.string
-- Requires:
--   - 0x2a.utils
--   - 0x2a.utils.table

local utils = require("0x2a.utils")
local table_utils = require("0x2a.utils.table")

local M = {}

-- Count the number of occurences of a pattern in a string
-- Source: https://stackoverflow.com/a/51256340/123016
M.count = function(base, pattern)
  vim.validate({
    base = { base, "string" },
    pattern = { pattern, "string" },
  })

  return select(2, string.gsub(base, pattern, ""))
end

M.starts_with = function(str, start)
  vim.validate({
    str = { str, "string" },
    start = { start, "string" },
  })

  return utils.is_present(str) and type(str) == "string" and str:sub(1, #start) == start
end

M.ends_with = function(str, ending)
  vim.validate({
    str = { str, "string" },
    ending = { ending, "string" },
  })

  return utils.is_present(str) and type(str) == "string" and ending == "" or str:sub(-#ending) == ending
end

M.capitalize_first = function(str)
  vim.validate({ str = { str, "string" } })

  return utils.is_present(str) and type(str) == "string" and (str:gsub("^%l", string.upper)) or str
end

-- Source: https://lua-users.org/wiki/SplitJoin
M.split = function(str, sep)
  vim.validate({
    str = { str, "string" },
    sep = { sep, { "string", "nil" } },
  })

  if utils.is_blank(str) then
    return {}
  end

  local result = {}

  if sep == nil or sep == "" then
    str:gsub(".", function(c)
      result[#result + 1] = c
    end)
  else
    sep = "^(.-)" .. sep:gsub("[$%%()*+%-.?%[%]^]", "%%%0")

    local count, first, found, last, word = 1, 1, nil, nil, nil

    repeat
      found, last, word = str:find(sep, first)
      if found then
        result[count], count, first = word, count + 1, last + 1
      else
        result[count] = str:sub(first)
        break
      end
    until not found
  end

  return result
end

-- Source: https://github.com/L3MON4D3/LuaSnip/blob/a12441e0598e93e67235eba67c8e6fbffc896f06/lua/luasnip/extras/fmt.lua#L171-L187
--
-- Find the largest common indent in a list of lines and remove it.
local remove_common_indent = function(lines)
  vim.validate({ lines = { lines, "table" } })

  local max_indent = math.huge

  for _, line in ipairs(lines) do
    -- ignore lines with whitespace only
    local match = line:match("^(%s*)%S")

    if match then
      max_indent = math.min(max_indent, #match)
    end
  end

  if max_indent > 0 then
    lines = table_utils.map(lines, function(_, line)
      return line:sub(max_indent + 1)
    end)
  end

  return lines
end

-- Source: https://github.com/L3MON4D3/LuaSnip/blob/a12441e0598e93e67235eba67c8e6fbffc896f06/lua/luasnip/extras/fmt.lua#L214-L233
--
-- This allows to use [[...]] strings ignoring the first and last lines
M.trim_lines = function(str)
  vim.validate({ str = { str, "string" } })

  if utils.is_blank(str) then
    return str
  end

  local lines = M.split(str, "\n")

  if lines[1]:match("^%s*$") then
    table.remove(lines, 1)
  end

  if lines[#lines]:match("^%s*$") then
    table.remove(lines)
  end

  lines = remove_common_indent(lines)

  return table.concat(lines, "\n")
end

return M
