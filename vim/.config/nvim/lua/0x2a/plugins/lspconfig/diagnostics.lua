-- Module: 0x2a.plugins.lspconfig.diagnostics
-- Plugin: neovim/nvim-lspconfig
-- Description: Quickstart configurations for the Nvim LSP client
-- URL: https://github.com/neovim/nvim-lspconfig
-- Requires:
--   - 0x2a.symbols
--   - 0x2a.utils

-- Source: https://github.com/akinsho/dotfiles/blob/4dde1e4e80b7ac3207e113f34994afa06a12bb62/.config/nvim/plugin/lsp.lua#L80,107
--- Restricts nvim's diagnostic signs to only the single most severe one per line
--- @see `:help vim.diagnostic`

local symbols = require("0x2a.symbols")
local utils = require("0x2a.utils")

local ns = vim.api.nvim_create_namespace("severe-diagnostics")

--- Get a reference to the original signs handler
local signs_handler = vim.diagnostic.handlers.signs

local M = {}

M.setup_signs_column_symbols = function()
  -- Change diagnostic symbols in the sign column (gutter)
  local signs = {
    Error = symbols.diagnostics.error,
    Warn = symbols.diagnostics.warning,
    Hint = symbols.diagnostics.hint,
    Info = symbols.diagnostics.info,
  }

  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
end

M.config = {
  -- Underline warnings and errors
  underline = {
    severity = {
      min = vim.diagnostic.severity.WARN,
    },
  },

  -- Show gutter sings
  signs = {
    -- With highest priority
    priority = 9999,

    -- Only for warnings and errors
    severity = {
      min = vim.diagnostic.severity.WARN,
    },
  },

  virtual_text = {
    prefix = require("0x2a.symbols").codicon.DEBUG .. " ",

    -- Show virtual text only for errors
    severity = {
      min = vim.diagnostic.severity.ERROR,
    },
  },

  -- Don't update diagnostics when typing
  update_in_insert = false,
}

M.handlers = {
  signs = {
    show = function(_, bufnr, _, opts)
      -- Get all diagnostics from the whole buffer rather than just the
      -- diagnostics passed to the handler
      local diagnostics = vim.diagnostic.get(bufnr)

      -- Find the "worst" diagnostic per line
      local max_severity_per_line = {}

      for _, d in pairs(diagnostics) do
        local m = max_severity_per_line[d.lnum]

        if not m or d.severity < m.severity then
          max_severity_per_line[d.lnum] = d
        end
      end

      -- Pass the filtered diagnostics (with our custom namespace) to
      -- the original handler
      signs_handler.show(ns, bufnr, vim.tbl_values(max_severity_per_line), opts)
    end,

    hide = function(_, bufnr)
      signs_handler.hide(ns, bufnr)
    end,
  },
}

return M
