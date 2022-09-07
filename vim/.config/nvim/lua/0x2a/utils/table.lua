-- Module: 0x2a.utils.table
-- Requires:
--   - 0x2a.utils

local M = {}

-- Source: https://github.com/ericpubu/.dotfiles/blob/e7afcddee385dc244fe4172d255c8d097935535e/nvim/.config/nvim/lua/ericus/vim-utils.lua#L57-L63
M.len = function(tbl)
  vim.validate({ tbl = { tbl, "table" } })

  local count = 0

  for _ in pairs(tbl) do
    count = count + 1
  end

  return count
end

-- Source: Penlight
--- is an object 'array-like'?
-- An object is array like if:
--
-- - it is a table, or
-- - it has a metatable with `__len` and `__index` methods
--
-- NOTE: since `__len` is 5.2+, on 5.1 is usually returns `false` for userdata
-- @param val any value.
-- @return `true` if the object is array-like, otherwise a falsy value.
M.is_indexable = function(val)
  if type(val) == "table" then
    return true
  else
    local mt = getmetatable(val)

    -- return mt and mt.__len and mt.__index and true
    return mt and mt.__index and true
  end
end

-- Source: https://stackoverflow.com/a/6080274/123016
M.is_array = function(tbl, types)
  vim.validate({
    tbl = { tbl, "table" },
    types = { types, { "table", "nil" } },
  })

  local utils = require("0x2a.utils")

  if utils.is_empty(tbl) then
    return true
  end

  local i = 0
  for _ in pairs(tbl) do
    i = i + 1

    if tbl[i] == nil or (utils.is_present(types) and not M.has_value(types, type(tbl[i]))) then
      return false
    end
  end

  return true
end

M.is_dictionnary = function(tbl)
  vim.validate({ tbl = { tbl, "table" } })

  return require("0x2a.utils").is_empty(tbl) or not M.is_array(tbl)
end

M.table_type = function(tbl)
  vim.validate({ tbl = { tbl, "table" } })

  if M.is_array(tbl) then
    return "array"
  elseif M.is_dictionnary(tbl) then
    return "dictionnary"
  else
    return "table"
  end
end

M.has_key = function(tbl, key)
  vim.validate({ tbl = { tbl, "table" } })
  vim.validate({ tbl = { tbl, M.is_dictionnary, "a dictionnary" } })

  return tbl[key] ~= nil
end

M.has_value = function(tbl, value)
  vim.validate({ tbl = { tbl, "table" } })

  for _, v in ipairs(tbl) do
    if v == value or (type(v) == "table" and M.has_value(v, value)) then
      return true
    end
  end

  return false
end

M.matches = function(tbl1, tbl2)
  if tbl1 == tbl2 then
    return true
  end

  local tbl1_len = M.len(tbl1)
  local tbl2_len = M.len(tbl2)

  if tbl1_len ~= tbl2_len then
    return false
  end

  local tbl1_type = M.table_type(tbl1)
  local tbl2_type = M.table_type(tbl2)

  if tbl1_type ~= tbl2_type then
    return false
  end

  local visited = {}

  for key1, value1 in pairs(tbl1) do
    local gotcha

    for key2, value2 in pairs(tbl2) do
      if not visited[key2] then
        if tbl1[key1] == tbl2[key2] then
          gotcha = key2
          break
        end
      end
    end

    if not gotcha then
      return false
    end

    visited[gotcha] = true
  end

  return true
end

M.subtract = function(tbl1, tbl2)
  local res = {}

  for k, v in pairs(tbl1) do
    if tbl2[k] == nil then
      res[k] = v
    end
  end

  return res
end

-- Return the first index with the given value (or nil if not found).
M.index_of = function(tbl, value)
  vim.validate({ tbl = { tbl, M.is_array, "an array" } })

  for i, v in ipairs(tbl) do
    if v == value then
      return i
    end
  end

  return nil
end

-- Return the first key with the given value (or nil if not found).
M.find_key = function(tbl, value)
  vim.validate({ tbl = { tbl, "table" } })
  vim.validate({ tbl = { tbl, M.is_dictionnary, "a dictionnary" } })

  for k, v in pairs(tbl) do
    if v == value then
      return k
    end
  end

  return nil
end

-- Source: https://stackoverflow.com/a/12674376/123016
-- Note: table.insert is not used because it is significantly slower
M.keys = function(tbl)
  vim.validate({ tbl = { tbl, "table" } })
  vim.validate({ tbl = { tbl, M.is_dictionnary, "a dictionnary" } })

  local keyset = {}
  local n = 0

  for k, _ in pairs(tbl) do
    n = n + 1
    keyset[n] = k
  end

  return keyset
end

M.values = function(tbl)
  vim.validate({ tbl = { tbl, "table" } })

  local valueset = {}
  local n = 0

  for _, v in pairs(tbl) do
    n = n + 1
    valueset[n] = v
  end

  return valueset
end

M.Array = function(value)
  local value_type = type(value)

  if value_type == "table" then
    if M.is_array(value) then
      return value
    else
      return { value }
    end
  elseif value_type == "nil" then
    return {}
  else
    return { value }
  end
end

M.append = function(tbl, ...)
  vim.validate({
    tbl = { tbl, M.is_array, "an array" },
  })

  local tables = { ... }
  local result = { unpack(tbl) }

  for _, value in ipairs(tables) do
    if type(value) == "table" then
      for i, t in ipairs(value) do
        result[#result + 1] = value[i]
      end
    else
      result[#result + 1] = value
    end
  end

  return result
end

M.flatten = function(tbl)
  vim.validate({
    tbl = { tbl, M.is_array, "an array" },
  })

  local result = {}

  for _, value in ipairs(tbl) do
    if type(value) == "table" then
      result = M.append(result, unpack(value))
    else
      result = M.append(result, value)
    end
  end

  return result
end

M.compact = function(tbl)
  vim.validate({ tbl = { tbl, "table" } })

  local utils = require("0x2a.utils")

  local t = {}

  for k, v in pairs(tbl) do
    if utils.is_present(v) then
      t[k] = v
    end
  end

  if M.is_array(tbl) then
    return M.values(t)
  else
    return t
  end
end

M.slice = function(tbl, ...)
  vim.validate({ tbl = { tbl, "table" } })
  vim.validate({ tbl = { tbl, M.is_dictionnary, "a dictionnary" } })

  local keys = { ... }

  vim.validate({
    keys = {
      keys,
      function(value)
        return M.is_array(value, { "string" })
      end,
    },
  })

  local new_table = {}

  for _, key in ipairs({ ... }) do
    new_table[key] = tbl[key]

    if type(new_table[key]) == "function" then
      local arity = debug.getinfo(new_table[key], "u").nparams

      if arity == 0 then
        new_table[key] = new_table[key]()
      elseif arity == 1 then
        new_table[key] = new_table[key](tbl)
      end
    end
  end

  return new_table
end

M.pluck = function(tbl, ...)
  vim.validate({ tbl = { tbl, "table" } })
  vim.validate({
    tbl_len = {
      tbl,
      function(value)
        return M.len(value) >= 1
      end,
    },
  })

  local keys = { ... }

  vim.validate({
    keys = {
      keys,
      function(value)
        return M.is_array(value, { "string" }) and M.len(value) >= 1
      end,
    },
  })

  local attributes = M.map(M.Array(tbl), function(_, t)
    return M.values(M.slice(t, unpack(keys)))
  end)

  if M.len(attributes) == 1 then
    return attributes[1]
  else
    return attributes
  end
end

-- Source: https://stackoverflow.com/a/11671820/123016
M.map = function(tbl, f)
  vim.validate({ tbl = { tbl, "table" }, f = { f, "function" } })

  local t = {}

  for k, v in pairs(tbl) do
    t[k] = f(k, v)
  end

  return t
end

M.filter = function(tbl, f)
  vim.validate({ tbl = { tbl, "table" }, f = { f, "function" } })

  local t = {}

  for k, v in pairs(tbl) do
    if f(k, v) then
      t[k] = v
    end
  end

  return t
end

return M
