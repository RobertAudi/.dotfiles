-- Module: 0x2a.editor.window

local function validate_window(window)
  vim.validate({ window = { window, "table" } })

  vim.validate({
    winid = { window.id, vim.api.nvim_win_is_valid },
    cwd = { window.cwd, "string" }
  })
end

local function get_number(window, reload)
  validate_window(window)

  if reload or not window.number then
    rawset(window, "number", vim.api.nvim_win_get_number(window.id))
  end

  return window.number
end

local function get_buffer(window, reload)
  validate_window(window)

  if reload or not window.buffer then
    local Buffer = require("0x2a.editor.buffer")

    rawset(window, "buffer", Buffer:new(vim.api.nvim_win_get_buf(window.id)))
  end

  return window.buffer
end

local function get_file(window, reload)
  return get_buffer(window, reload).file
end

local function get_long_name(window, reload)
  return get_buffer(window, reload).long_name
end

local function get_name(window, reload)
  return get_buffer(window, reload).name
end

local function get_active_state(window, reload)
  validate_window(window)

  if reload or window.is_active == nil then
    rawset(window, "is_active", vim.api.nvim_get_current_win() == window.id)
  end

  return window.is_active
end

local Window = {}

Window.__index = Window
Window.__metatable = false
Window.__newindex = function(_, _, _)
  error("Attempt to modify read-only table")
end

Window.__eq = function(window1, window2)
  return window1.id == window2.id and window1.buffer == window2.buffer
end

function Window:new(winid)
  vim.validate({
    winid = { winid, vim.api.nvim_win_is_valid },
  })

  local window = {}

  setmetatable(window, Window)

  if winid == 0 then
    winid = vim.api.nvim_get_current_win()
  end

  rawset(window, "id", winid)
  rawset(window, "cwd", vim.loop.fs_realpath("."))

  rawset(window, "number", get_number(window))
  rawset(window, "buffer", get_buffer(window))
  rawset(window, "file", get_file(window))
  rawset(window, "long_name", get_long_name(window))
  rawset(window, "name", get_name(window))
  rawset(window, "is_active", get_active_state(window))

  return window
end

function Window:reload()
  rawset(self, "number", get_number(self, true))
  rawset(self, "buffer", get_buffer(self, true))
  rawset(self, "file", get_file(self, true))
  rawset(self, "long_name", get_long_name(self, true))
  rawset(self, "name", get_name(self, true))
  rawset(self, "is_active", get_active_state(self, true))

  return self
end

function Window:activate()
  if not self.is_active then
    vim.api.nvim_set_current_win(self.id)
  end
end

function Window.all()
  local winids = vim.api.nvim_list_wins()
  local windows = {}

  for _, winid in pairs(winids) do
    table.insert(windows, Window:new(winid))
  end

  return windows
end

return Window
