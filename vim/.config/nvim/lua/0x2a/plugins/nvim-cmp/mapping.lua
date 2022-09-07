-- Module: 0x2a.plugins.nvim-cmp.mapping
-- Plugin: hrsh7th/nvim-cmp
-- Description: A completion plugin for neovim coded in Lua.
-- URL: https://github.com/hrsh7th/nvim-cmp

local cmp = require("cmp")

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local mapping = {
  ["<Up>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
  ["<Down>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
  ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
  ["<C-y>"] = cmp.config.disable,
  ["<C-e>"] = cmp.config.disable,
  ["<Enter>"] = cmp.mapping.confirm({ select = false }),

  ["<Tab>"] = cmp.mapping(function(fallback)
    local luasnip = require("luasnip")

    if cmp.visible() then
      cmp.select_next_item()
    elseif luasnip.expandable() then
      luasnip.expand()
    elseif luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    elseif has_words_before() then
      cmp.complete()
    else
      fallback()
    end
  end, { "i", "s" }),

  ["<S-Tab>"] = cmp.mapping(function(fallback)
    local luasnip = require("luasnip")

    if cmp.visible() then
      cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end, { "i", "s" }),
}

mapping["<C-n>"] = mapping["<Tab>"]
mapping["<C-p>"] = mapping["<S-Tab>"]

return mapping
