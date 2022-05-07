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
  local luasnip = require("luasnip")
  local autopairs = require("nvim-autopairs.completion.cmp")
  local symbols = require("0x2a.symbols")

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  cmp.setup({
    formatting = {
      format = require("0x2a.plugins.nvim-cmp.formatting").format,
    },

    completion = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      scrollbar = "║",
    },

    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },

    mapping = {
      ["<Up>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
      ["<Down>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      ["<C-y>"] = cmp.config.disable,
      ["<C-e>"] = cmp.config.disable,
      ["<CR>"] = cmp.mapping.confirm({ select = true }),

      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    },

    sources = cmp.config.sources({
      { name = "luasnip" },
      { name = "nvim_lsp" },
      { name = "path" },
      { name = "nvim_lua" },
      { name = "buffer", keyword_length = 5 },
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
