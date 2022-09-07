-- Source: https://github.com/neovim/neovim/blob/b4e12bfa0044720b39fc08c18149167b3ca9b255/runtime/lua/vim/shared.lua

--- Returns true if object `f` can be called as a function.
---
---@param f any Any object
---@return boolean `true` if `f` is callable, else `false`
local function is_callable(f)
  if type(f) == "function" then
    return true
  end
  local m = getmetatable(f)
  if m == nil then
    return false
  end
  return type(m.__call) == "function"
end

local type_names = {
  ["table"] = "table",
  t = "table",
  ["string"] = "string",
  s = "string",
  ["number"] = "number",
  n = "number",
  ["boolean"] = "boolean",
  b = "boolean",
  ["function"] = "function",
  f = "function",
  ["callable"] = "callable",
  c = "callable",
  ["nil"] = "nil",
  ["thread"] = "thread",
  ["userdata"] = "userdata",
}

local function _is_type(val, t)
  return type(val) == t or (t == "callable" and is_callable(val))
end

---@private
local function is_valid(opt)
  if type(opt) ~= "table" then
    return false, string.format("opt: expected table, got %s", type(opt))
  end

  for param_name, spec in pairs(opt) do
    if type(spec) ~= "table" then
      return false, string.format("opt[%s]: expected table, got %s", param_name, type(spec))
    end

    local val = spec[1] -- Argument value
    local types = spec[2] -- Type name, or callable
    local optional = (true == spec[3])

    if type(types) == "string" then
      types = { types }
    end

    if is_callable(types) then
      -- Check user-provided validation function
      local valid, optional_message = types(val)
      if not valid then
        local error_message = string.format("%s: expected %s, got %s", param_name, (spec[3] or "?"), tostring(val))
        if optional_message ~= nil then
          error_message = error_message .. string.format(". Info: %s", optional_message)
        end

        return false, error_message
      end
    elseif type(types) == "table" then
      local success = false
      for i, t in ipairs(types) do
        local t_name = type_names[t]
        if not t_name then
          return false, string.format("invalid type name: %s", t)
        end
        types[i] = t_name

        if (optional and val == nil) or _is_type(val, t_name) then
          success = true
          break
        end
      end
      if not success then
        return false, string.format("%s: expected %s, got %s", param_name, table.concat(types, "|"), type(val))
      end
    else
      return false, string.format("invalid type name: %s", tostring(types))
    end
  end

  return true, nil
end

return function(opt)
  local ok, err_msg = is_valid(opt)
  if not ok then
    error(err_msg, 2)
  end
end
