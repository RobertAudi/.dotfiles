-- Module: 0x2a.plugins.nvim-gps.lua
-- Plugin: SmiteshP/nvim-gps
-- Description: Simple statusline component that shows what scope you are working inside
-- URL: https://github.com/SmiteshP/nvim-gps
-- Requires:
--   - 0x2a.symbols

local M = {}

M.config = function()
  local symbols = require("0x2a.symbols")

  require("nvim-gps").setup({
    disable_icons = false,

    icons = {
      ["class-name"] = symbols.lsp.Class .. " ",
      ["function-name"] = symbols.lsp.Function .. " ",
      ["method-name"] = symbols.lsp.Method .. " ",
      ["container-name"] = symbols.lsp.Module .. " ",
      ["tag-name"] = symbols.lsp.Tag .. " ",
      ["boolean-name"] = symbols.lsp.Boolean .. " ",
      ["object-name"] = symbols.lsp.Object .. " ",
      ["array-name"] = symbols.lsp.Array .. " ",
      ["null-name"] = symbols.lsp.Null .. " ",
      ["number-name"] = symbols.lsp.Number .. " ",
      ["string-name"] = symbols.lsp.String .. " ",
      ["float-name"] = symbols.lsp.Float .. " ",
      ["integer-name"] = symbols.lsp.Number .. " ",
    },

    languages = {
      ["latex"] = false,
      ["norg"] = false,
      ["toml"] = false,
      ["verilog"] = false,
      ["yang"] = false,

      ["json"] = {
        icons = {
          ["array-name"] = symbols.lsp.Array .. " ",
          ["object-name"] = symbols.lsp.Object .. " ",
          ["null-name"] = symbols.lsp.Null .. " ",
          ["boolean-name"] = symbols.lsp.Boolean .. " ",
          ["number-name"] = symbols.lsp.Number .. " ",
          ["string-name"] = symbols.lsp.String .. " ",
        },
      },

      ["yaml"] = {
        icons = {
          ["mapping-name"] = symbols.lsp.Map .. " ",
          ["sequence-name"] = symbols.lsp.Array .. " ",
          ["null-name"] = symbols.lsp.Null .. " ",
          ["boolean-name"] = symbols.lsp.Boolean .. " ",
          ["integer-name"] = symbols.lsp.Number .. " ",
          ["float-name"] = symbols.lsp.Float .. " ",
          ["string-name"] = symbols.lsp.String .. " ",
        },
      },
    },

    separator = "  ",
    depth = 0,
    depth_limit_indicator = "...",
  })
end

return M
