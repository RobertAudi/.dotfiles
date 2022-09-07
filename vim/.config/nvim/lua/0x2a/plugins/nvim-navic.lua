-- Module: 0x2a.plugins.nvim-navic
-- Plugin: SmiteshP/nvim-navic
-- Description: Simple winbar/statusline plugin that shows your current code context
-- URL: https://github.com/SmiteshP/nvim-navic
-- Requires:
--   - 0x2a.symbols

local M = {}

M.config = function()
  local ok, navic = pcall(require, "nvim-navic")

  if not ok then
    return
  end

  local symbols = require("0x2a.symbols")

  navic.setup({
    icons = {
      File = symbols.lsp.File .. " ",
      Module = symbols.lsp.Module .. " ",
      Namespace = symbols.lsp.Namespace .. " ",
      Package = symbols.lsp.Package .. " ",
      Class = symbols.lsp.Class .. " ",
      Method = symbols.lsp.Method .. " ",
      Property = symbols.lsp.Property .. " ",
      Field = symbols.lsp.Field .. " ",
      Constructor = symbols.lsp.Constructor .. " ",
      Enum = symbols.lsp.Enum .. " ",
      Interface = symbols.lsp.Interface .. " ",
      Function = symbols.lsp.Function .. " ",
      Variable = symbols.lsp.Variable .. " ",
      Constant = symbols.lsp.Constant .. " ",
      String = symbols.lsp.String .. " ",
      Number = symbols.lsp.Number .. " ",
      Boolean = symbols.lsp.Boolean .. " ",
      Array = symbols.lsp.Array .. " ",
      Object = symbols.lsp.Object .. " ",
      Key = symbols.lsp.Key .. " ",
      Null = symbols.lsp.Null .. " ",
      EnumMember = symbols.lsp.EnumMember .. " ",
      Struct = symbols.lsp.Struct .. " ",
      Event = symbols.lsp.Event .. " ",
      Operator = symbols.lsp.Operator .. " ",
      TypeParameter = symbols.lsp.TypeParameter .. " ",
    },

    highlight = false,
    separator = "  ",
    depth = 0,
    depth_limit_indicator = "...",
  })
end

return M
