-- Module: 0x2a.winbar
-- Requires:
--   - 0x2a.utils.fs
--   - 0x2a.utils.table
--   - nvim-lua/plenary.nvim

local ignored_filetypes = {
  "TelescopePrompt",
  "TelescopeResults",
  "diff",
}

local special_filetypes = {
  NvimTree = "Tree",
  aerial = "Symbols",
  toggleterm = "Terminal",
  Trouble = "Trouble",
  packer = "Packer",
  help = "Help",
  qf = "Quickfix",
  man = "Man",
  ctrlsf = "CtrlSF",
  gitrebase = "Interactive rebase",
  gitblame = "Blame",
  git = "Git",
}

local special_filenames = {
  __committia_diff__ = "Diff",
  __committia_status__ = "Status",
  COMMIT_EDITMSG = "Commit message",
}

local M = {}

M.get = function()
  if require("0x2a.utils.plugins").luapad.is_active() then
    return "Luapad"
  end

  local fsutils = require("0x2a.utils.fs")
  local table_utils = require("0x2a.utils.table")

  local filepath = ""
  local filetype = vim.bo.filetype
  local current_file = fsutils.current_file()

  if filetype == "alpha" then
    return ""
  end

  if table_utils.has_key(special_filenames, current_file.name) then
    filepath = special_filenames[current_file.name]
  elseif table_utils.has_key(special_filetypes, filetype) then
    filepath = special_filetypes[filetype]
  elseif table_utils.has_value(ignored_filetypes, filetype) then
    filepath = ""
  else
    if fsutils.file_exists(current_file.path) then
      if vim.fn.winwidth(0) < 72 then
        if string.find(current_file.path, vim.fn.getcwd(), 1, true) then
          filepath = current_file.name
        else
          filepath = fsutils.shorten_path(current_file.path)
        end
      else
        filepath = fsutils.relative_path(current_file.path)
      end

      if vim.bo.modified then
        local symbols = require("0x2a.symbols")

        filepath = symbols.modified .. " " .. filepath
      end
    else
      filepath = "[No Name]"
    end
  end

  if vim.t.maximized then
    return "   " .. filepath
  else
    return filepath
  end
end

M.setup = function()
  vim.o.winbar = "%{%v:lua.require(\"0x2a.winbar\").get()%}"
end

return M
