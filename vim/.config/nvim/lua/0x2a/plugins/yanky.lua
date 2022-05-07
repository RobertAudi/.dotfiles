-- Module: yanky
-- Plugin: gbprod/yanky.nvim
-- Description: Improved Yank and Put functionalities for Neovim
-- URL: https://github.com/gbprod/yanky.nvim

local M = {}

M.config = function()
  require("yanky").setup({
    ring = {
      history_length = 2000,
      storage = "shada",
      sync_with_numbered_registers = true,
    },

    picker = {
      select = {
        action = nil, -- nil to use default put action
      },
      telescope = {
        mappings = nil, -- nil to use default mappings
      },
    },

    system_clipboard = {
      sync_with_ring = true,
    },

    highlight = {
      on_put = false,
      on_yank = true,
      timer = 175,
    },

    preserve_cursor_position = {
      enabled = false,
    },
  })
end

return M
