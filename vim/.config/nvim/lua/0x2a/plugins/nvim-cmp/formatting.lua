-- Module: 0x2a.plugins.nvim-cmp.formatting
-- Plugin: hrsh7th/nvim-cmp
-- Description: A completion plugin for neovim coded in Lua.
-- URL: https://github.com/hrsh7th/nvim-cmp
-- Requires:
--   - 0x2a.symbols

local symbols = require("0x2a.symbols")

local kind_icons = {
  Text = symbols.lsp.Text .. " (text)",
  Method = symbols.lsp.Method .. " (method)",
  Function = symbols.lsp.Function .. " (function)",
  Constructor = symbols.lsp.Constructor .. " (constructor)",
  Field = symbols.lsp.Field .. " (field)",
  Variable = symbols.lsp.Variable .. " (var)",
  Class = symbols.lsp.Class .. " (class)",
  Interface = symbols.lsp.Interface .. " (interface)",
  Module = symbols.lsp.Module .. " (module)",
  Property = symbols.lsp.Property .. " (prop)",
  Unit = symbols.lsp.Property .. " (unit)",
  Value = symbols.lsp.Property .. " (val)",
  Enum = symbols.lsp.Property .. " (enum)",
  Keyword = symbols.lsp.Property .. " (keyword)",
  Snippet = symbols.lsp.Property .. " (snip)",
  Color = symbols.lsp.Property .. " (color)",
  File = symbols.lsp.Property .. " (file)",
  Reference = symbols.lsp.Property .. " (ref)",
  Folder = symbols.lsp.Property .. " (folder)",
  EnumMember = symbols.lsp.Property .. " (enum member)",
  Constant = symbols.lsp.Property .. " (const)",
  Struct = symbols.lsp.Property .. " (struct)",
  Event = symbols.lsp.Property .. " (event)",
  Operator = symbols.lsp.Property .. " (operator)",
  TypeParameter = symbols.lsp.Property .. " (type param)",
}

local M = {}

M.format = function(entry, vim_item)
  vim_item.kind = kind_icons[vim_item.kind]
  vim_item.menu = ""

  return vim_item
end

return M
