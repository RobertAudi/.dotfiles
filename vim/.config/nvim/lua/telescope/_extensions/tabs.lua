-- Description: Tabs Telescope extension
-- Requires:
--   - nvim-telescope/telescope.nvim
--   - 0x2a.symbols
--   - 0x2a.utils.table
--   - 0x2a.editor.tab
--   - 0x2a.editor.window

local has_telescope, telescope = pcall(require, "telescope")

if not has_telescope then
  error("This plugin requires nvim-telescope/telescope.nvim")
end

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local config = require("telescope.config").values
local entry_display = require("telescope.pickers.entry_display")
local symbols = require("0x2a.symbols")
local table_utils = require("0x2a.utils.table")
local Tab = require("0x2a.editor.tab")
local Window = require("0x2a.editor.window")

local function focus_tab(prompt_bufnr)
  actions.close(prompt_bufnr)

  local entry = action_state.get_selected_entry()

  Window:new(entry.windownr):activate()
end

local build_indicator = function(entry)
  local windows_count = table_utils.len(entry.windows)
  local indicator = ""

  if windows_count == 1 then
    indicator = "1 window"
  else
    indicator = windows_count .. " windows"
  end

  return indicator
end

local make_entry = function(opts)
  opts = opts or {}

  local displayer = entry_display.create({
    separator = "",
    items = {
      { width = opts.tabnr_width + 4 },
      { width = opts.indicator_width + 4 },
      { remaining = true },
    },
  })

  local cwd = vim.fn.expand(opts.cwd or vim.loop.cwd())

  local make_display = function(entry)
    opts.__prefix = opts.tabnr_width + 4 + opts.indicator_width + 4

    local buffer = entry.tab.active_buffer
    local name = buffer.name

    if buffer.info.modified then
      name = symbols.modified .. " " .. name
    else
      name = string.rep(" ", vim.fn.strdisplaywidth(symbols.modified)) .. " " .. name
    end

    if buffer.info.readonly or not buffer.info.modifiable then
      name = symbols.codicon.lock .. " " .. name
    else
      name = string.rep(" ", vim.fn.strdisplaywidth(symbols.codicon.lock)) .. " " .. name
    end

    return displayer({
      { entry.tabnr, "TelescopeResultsNumber" },
      { entry.indicator, "TelescopeResultsComment" },
      name,
    })
  end

  return function(entry)
    local entry_name = entry.name
    local tabnr = entry.number
    local windows_count = table_utils.len(entry.windows)
    local indicator = build_indicator(entry)
    local lnum = entry.active_buffer.info.line_count

    return {
      valid = true,

      value = entry_name,
      ordinal = entry.number .. " : " .. entry_name,
      display = make_display,

      tabnr = tabnr,
      tabidx = entry.id,
      windownr = entry.active_window.id,
      filename = entry.active_file,
      tab = entry,

      lnum = lnum,
      indicator = indicator,
    }
  end
end

M = {}

M.pick = function(opts)
  opts = vim.F.if_nil(opts, {}, opts)

  local tabs = Tab.all()

  if not opts.tabnr_width then
    local tabnrs = table_utils.flatten(table_utils.pluck(tabs, "number"))
    local max_tabnr = math.max(unpack(tabnrs))

    opts.tabnr_width = #tostring(max_tabnr)
  end

  if not opts.indicator_width then
    local indicator_widths = table_utils.map(tabs, function(_, tab)
      return string.len(build_indicator(tab))
    end)

    opts.indicator_width = math.max(unpack(indicator_widths))
  end

  pickers.new(opts, {
    prompt_title = "Tabs",

    finder = finders.new_table({
      results = tabs,
      entry_maker = make_entry(opts),
    }),

    attach_mappings = function(_, map)
      map("i", "<CR>", focus_tab)
      map("n", "<CR>", focus_tab)
      return true
    end,

    previewer = config.file_previewer(opts),
    sorter = config.generic_sorter(opts),
    default_selection_index = vim.api.nvim_get_current_tabpage(),
  }):find()
end

return telescope.register_extension({
  exports = {
    tabs = M.pick,
  },
})
