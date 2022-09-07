-- Module: 0x2a.utils.buffer
-- Requires:
--   - 0x2a.colors.utils
--   - 0x2a.utils
--   - 0x2a.utils.fs
--   - 0x2a.utils.table
--   - 0x2a.notifications

local M = {}

M.like_a_ninja = function(func)
  vim.validate({ func = { func, "function" } })

  local old_eventignore = vim.o.eventignore
  local old_lazyredraw = vim.o.lazyredraw

  vim.o.eventignore = "all"
  vim.o.lazyredraw = true

  local ok, err = pcall(func)

  vim.o.eventignore = old_eventignore
  vim.o.lazyredraw = old_lazyredraw

  if not ok then
    error(err)
  end
end

-- Source: https://github.com/gbprod/stay-in-place.nvim/blob/18572d2a734cb0fa40a521698d0507da41552ee7/lua/stay-in-place.lua#L29-L40
M.preserve = function(func, ...)
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  local len_before = vim.api.nvim_get_current_line():len()
  local winview = vim.fn.winsaveview()

  func(...)

  vim.fn.winrestview(winview)
  local len_after = vim.api.nvim_get_current_line():len()
  local new_col = math.max(0, col - len_before + len_after)

  vim.api.nvim_win_set_cursor(0, { line, new_col })
end

-- Copy the entire file
M.yank = function()
  M.preserve(function()
    vim.api.nvim_command("silent keepjumps keeppatterns normal! ggyG")
  end)
end

-- Reindent the entire file
M.reindent = function()
  M.preserve(function()
    vim.api.nvim_command("silent keepjumps keeppatterns normal! gg=G")
  end)
end

-- Select the entire file
M.select = function()
  vim.api.nvim_command("silent keepjumps keeppatterns normal! ggVG")
end

M.close = function(opts)
  vim.validate({
    opts = { opts, "table" },
    buffer = { opts.buffer, { "table", "string", "number", "nil" } },
    wipeout = { opts.wipeout, { "boolean", "nil" } },
    force = { opts.force, { "boolean", "nil" } },
  })

  local utils = require("0x2a.utils")
  local table_utils = require("0x2a.utils.table")

  local buffer_number = nil

  if type(opts.buffer) == "table" then
    if table_utils.len(opts.buffer) > 1 then
      return utils.error("E176: Invalid number of arguments")
    else
      opts.buffer = opts.buffer[1]
    end
  end

  if utils.is_blank(opts.buffer) then
    buffer_number = vim.api.nvim_get_current_buf()
  elseif opts.buffer:match("^%d+$") then
    buffer_number = vim.fn.bufnr(tonumber(opts.buffer))
  else
    buffer_number = vim.fn.bufnr(opts.buffer)
  end

  if buffer_number < 0 then
    return utils.error("E516: No buffers were deleted. No match for " .. vim.inspect(opts.buffer))
  end

  if utils.is_present(vim.api.nvim_buf_get_option(0, "buftype")) and not opts.force then
    return utils.error("Buffer " .. vim.inspect(opts.buffer) .. " is not a file.")
  end

  local action = nil

  if opts.wipeout then
    action = "bwipeout"
  else
    action = "bdelete"
  end

  if opts.force then
    action = action .. "!"
  end

  local source_window_seed = math.random()

  vim.api.nvim_win_set_var(0, "source_window_seed", source_window_seed)

  -- If the buffer is set to delete and it contains changes, we can't switch
  -- away from it. Hide it before eventual deleting:
  if vim.api.nvim_buf_get_option(0, "modified") and not opts.force then
    vim.api.nvim_buf_set_option(0, "bufhidden", true)
  end

  for _, window_number in pairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.api.nvim_win_get_buf(window_number) == buffer_number then
      vim.api.nvim_set_current_win(window_number)

      pcall(function()
        local alternate_buffer_number = vim.fn.bufnr("#")

        if alternate_buffer_number > 0 and vim.api.nvim_buf_get_option(alternate_buffer_number, "buflisted") then
          vim.api.nvim_set_current_buf(alternate_buffer_number)
        else
          vim.api.nvim_command("keepjumps bprevious")
        end
      end)

      if vim.api.nvim_get_current_buf() == buffer_number then
        if opts.force then
          vim.api.nvim_command("enew!")
        else
          vim.api.nvim_command("enew")
        end

        vim.api.nvim_buf_set_option(0, "swapfile", false)
        vim.api.nvim_buf_set_option(0, "bufhidden", "wipe")
        vim.api.nvim_buf_set_option(0, "buftype", "")
        vim.api.nvim_buf_set_option(0, "buflisted", false)
      end
    end
  end

  local source_window_number = table_utils.filter(vim.api.nvim_tabpage_list_wins(0), function(_, winnr)
    local ok, seed = pcall(vim.api.nvim_win_get_var, winnr, "source_window_seed")

    return ok and seed == source_window_seed
  end)[1]

  if source_window_number then
    vim.api.nvim_command("keepjumps execute " .. source_window_number .. "wincmd w")
    pcall(vim.api.nvim_win_del_var, source_window_number, "source_window_seed")
  end

  -- If it hasn't been already deleted by &bufhidden, end its pains now.
  -- Unless it previously was an unnamed buffer and :enew returned it again.
  --
  -- Using buflisted() over bufexists() because bufhidden=delete causes the
  -- buffer to still _exist_ even though it won't be :bdelete-able.
  if vim.api.nvim_buf_get_option(buffer_number, "buflisted") and buffer_number ~= vim.api.nvim_get_current_buf() then
    vim.cmd.lclose()
    vim.api.nvim_command(action .. " " .. buffer_number)
  end
end

-- TODO: Reopen nvim-tree if it was open
M.close_all = function(opts)
  vim.validate({
    opts = { opts, { "table" } },
    except = { opts.except, { "table", "string", "number", "nil" } },
    force = { opts.force, { "boolean", "nil" } },
  })

  local utils = require("0x2a.utils")
  local table_utils = require("0x2a.utils.table")

  if type(opts.except) == "table" then
    if table_utils.len(opts.except) > 1 then
      return utils.error("E176: Invalid number of arguments")
    else
      opts.except = opts.except[1]
    end
  end

  opts.except = utils.presence(opts.except)

  if opts.except then
    opts.except = vim.fn.bufnr(opts.except)
  end

  local buffers = table_utils.filter(vim.api.nvim_list_bufs(), function(_, bufnr)
    return (not opts.except or opts.except ~= bufnr)
      and (vim.api.nvim_buf_get_option(bufnr, "buflisted") or vim.api.nvim_buf_is_loaded(bufnr))
  end)

  local deleted_count = 0

  M.like_a_ninja(function()
    for _, buffer in pairs(buffers) do
      local buflisted = vim.api.nvim_buf_get_option(buffer, "buflisted")

      if vim.api.nvim_buf_get_option(buffer, "buftype") ~= "terminal" then
        if not buflisted then
          vim.api.nvim_buf_delete(buffer, { force = true })
        elseif vim.api.nvim_buf_get_option(buffer, "modified") and buflisted and not opts.force then
          utils.error("No write since last change for buffer " .. buffer .. " (add ! to override)")
        else
          pcall(function()
            local action = "bdelete"

            if opts.force then
              action = action .. "!"
            end

            vim.api.nvim_command("silent! " .. action .. " " .. buffer)

            deleted_count = deleted_count + 1
          end)
        end
      end
    end

    vim.cmd.only()
  end)

  local message = deleted_count .. " buffer"

  if deleted_count ~= 1 then
    message = message .. "s"
  end

  message = message .. " deleted"

  require("0x2a.notifications").success(message)
end

M.count = function()
  local utils = require("0x2a.utils")
  local buffers = vim.api.nvim_list_bufs()
  local count = 0

  for _, buffer_number in pairs(buffers) do
    if
      vim.api.nvim_buf_get_option(buffer_number, "filetype") ~= "alpha"
        and (vim.api.nvim_buf_get_option(buffer_number, "buflisted") and vim.api.nvim_buf_is_loaded(buffer_number) and (utils.is_present(
          vim.fn.bufname(buffer_number)
        ) or vim.api.nvim_buf_get_option(buffer_number, "modified")))
      or (not vim.api.nvim_buf_get_option(buffer_number, "buflisted") and vim.fn.winbufnr(buffer_number) ~= -1)
    then
      count = count + 1
    end
  end

  return count
end

M.alternate_buffer_exists = function()
  return vim.fn.bufnr("#") ~= -1
end

M.delete_active_file = function(opts)
  vim.validate({
    opts = { opts, "table" },
    keep_layout = { opts.keep_layout, { "boolean", "nil" } },
    force = { opts.force, { "boolean", "nil" } },
  })

  local file_path = vim.api.nvim_buf_get_name(0)
  local buffer_number = vim.fn.bufnr(file_path)

  if opts.keep_layout then
    M.close({ buffer = file_path, wipeout = true, force = opts.force })
  else
    vim.api.nvim_buf_delete(buffer_number, { force = opts.force })
  end

  local fsutils = require("0x2a.utils.fs")
  local notifications = require("0x2a.notifications")

  if not vim.api.nvim_buf_is_loaded(buffer_number) and fsutils.rm(file_path) then
    notifications.success("Deleted file: " .. file_path)
  else
    notifications.error("Failed to delete: " .. vim.inspect(file_path))
  end
end

return M
