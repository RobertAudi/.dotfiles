-- Module: 0x2a.plugins.luasnip
-- Plugin: L3MON4D3/LuaSnip
-- Description: Snippet Engine for Neovim written in Lua.
-- URL: https://github.com/L3MON4D3/LuaSnip
-- Requires:
--   - 0x2a.plugins.luasnip.snippets

local M = {}

M.config = function()
  require("0x2a.plugins.luasnip.snippets")

  vim.keymap.set("i", "<C-j>", "<Plug>luasnip-expand-or-jump", {})
end

return M
