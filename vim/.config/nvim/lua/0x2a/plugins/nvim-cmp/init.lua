-- Module: 0x2a.plugins.nvim-cmp
-- Plugin: hrsh7th/nvim-cmp
-- Description: A completion plugin for neovim coded in Lua.
-- URL: https://github.com/hrsh7th/nvim-cmp
-- Requires:
--   - 0x2a.symbols
--   - L3MON4D3/LuaSnip
--   - windwp/nvim-autopairs

local M = {}

M.config = function()
  local cmp = prequire("cmp")

  if not cmp then
    return
  end

  local symbols = require("0x2a.symbols")
  local sources = require("0x2a.plugins.nvim-cmp.sources")

  cmp.setup({
    preselect = cmp.PreselectMode.None,

    formatting = {
      format = require("0x2a.plugins.nvim-cmp.formatting").format,
    },

    completion = {
      border = {
        symbols.corners.top_left,
        symbols.separators.horizontal,
        symbols.corners.top_right,
        symbols.separators.vertical,
        symbols.corners.bottom_right,
        symbols.separators.horizontal,
        symbols.corners.bottom_left,
        symbols.separators.vertical,
      },

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
      sources.source("nvim_lsp", { priority = 100, group_index = 1 }),
      sources.source("treesitter", { priority = 95, group_index = 1 }),
      sources.source("ctags", { priority = 95, group_index = 1 }),
      sources.source("luasnip", { priority = 90, group_index = 2 }),
      sources.source("buffer", { priority = 80, autocomplete = false, group_index = 3 }),
      sources.source("path", { priority = 70, group_index = 3 }),
    }),
  })

  cmp.setup.filetype("lua", {
    sources = cmp.config.sources({
      sources.source("nvim_lsp", { priority = 100, group_index = 1 }),
      sources.source("nvim_lua", { priority = 100, group_index = 1 }),
      sources.source("treesitter", { priority = 95, group_index = 1 }),
      sources.source("luasnip", { priority = 90, group_index = 2 }),
      sources.source("buffer", { priority = 80, autocomplete = false, group_index = 3 }),
      sources.source("path", { priority = 70, group_index = 3 }),
      sources.source("plugins", { priority = 60, group_index = 3 }),
    }),
  })

  cmp.setup.filetype("ruby", {
    sources = cmp.config.sources({
      sources.source("nvim_lsp", { priority = 100, group_index = 1 }),
      sources.source("treesitter", { priority = 95, group_index = 1 }),
      sources.source("ctags", { priority = 95, group_index = 1 }),
      sources.source("luasnip", { priority = 90, group_index = 2 }),
      sources.source("buffer", { priority = 80, autocomplete = false, group_index = 3 }),
      sources.source("path", { priority = 70, group_index = 3 }),
    }),
  })

  cmp.setup.filetype("toml", {
    sources = cmp.config.sources({
      sources.source("nvim_lsp", { priority = 100, group_index = 1 }),
      sources.source("treesitter", { priority = 100, group_index = 1 }),
      sources.source("ctags", { priority = 95, group_index = 1 }),
      sources.source("luasnip", { priority = 90, group_index = 2 }),
      sources.source("buffer", { priority = 80, autocomplete = false, group_index = 3 }),
      sources.source("path", { priority = 70, group_index = 3 }),
      sources.source("crates", { priority = 60, group_index = 3 }),
    }),
  })

  local autopairs = prequire("nvim-autopairs.completion.cmp")

  if autopairs then
    cmp.event:on(
      "confirm_done",
      autopairs.on_confirm_done({
        map_char = { tex = "" },
      })
    )
  end
end

return M
