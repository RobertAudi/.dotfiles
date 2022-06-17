-- Module: 0x2a.plugins.nvim-cmp
-- Plugin: hrsh7th/nvim-cmp
-- Description: A completion plugin for neovim coded in Lua.
-- URL: https://github.com/hrsh7th/nvim-cmp
-- Requires:
--   - L3MON4D3/LuaSnip
--   - windwp/nvim-autopairs

local M = {}

M.config = function()
  local cmp = require("cmp")
  local autopairs = require("nvim-autopairs.completion.cmp")
  local symbols = require("0x2a.symbols")

  cmp.setup({
    formatting = {
      format = require("0x2a.plugins.nvim-cmp.formatting").format,
    },

    completion = {
      border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
      scrollbar = "║",
    },

    snippet = {
      expand = function(args)
        local luasnip = prequire("luasnip")

        if luasnip then
          luasnip.lsp_expand(args.body)
        end
      end,
    },

    mapping = require("0x2a.plugins.nvim-cmp.mapping"),

    sources = cmp.config.sources({
      { name = "luasnip", priority = 5 },
      { name = "nvim_lsp", priority = 8 },
      { name = "treesitter", priority = 7 },
      { name = "path", priority = 4 },
      { name = "nvim_lua", priority = 5 },
      { name = "buffer", priority = 7, keyword_length = 5 },
      { name = "crates" },
    }),
  })

  cmp.event:on(
    "confirm_done",
    autopairs.on_confirm_done({
      map_char = { tex = "" },
    })
  )
end

return M
