-- Module: 0x2a.editor.buffer
-- Requires:
--   - nvim-lua/plenary.nvim
--   - 0x2a.utils
--   - 0x2a.utils.fs
--   - 0x2a.utils.table

local Path = require("plenary.path")
local utils = require("0x2a.utils")
local fsutils = require("0x2a.utils.fs")
local table_utils = require("0x2a.utils.table")

local function validate_buffer(buffer)
  vim.validate({ buffer = { buffer, "table" } })

  vim.validate({
    bufid = { buffer.id, vim.api.nvim_buf_is_valid },
    cwd = { buffer.cwd, "string" },
  })
end

local function get_info(buffer, reload)
  validate_buffer(buffer)

  if reload or not buffer.info then
    local info = vim.fn.getbufinfo(buffer.id)

    vim.validate({
      bufcount = {
        table_utils.len(info),
        function(count)
          return count == 1
        end
      }
    })

    local bufinfo = info[1]

    vim.validate({
      bufnr = {
        bufinfo.bufnr,

        function(bufnr)
          return buffer.id == bufnr
        end,
      },
    })

    rawset(buffer, "info", {
      number = bufinfo.bufnr,
      hidden = bufinfo.hidden,
      listed = bufinfo.listed,
      loaded = bufinfo.loaded,
      changed = bufinfo.changed,
      modified = vim.api.nvim_buf_get_option(bufinfo.bufnr, "modified"),
      modifiable = vim.api.nvim_buf_get_option(bufinfo.bufnr, "modifiable"),
      readonly = vim.api.nvim_buf_get_option(bufinfo.bufnr, "readonly"),
      line_number = bufinfo.line_number,
      line_count = bufinfo.line_count,
      name = bufinfo.name,
      filetype = vim.api.nvim_buf_get_option(bufinfo.bufnr, "filetype"),
      type = vim.api.nvim_buf_get_option(bufinfo.bufnr, "buftype"),
      window_ids = bufinfo.windows
    })
  end

  return buffer.info
end

local function get_number(buffer, reload)
  return get_info(buffer, reload).number
end

local function get_file(buffer, reload)
  return get_info(buffer, reload).name
end

local function get_long_name(buffer, reload)
  validate_buffer(buffer)

  if reload or not buffer.long_name then
    rawset(buffer, "long_name", get_info(buffer, reload).name or "[No Name]")
  end

  return buffer.long_name
end

local function get_name(buffer, reload)
  validate_buffer(buffer)

  if reload or not buffer.name then
    local info = get_info(buffer, reload)
    local path = info.name

    if utils.is_present(path) then
      local parent = Path:new(path):parent():absolute()
      local name = path:sub(#parent + 1):gsub("^/?", "")

      rawset(buffer, "name", name)
    else
      rawset(buffer, "name", "[No Name]")
    end
  end

  return buffer.name
end

local Buffer = {}

Buffer.__index = Buffer
Buffer.__metatable = false
Buffer.__newindex = function(_, _, _)
  error("Attempt to modify read-only table")
end

function Buffer:new(bufid)
  vim.validate({
    bufid = { bufid, vim.api.nvim_buf_is_valid },
  })

  local buffer = {}

  setmetatable(buffer, Buffer)

  if bufid == 0 then
    bufid = vim.api.nvim_get_current_buf()
  end

  rawset(buffer, "id", bufid)

  rawset(buffer, "cwd", vim.loop.fs_realpath("."))

  rawset(buffer, "info", get_info(buffer))
  rawset(buffer, "number", get_number(buffer))
  rawset(buffer, "file", get_file(buffer))
  rawset(buffer, "long_name", get_long_name(buffer))
  rawset(buffer, "name", get_name(buffer))

  return buffer
end

function Buffer:reload()
  rawset(self, "info", get_info(self, true))
  rawset(self, "number", get_number(self, true))
  rawset(self, "file", get_file(self, true))
  rawset(self, "long_name", get_long_name(self, true))
  rawset(self, "name", get_name(self, true))

  return self
end

return Buffer
