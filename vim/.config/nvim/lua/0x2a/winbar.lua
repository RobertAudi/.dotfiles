-- Module: 0x2a.winbar
-- Requires:
--   - 0x2a.utils
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
  local filepath = ""
  local filename = vim.fn.expand("%:t", false, false)
  local filetype = vim.bo.filetype
  local utils = require("0x2a.utils")

  if utils.table_has_key(special_filenames, filename) then
    filepath = special_filenames[filename]
  elseif utils.table_has_key(special_filetypes, filetype) then
    filepath = special_filetypes[filetype]
  elseif utils.table_has_value(ignored_filetypes, filetype) then
    filepath = ""
  else
    local fileutils = require("0x2a.utils.files")

    filepath = vim.fn.expand("%", false, false)

    if fileutils.file_exists(filepath) then
      if vim.fn.winwidth(0) < 72 then
        if string.find(vim.fn.fnamemodify(filepath, ":p"), vim.fn.getcwd(), 1, true) then
          filepath = vim.fn.fnamemodify(filepath, ":t")
        else
          filepath = fileutils.shorten_path(filepath)
        end
      else
        filepath = fileutils.relative_path(filepath)
      end

      if vim.bo.modified then
        local symbols = require("0x2a.symbols")

        filepath = symbols.modified .. " " .. filepath
      end
    else
      filepath = "[No Name]"
    end
  end

  return filepath
end

M.setup = function()
  vim.o.winbar = "%{%v:lua.require(\"0x2a.winbar\").get()%}"
end

return M
