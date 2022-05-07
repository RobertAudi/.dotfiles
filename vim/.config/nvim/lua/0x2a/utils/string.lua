-- Module: 0x2a.utils.string
-- Requires:
--   - 0x2a.utils

local utils = require("0x2a.utils")

local M = {}

M.starts_with = function(str, start)
  return utils.is_present(str) and type(str) == "string" and str:sub(1, #start) == start
end

M.ends_with = function(str, ending)
  return utils.is_present(str) and type(str) == "string" and ending == "" or str:sub(-#ending) == ending
end

M.capitalize_first = function(str)
  return utils.is_present(str) and type(str) == "string" and (str:gsub("^%l", string.upper)) or str
end

-- Source: https://lua-users.org/wiki/SplitJoin
M.split = function(str, sep)
  if utils.is_blank(str) or type(str) ~= "string" then
    return {}
  end

  sep = "^(.-)" .. sep:gsub("[$%%()*+%-.?%[%]^]", "%%%0")

  local result, count, first, found, last, word = {}, 1, 1, nil, nil, nil

  repeat
    found, last, word = str:find(sep, first)
    if found then
      result[count], count, first = word, count + 1, last + 1
    else
      result[count] = str:sub(first)
      break
    end
  until not found

  return result
end

return M
