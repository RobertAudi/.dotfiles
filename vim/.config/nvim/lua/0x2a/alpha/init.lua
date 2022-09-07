-- Module: 0x2a.alpha
-- Requires:
--   - 0x2a.utils
--   - 0x2a.utils.buffer
--   - 0x2a.alpha.utils
--   - 0x2a.alpha.dashboards

local utils = require("0x2a.utils")
local alpha_utils = require("0x2a.alpha.utils")

local alpha = {}

local cursor_ix = 1
local cursor_jumps = {}
local cursor_jumps_press = {}
local cursor_jumps_press_queue = {}

local current_config
local current_state

function alpha.press()
  for queued_cursor_ix, _ in pairs(cursor_jumps_press_queue) do
    cursor_jumps_press[queued_cursor_ix]()
  end

  -- only press under the cursor if there's no queue
  if vim.tbl_count(cursor_jumps_press_queue) == 0 then
    cursor_jumps_press[cursor_ix]()
  end
end

function alpha.queue_press()
  if cursor_jumps_press_queue[cursor_ix] then
    cursor_jumps_press_queue[cursor_ix] = nil
  else
    cursor_jumps_press_queue[cursor_ix] = true

    -- temporary, find a way to do this in a pure, data-oriented way
    local cursor = vim.api.nvim_win_get_cursor(0)
    local row = cursor[1]
    local col = cursor[2]

    vim.api.nvim_buf_set_option(0, "modifiable", true)
    vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col + 1, { "*" })
    vim.api.nvim_buf_set_option(0, "modifiable", false)

    local height = vim.api.nvim_win_get_height(0)

    vim.api.nvim_win_set_cursor(0, { math.min(row + 1, height + 2), col })
  end
end

local layout_element = {}

function layout_element.text(el, conf, state)
  if type(el.val) == "table" then
    local end_ln = state.line + #el.val
    local val = el.val
    local hl = {}
    local padding = { left = 0 }

    if conf.opts and conf.opts.margin and el.opts and (el.opts.position ~= "center") then
      local left

      val, left = alpha_utils.pad_margin(val, state, conf.opts.margin, vim.F.if_nil(el.opts.shrink_margin, true))
      padding.left = padding.left + left
    end

    if el.opts then
      if el.opts.position == "center" then
        local left

        val, left = alpha_utils.align_center(val, state)
        padding.left = padding.left + left
      end
      -- if el.opts.wrap == "overflow" then
      --     val = alpha_utils.trim(val, state)
      -- end
    end

    if el.opts and el.opts.hl then
      hl = alpha_utils.highlight(state, end_ln, el.opts.hl, padding.left)
    end

    state.line = end_ln

    return val, hl
  end

  if type(el.val) == "string" then
    local val = {}
    local hl = {}

    for s in el.val:gmatch("[^\r\n]+") do
      val[#val + 1] = s
    end

    local padding = { left = 0 }

    if conf.opts and conf.opts.margin and (not el.opts or el.opts.position ~= "center") then
      local left

      val, left = alpha_utils.pad_margin(
        val,
        state,
        conf.opts.margin,
        vim.F.if_nil(el.opts and el.opts.shrink_margin, true)
      )

      padding.left = padding.left + left
    end

    if el.opts then
      if el.opts.position == "center" then
        local left

        val, left = alpha_utils.align_center(val, state)
        padding.left = padding.left + left
      end
    end

    if el.opts and el.opts.hl then
      hl = alpha_utils.highlight(state, state.line, el.opts.hl, padding.left)
    end

    state.line = state.line + 1

    return val, hl
  end

  if type(el.val) == "function" then
    return alpha_utils.resolve(layout_element.text, el, conf, state)
  end
end

function layout_element.padding(el, conf, state)
  local lines = 0

  if type(el.val) == "function" then
    lines = el.val()
  end

  if type(el.val) == "number" then
    lines = el.val
  end

  local val = {}

  for i = 1, lines do
    val[i] = ""
  end

  local end_ln = state.line + lines

  state.line = end_ln

  return val, {}
end

function layout_element.button(el, conf, state)
  local val = {}
  local hl = {}
  local padding = {
    left = 0,
    center = 0,
    right = 0,
  }

  local title = el.val

  if type(title) == "function" then
    title = title()
  end

  if el.opts and el.opts.shortcut then
    -- this min lets the padding resize when the window gets smaller
    if el.opts.width then
      local max_width = math.min(el.opts.width, state.win_width)

      if el.opts.align_shortcut == "right" then
        padding.center = max_width - (vim.fn.strdisplaywidth(title) + vim.fn.strdisplaywidth(el.opts.shortcut))
      else
        padding.right = max_width - (vim.fn.strdisplaywidth(title) + vim.fn.strdisplaywidth(el.opts.shortcut))
      end
    end

    if el.opts.align_shortcut == "right" then
      val = { table.concat({ title, string.rep(" ", padding.center), el.opts.shortcut }) }
    else
      val = { table.concat({ el.opts.shortcut, title, string.rep(" ", padding.right) }) }
    end
  else
    val = { title }
  end

  -- margin
  if conf.opts and conf.opts.margin and el.opts and (el.opts.position ~= "center") then
    local left

    val, left = alpha_utils.pad_margin(val, state, conf.opts.margin, vim.F.if_nil(el.opts.shrink_margin, true))

    if el.opts.align_shortcut == "right" then
      padding.center = padding.center + left
    else
      padding.left = padding.left + left
    end
  end

  -- center
  if el.opts then
    if el.opts.position == "center" then
      local left

      val, left = alpha_utils.align_center(val, state)

      if el.opts.align_shortcut == "right" then
        padding.center = padding.center + left
      end

      padding.left = padding.left + left
    end
  end

  local row = state.line + 1
  local _, count_spaces = string.find(val[1], "%s*")
  local col = ((el.opts and el.opts.cursor) or 0) + count_spaces

  cursor_jumps[#cursor_jumps + 1] = { row, col }
  cursor_jumps_press[#cursor_jumps_press + 1] = el.on_press

  if el.opts and el.opts.hl_shortcut then
    if type(el.opts.hl_shortcut) == "string" then
      hl = { { el.opts.hl_shortcut, 0, vim.fn.strdisplaywidth(el.opts.shortcut) + 1 } }
    else
      hl = el.opts.hl_shortcut
    end

    if el.opts.align_shortcut == "right" then
      hl = alpha_utils.highlight(state, state.line, hl, #title + padding.center)
    else
      hl = alpha_utils.highlight(state, state.line, hl, padding.left)
    end
  end

  if el.opts and el.opts.hl then
    local left = padding.left

    if el.opts.align_shortcut == "left" then
      left = left + vim.fn.strdisplaywidth(el.opts.shortcut) + 2
    end

    vim.list_extend(hl, alpha_utils.highlight(state, state.line, el.opts.hl, left))
  end

  state.line = state.line + 1

  return val, hl
end

function layout_element.group(el, conf, state)
  if type(el.val) == "function" then
    return alpha_utils.resolve(layout_element.group, el, conf, state)
  end

  if type(el.val) == "table" then
    local text_tbl = {}
    local hl_tbl = {}

    for _, v in pairs(el.val) do
      local text, hl = layout_element[v.type](v, conf, state)

      if text then
        vim.list_extend(text_tbl, text)
      end

      if hl then
        vim.list_extend(hl_tbl, hl)
      end

      if el.opts and el.opts.spacing then
        local padding_el = { type = "padding", val = el.opts.spacing }
        local text_1, hl_1 = layout_element[padding_el.type](padding_el, conf, state)

        vim.list_extend(text_tbl, text_1)
        vim.list_extend(hl_tbl, hl_1)
      end
    end

    return text_tbl, hl_tbl
  end
end

local function layout(conf, state)
  -- this is my way of hacking pattern matching
  -- you index the table by its "type"
  local hl = {}
  local text = {}

  for _, el in pairs(conf.layout) do
    local text_el, hl_el = layout_element[el.type](el, conf, state)

    vim.list_extend(text, text_el)
    vim.list_extend(hl, hl_el)
  end

  vim.api.nvim_buf_set_lines(state.buffer, 0, -1, false, text)

  for _, hl_line in pairs(hl) do
    vim.api.nvim_buf_add_highlight(hl_line[1], hl_line[2], hl_line[3], hl_line[4], hl_line[5], hl_line[6])
  end
end

local keymaps_element = {}

keymaps_element.text = utils.noop
keymaps_element.padding = utils.noop

function keymaps_element.button(el, conf, state)
  if el.opts and el.opts.keymap then
    if type(el.opts.keymap[1]) == "table" then
      for _, map in el.opts.keymap do
        alpha_utils.set_buffer_keymap(state.buffer, map[1], map[2], map[3], map[4])
      end
    else
      local map = el.opts.keymap

      alpha_utils.set_buffer_keymap(state.buffer, map[1], map[2], map[3], map[4])
    end
  end
end

function keymaps_element.group(el, conf, state)
  if type(el.val) == "function" then
    alpha_utils.resolve(keymaps_element.group, el, conf, state)
  end

  if type(el.val) == "table" then
    for _, v in pairs(el.val) do
      keymaps_element[v.type](v, conf, state)
    end
  end
end

local function keymaps(conf, state)
  for _, el in pairs(conf.layout) do
    keymaps_element[el.type](el, conf, state)
  end
end

-- stylua: ignore start
local enable_alpha = function(conf, state)
  local eventignore = vim.opt.eventignore

  if conf.opts.noautocmd then
    vim.opt.eventignore = "all"
  end

  vim.opt_local.bufhidden = "wipe"
  vim.opt_local.buflisted = false
  vim.opt_local.matchpairs = ""
  vim.opt_local.swapfile = false
  vim.opt_local.buftype = "nofile"
  vim.opt_local.filetype = "alpha"
  vim.opt_local.synmaxcol = 0
  vim.opt_local.wrap = false
  vim.opt_local.colorcolumn = ""
  vim.opt_local.foldlevel = 999
  vim.opt_local.foldcolumn = "0"
  vim.opt_local.cursorcolumn = false
  vim.opt_local.number = false
  vim.opt_local.relativenumber = false
  vim.opt_local.list = false
  vim.opt_local.spell = false
  vim.opt_local.signcolumn = "no"
  vim.b.cursorword = 0

  vim.w.previous_global_options = {
    cmdheight = vim.o.cmdheight,
    laststatus = vim.o.laststatus,
    showtabline = vim.o.showtabline,
    showcmd = vim.o.showcmd,
  }

  vim.o.cmdheight = 0
  vim.o.laststatus = 0
  vim.o.showtabline = 0
  vim.o.showcmd = false

  require("0x2a.utils").hide_cursor()

  if conf.opts.noautocmd then
    vim.opt.eventignore = eventignore
  end

  local group_id = vim.api.nvim_create_augroup("alpha_temp", { clear = true })

  vim.api.nvim_create_autocmd({ "BufUnload", "BufWinLeave" }, {
    group = group_id,
    pattern = "<buffer>",
    callback = alpha.close,
    once = true,
  })

  vim.api.nvim_create_autocmd("WinLeave", {
    group = group_id,
    callback = function()
      alpha.close(_, state)
      vim.api.nvim_buf_delete(vim.api.nvim_get_current_buf(), {})
    end,
  })

  vim.api.nvim_create_autocmd("CursorMoved", {
    group = group_id,
    pattern = "<buffer>",
    callback = function()
      alpha.move_cursor(state.window)
    end,
  })

  if conf.opts then
    if vim.F.if_nil(conf.opts.redraw_on_resize, true) then
      vim.api.nvim_create_autocmd("VimResized", {
        group = group_id,
        callback = function()
          alpha.redraw(conf, state)
        end,
      })
    end

    if conf.opts.setup then
      conf.opts.setup()
    end
  end

  state.open = true
end
-- stylua: ignore end

function alpha.draw(conf, state)
  for k in pairs(cursor_jumps) do
    cursor_jumps[k] = nil
  end

  for k in pairs(cursor_jumps_press) do
    cursor_jumps_press[k] = nil
  end

  state.win_width = vim.api.nvim_win_get_width(state.window)
  state.line = 0

  -- this is for redraws. i guess the cursor 'moves'
  -- when the screen is cleared and then redrawn
  -- so we save the index before that happens
  local ix = cursor_ix

  vim.api.nvim_buf_set_option(state.buffer, "modifiable", true)
  vim.api.nvim_buf_set_lines(state.buffer, 0, -1, false, {})

  layout(conf, state)

  vim.api.nvim_buf_set_option(state.buffer, "modifiable", false)

  vim.keymap.set("n", "<Enter>", function()
    require("0x2a.alpha").press()
  end, { buffer = state.buffer, noremap = false, silent = true })

  vim.keymap.set("n", "<M-CR>", function()
    require("0x2a.alpha").queue_press()
  end, { buffer = state.buffer, noremap = false, silent = true })

  vim.keymap.set("n", "<Esc>", "<Cmd>enew<CR>", {
    buffer = state.buffer,
    noremap = false,
    silent = true,
  })

  vim.api.nvim_win_set_cursor(state.window, cursor_jumps[ix])
end

function alpha.redraw(conf, state)
  conf = conf or current_config
  state = state or current_state

  if state.open then
    alpha.draw(conf, state)
  end
end

function alpha.move_cursor(window)
  if current_state.open then
    local cursor = vim.api.nvim_win_get_cursor(window)
    local closest_ix, closest_pt = alpha_utils.closest_cursor_jump(cursor, cursor_jumps, cursor_jumps[cursor_ix])

    cursor_ix = closest_ix
    vim.api.nvim_win_set_cursor(window, closest_pt)
  end
end

function alpha.close(_, state)
  state = state or current_state
  state.open = false
  cursor_ix = 1
  cursor_jumps = {}
  cursor_jumps_press = {}

  require("0x2a.utils").show_cursor()

  local previous_global_options = vim.F.if_nil(vim.w.previous_global_options, {}, vim.w.previous_global_options)

  vim.o.cmdheight = previous_global_options.cmdheight or vim.g.default_cmdheight or 2
  vim.o.laststatus = previous_global_options.laststatus or vim.g.default_laststatus or 3
  vim.o.showtabline = previous_global_options.showtabline or vim.g.default_tabline or 2

  if previous_global_options.showcmd ~= nil then
    vim.o.showcmd = previous_global_options.showcmd
  elseif vim.g.default_showcmd ~= nil then
    vim.o.showcmd = vim.g.default_showcmd
  else
    vim.o.showcmd = true
  end

  vim.api.nvim_del_augroup_by_name("alpha_temp")
  vim.api.nvim_exec_autocmds("User", { pattern = "AlphaClosed" })
end

function alpha.start(on_vimenter, conf)
  local window = vim.api.nvim_get_current_win()
  local buffer

  if on_vimenter then
    if alpha_utils.should_skip_alpha() then
      return
    end

    buffer = vim.api.nvim_get_current_buf()
  else
    if vim.bo.ft ~= "alpha" then
      buffer = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_win_set_buf(window, buffer)
    else
      buffer = vim.api.nvim_get_current_buf()
      vim.api.nvim_buf_delete(buffer, {})
      return
    end
  end

  if not vim.o.hidden and vim.opt_local.modified:get() then
    vim.api.nvim_err_writeln("Save your changes first.")
    return
  end

  conf = conf or current_config

  local state = {
    line = 0,
    buffer = buffer,
    window = window,
    win_width = 0,
    open = false,
  }

  current_state = state

  enable_alpha(conf, state)

  alpha.draw(conf, state)

  vim.api.nvim_exec_autocmds("User", { pattern = "AlphaReady" })

  vim.cmd.doautocmd("User AlphaReady")

  keymaps(conf, state)
end

function alpha.setup(config)
  config = config or require("0x2a.alpha.dashboards").get()

  vim.validate({
    config = { config, "table" },
    layout = { config.layout, "table" },
  })

  config.opts = vim.tbl_extend("keep", vim.F.if_nil(config.opts, {}), { autostart = true })

  current_config = config

  vim.api.nvim_create_user_command("Alpha", function()
    alpha.start(false)
  end, {
    bang = true,
    desc = [["require("0x2a.alpha").start(false)"]],
  })

  vim.api.nvim_create_user_command("AlphaRedraw", alpha.redraw, {
    bang = true,
    desc = [["require("0x2a.alpha").redraw()"]],
  })

  local group_id = vim.api.nvim_create_augroup("alpha_start", { clear = true })

  vim.api.nvim_create_autocmd("VimEnter", {
    group = group_id,
    nested = true,
    callback = function()
      if current_config.opts.autostart then
        alpha.start(true)
      end
    end,
  })

  vim.api.nvim_create_autocmd({ "CmdlineEnter" }, {
    group = group_id,
    callback = function()
      if vim.bo.filetype == "alpha" then
        require("0x2a.utils").show_cursor()
      end
    end,
  })

  vim.api.nvim_create_autocmd({ "CmdlineLeave" }, {
    group = group_id,
    callback = function()
      if vim.bo.filetype == "alpha" then
        require("0x2a.utils").hide_cursor()
      end
    end,
  })
end

alpha.layout_element = layout_element
alpha.keymaps_element = keymaps_element

return alpha
