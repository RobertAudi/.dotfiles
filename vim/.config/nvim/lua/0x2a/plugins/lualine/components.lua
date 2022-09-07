-- Module: 0x2a.plugins.lualine.predicates
-- Requires:
--   - 0x2a.symbols
--   - 0x2a.utils
--   - 0x2a.plugins.lualine.config
--   - nvim-lualine/lualine.nvim
--   - 0x2a.plugins.lualine.predicates
--   - SmiteshP/nvim-navic

local symbols = require("0x2a.symbols")
local utils = require("0x2a.utils")
local plugin_utils = require("0x2a.utils.plugins")

local config = require("0x2a.plugins.lualine.config")
local predicates = require("0x2a.plugins.lualine.predicates")

local lualine = {
  mode = require("lualine.utils.mode"),
  utils = require("lualine.utils.utils"),
}

local M = {}

M.progress = function()
  if predicates.ignore_filetype(vim.bo.filetype) or predicates.is_terminal(vim.bo.filetype) then
    return ""
  else
    local numlines = vim.api.nvim_buf_line_count(0)

    if numlines > 1 then
      return "%3p%%" .. " (" .. numlines .. " lines)"
    else
      return ""
    end
  end
end

M.location = function()
  if predicates.ignore_filetype(vim.bo.filetype) or predicates.is_terminal(vim.bo.filetype) then
    return ""
  else
    return "%3l:%-2v"
  end
end

M.mode = function()
  if plugin_utils.luapad.is_active() then
    return "Luapad"
  end

  local filetype = vim.bo.filetype

  if predicates.is_plugin_filetype(filetype) then
    return config.plugin_filetypes[filetype]
  elseif predicates.is_special_filetype(filetype) then
    return config.special_filetypes[filetype]
  elseif predicates.ignore_filetype(filetype) then
    return ""
  else
    local ok, hydra = pcall(require, "hydra.statusline")

    if ok and hydra.is_active() then
      return hydra.get_name() or "Hydra"
    else
      return lualine.mode.get_mode()
    end
  end
end

M.paste = function()
  local filetype = vim.bo.filetype

  if predicates.ignore_filetype(filetype) or not vim.o.paste then
    return ""
  else
    return "PASTE"
  end
end

M.filename = function()
  if
    plugin_utils.luapad.is_active()
    or predicates.ignore_plugin_filetype(vim.bo.filetype)
    or predicates.is_terminal(vim.bo.filetype)
    or predicates.is_startup_page(vim.bo.filetype)
  then
    return ""
  end

  local data = lualine.utils.stl_escape(vim.fn.expand("%:t"))

  if utils.is_empty(data) then
    data = "[No Name]"
  end

  if vim.bo.readonly or not vim.bo.modifiable then
    data = symbols.codicon.lock .. " " .. data
  end

  if vim.bo.modified then
    data = data .. " " .. symbols.modified
  end

  return data
end

M.filetype = function()
  if plugin_utils.luapad.is_active() then
    return ""
  end

  local filetype = vim.bo.filetype

  if predicates.is_plugin_filetype(filetype) or predicates.is_special_filetype(filetype) then
    return ""
  elseif predicates.is_terminal(filetype) then
    return config.terminal_filetypes[filetype]
  end

  local data = lualine.utils.stl_escape(filetype)

  if utils.is_empty(data) then
    return "no ft"
  else
    return "[" .. data .. "]"
  end
end

M.git = function()
  local branch_name = vim.fn["gitbranch#name"]()

  if utils.is_present(branch_name) then
    branch_name = " " .. symbols.git.branch .. "  " .. branch_name
  end

  return branch_name
end

M.navic = function()
  local navic = prequire("nvim-navic")

  if navic and navic.is_available then
    return navic.get_location()
  end
end

-- Source: https://github.com/lkhphuc/dotfiles/blob/566839def4f49e1024a809e15a7ebc96d421b3ce/nvim/lua/my/lualine.lua#L66-L79
M.diff = {
  "diff",
  symbols = { added = " ", modified = " ", removed = " " },
  colored = true,
  source = function()
    local gitsigns = vim.b.gitsigns_status_dict

    if gitsigns then
      return {
        added = gitsigns.added,
        modified = gitsigns.changed,
        removed = gitsigns.removed,
      }
    end
  end,
}

-- Source: https://github.com/lkhphuc/dotfiles/blob/566839def4f49e1024a809e15a7ebc96d421b3ce/nvim/lua/my/lualine.lua#L134,142
M.diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn", "info", "hint" },
  symbols = {
    error = symbols.diagnostics.error .. " ",
    warn = symbols.diagnostics.warning .. " ",
    info = symbols.diagnostics.info .. " ",
    hint = symbols.diagnostics.hint .. " ",
  },
  colored = true,
  update_in_insert = false,
  separator = false,
}

-- Source: https://github.com/lkhphuc/dotfiles/blob/566839def4f49e1024a809e15a7ebc96d421b3ce/nvim/lua/my/lualine.lua#L119,132
M.lsp_clients = {
  function(_)
    local clients = vim.lsp.get_active_clients({ bufnr = 0 })

    if next(clients) == nil then
      return ""
    end

    local output = " "

    for _, client in pairs(clients) do
      output = output .. ":" .. client.name
    end
    return output
  end,

  cond = function()
    return vim.o.columns > 100
  end,
}

return M
