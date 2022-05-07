-- Module: 0x2a.plugins.luasnip.snippets.all
-- Requires:
--   - L3MON4D3/LuaSnip

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

ls.add_snippets("all", {
  s("shrug", t("¯\\_(ツ)_/¯")),
})
