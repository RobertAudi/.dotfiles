-- Module: 0x2a.editor.tab
-- Requires:
--   - 0x2a.utils.table

local table_utils = require("0x2a.utils.table")

local function validate_tab(tab)
  vim.validate({ tab = { tab, "table" } })

  vim.validate({
    tabid = { tab.id, vim.api.nvim_tabpage_is_valid },
    cwd = { tab.cwd, "string" },
  })
end

local function get_number(tab, reload)
  validate_tab(tab)

  if reload or not tab.number then
    rawset(tab, "number", vim.api.nvim_tabpage_get_number(tab.id))
  end

  return tab.number
end

local function get_active_window(tab, reload)
  validate_tab(tab)

  if reload or not tab.active_window then
    local Window = require("0x2a.editor.window")

    rawset(tab, "active_window", Window:new(vim.api.nvim_tabpage_get_win(tab.id)))
  end

  return tab.active_window
end

local function get_active_buffer(tab, reload)
  validate_tab(tab)

  if reload or not tab.active_buffer then
    rawset(tab, "active_buffer", get_active_window(tab).buffer)
  end

  return tab.active_buffer
end

local function get_active_file(tab, reload)
  validate_tab(tab)

  if reload or not tab.active_file then
    rawset(tab, "active_file", get_active_window(tab).file)
  end

  return tab.active_file
end

local function get_long_name(tab, reload)
  validate_tab(tab)

  if reload or not tab.long_name then
    rawset(tab, "long_name", get_active_window(tab).long_name)
  end

  return tab.long_name
end

local function get_name(tab, reload)
  validate_tab(tab)

  if reload or not tab.name then
    rawset(tab, "name", get_active_window(tab).name)
  end

  return tab.name
end

local function get_windows(tab, reload)
  validate_tab(tab)

  if reload or not tab.windows then
    local Window = require("0x2a.editor.window")
    local windows = table_utils.map(vim.api.nvim_tabpage_list_wins(tab.id), function(_, winid)
      return Window:new(winid)
    end)

    rawset(tab, "windows", windows)
  end

  return tab.windows
end

local function get_active_state(tab, reload)
  validate_tab(tab)

  if reload or tab.is_active == nil then
    rawset(tab, "is_active", vim.api.nvim_get_current_tabpage() == tab.id)
  end

  return tab.is_active
end

local Tab = {}

Tab.__index = Tab
Tab.__metatable = false
Tab.__newindex = function(tbl, key, value)
  vim.pretty_print(tbl, key, value)

  error("Attempt to modify read-only table")
end

Tab.__eq = function(tab1, tab2)
  return tab1.id == tab2.id and tab1.cwd == tab2.cwd and tab1.active_window == tab2.active_window
end

function Tab:new(tabid)
  vim.validate({
    tabid = { tabid, vim.api.nvim_tabpage_is_valid },
  })

  local tab = {}

  setmetatable(tab, Tab)

  if tabid == 0 then
    tabid = vim.api.nvim_get_current_tabpage()
  end

  rawset(tab, "id", tabid)
  rawset(tab, "cwd", vim.loop.fs_realpath("."))

  rawset(tab, "number", get_number(tab))
  rawset(tab, "active_window", get_active_window(tab))
  rawset(tab, "active_buffer", get_active_buffer(tab))
  rawset(tab, "active_file", get_active_file(tab))
  rawset(tab, "long_name", get_long_name(tab))
  rawset(tab, "name", get_name(tab))
  rawset(tab, "windows", get_windows(tab))
  rawset(tab, "is_active", get_active_state(tab))

  return tab
end

function Tab:reload()
  rawset(self, "number", get_number(self, true))
  rawset(self, "active_window", get_active_window(self, true))
  rawset(self, "active_buffer", get_active_buffer(self, true))
  rawset(self, "active_file", get_active_file(self, true))
  rawset(self, "long_name", get_long_name(self, true))
  rawset(self, "name", get_name(self, true))
  rawset(self, "windows", get_windows(self, true))
  rawset(self, "is_active", get_active_state(self, true))

  return self
end

function Tab:activate()
  if not self.is_active then
    self.active_window:activate()
  end
end

function Tab.all()
  local tabids = vim.api.nvim_list_tabpages()
  local tabs = {}

  for _, tabid in pairs(tabids) do
    table.insert(tabs, Tab:new(tabid))
  end

  return tabs
end

return Tab
