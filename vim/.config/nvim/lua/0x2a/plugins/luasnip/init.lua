-- Module: 0x2a.plugins.luasnip
-- Plugin: L3MON4D3/LuaSnip
-- Description: Snippet Engine for Neovim written in Lua.
-- URL: https://github.com/L3MON4D3/LuaSnip
-- Requires:
--   - 0x2a.plugins.luasnip.snippets

local M = {}

M.config = function()
  local ls = require("luasnip")
  local types = require("luasnip.util.types")

  ls.config.setup({
    -- dynamic snippet support
    history = true,

    update_events = "TextChanged,TextChangedI",
    region_check_events = "InsertEnter",
    delete_check_events = "InsertLeave",

    -- customise virtual text
    ext_opts = {
      [types.choiceNode] = {
        active = {
          virt_text = { { "", "DiagnosticSignWarn" } },
        },
      },

      [types.insertNode] = {
        active = {
          virt_text = { { "⟵", "DiagnosticSignWarn" } },
        },
      },
    },
  })

  require("0x2a.plugins.luasnip.snippets")

  vim.keymap.set({ "i", "s" }, "<C-l>", function()
    local ls = require("luasnip")

    if ls.expand_or_jumpable() then
      ls.expand_or_jump()
    end
  end, { noremap = true, silent = false })

  vim.keymap.set({ "i", "s" }, "<C-h>", function()
    local ls = require("luasnip")

    if ls.jumpable(-1) then
      ls.jump(-1)
    end
  end, { noremap = true, silent = false })

  vim.keymap.set("i", "<C-j>", function()
    local ls = require("luasnip")

    if ls.choice_active() then
      ls.change_choice(-1)
    end
  end, { noremap = true, silent = false })

  vim.keymap.set("i", "<C-k>", function()
    local ls = require("luasnip")

    if ls.choice_active() then
      ls.change_choice(1)
    end
  end, { noremap = true, silent = false })
end

return M
