-- Module: 0x2a.plugins.trouble.lua
-- Plugin: folke/trouble.nvim
-- Description: 🚦 A pretty diagnostics, references, telescope results,
--                 quickfix and location list to help you solve all the
--                 trouble your code is causing.
-- URL: https://github.com/folke/trouble.nvim
-- Requires:
--   - 0x2a.symbols

local M = {}

M.config = function()
  local symbols = require("0x2a.symbols")

  require("trouble").setup({
    position = "bottom",
    height = 10,
    width = 50,
    icons = false,
    mode = "document_diagnostics",
    fold_open = symbols.fold.open,
    fold_closed = symbols.fold.closed,
    group = true,
    padding = true,

    action_keys = { -- key mappings for actions in the trouble list
      close = "q",
      cancel = "<Esc>",
      refresh = "r",
      jump = { "<CR>", "<Tab>" },
      open_split = { "<C-x>" },
      open_vsplit = { "<C-v>" },
      open_tab = { "<C-t>" },
      jump_close = { "o" },
      toggle_mode = "m",
      toggle_preview = "P",
      hover = "K",
      preview = "p",
      close_folds = { "zM", "zm" },
      open_folds = { "zR", "zr" },
      toggle_fold = { "zA", "za" },
      previous = "k",
      next = "j",
    },

    indent_lines = false,
    auto_open = false,
    auto_close = false,
    auto_preview = true,
    auto_fold = false,
    auto_jump = { "lsp_definitions" },

    signs = {
      -- icons / text used for a diagnostic
      error = symbols.diagnostics.error,
      warning = symbols.diagnostics.warning,
      hint = symbols.diagnostics.hint,
      information = symbols.diagnostics.info,
      other = symbols.diagnostics.success,
    },

    use_diagnostic_signs = false,
  })
end

return M
