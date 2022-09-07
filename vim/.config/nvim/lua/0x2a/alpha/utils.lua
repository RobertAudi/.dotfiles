-- Module: 0x2a.alpha.utils
-- Requires:
--   - 0x2a.utils

local M = {}

M.set_buffer_keymap = function(buffer, mode, lhs, rhs, opts)
  opts = opts or {}
  opts.buffer = buffer
  vim.keymap.set(mode, lhs, rhs, opts)
end

M.resolve = function(to, el, opts, state)
  local new_el = vim.deepcopy(el)

  new_el.val = el.val()

  return to(new_el, opts, state)
end

M.closest_cursor_jump = function(cursor, cursors, prev_cursor)
  local direction = prev_cursor[1] > cursor[1] -- true = UP, false = DOWN

  -- minimum distance key from jump point
  -- excluding jumps in opposite direction
  local min
  local cursor_row = cursor[1]

  for k, v in pairs(cursors) do
    local distance = v[1] - cursor_row -- new cursor distance from old cursor

    if (distance <= 0) and direction then
      distance = math.abs(distance)

      local res = { distance, k }

      if not min then
        min = res
      end

      if min[1] > res[1] then
        min = res
      end
    end

    if (distance >= 0) and not direction then
      local res = { distance, k }

      if not min then
        min = res
      end

      if min[1] > res[1] then
        min = res
      end
    end
  end

  if not min then -- top or bottom
    if direction then
      return 1, cursors[1]
    else
      return #cursors, cursors[#cursors]
    end
  else
    -- returns the key (stored in a jank way so we can sort the table)
    -- and the {row, col} tuple
    return min[2], cursors[min[2]]
  end
end

M.should_skip_alpha = function()
  -- don't start when opening a file
  if vim.fn.argc() > 0 then
    return true
  end

  -- skip stdin
  if vim.fn.line2byte("$") ~= -1 then
    return true
  end

  -- Handle nvim -M
  if not vim.o.modifiable then
    return true
  end

  for _, arg in pairs(vim.v.argv) do
    -- whitelisted arguments
    -- always open
    if arg == "--startuptime" then
      return false
    end

    -- blacklisted arguments
    -- always skip
    if
      arg == "-b"
      -- commands, typically used for scripting
      or arg == "-c"
      or vim.startswith(arg, "+")
      or arg == "-S"
    then
      return true
    end
  end

  -- base case: don't skip
  return false
end

M.pad_margin = function(tbl, state, margin, shrink)
  local longest = require("0x2a.utils").longest_line(tbl).length
  local left

  if shrink then
    local pot_width = margin + margin + longest

    if pot_width > state.win_width then
      left = (state.win_width - pot_width) + margin
    else
      left = margin
    end
  else
    left = margin
  end

  local padding = string.rep(" ", left)
  local padded = {}

  for k, v in pairs(tbl) do
    padded[k] = padding .. v .. padding
  end

  return padded, left
end

M.align_center = function(tbl, state)
  -- longest line used to calculate the center.
  -- which doesn't quite give a 'justfieid' look, but w.e
  local longest = require("0x2a.utils").longest_line(tbl).length

  -- div 2
  local left = bit.arshift(state.win_width - longest, 1)
  local padding = string.rep(" ", left)
  local centered = {}

  for k, v in pairs(tbl) do
    centered[k] = padding .. v
  end

  return centered, left
end

M.trim = function(tbl, state)
  local win_width = vim.api.nvim_win_get_width(state.window)
  local trimmed = {}

  for k, v in ipairs(tbl) do
    trimmed[k] = string.sub(v, 1, win_width)
  end

  return trimmed
end

M.highlight = function(state, end_ln, hl, left)
  local hl_type = type(hl)
  local hl_tbl = {}

  if hl_type == "string" then
    for i = state.line, end_ln do
      table.insert(hl_tbl, { state.buffer, -1, hl, i, 0, -1 })
    end
  end

  -- TODO: support multiple lines
  if hl_type == "table" then
    for _, hl_section in pairs(hl) do
      table.insert(hl_tbl, {
        state.buffer,
        -1,
        hl_section[1],
        state.line,
        left + hl_section[2],
        left + hl_section[3],
      })
    end
  end

  return hl_tbl
end

return M
