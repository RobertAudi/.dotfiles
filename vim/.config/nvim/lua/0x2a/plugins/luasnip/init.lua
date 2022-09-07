-- Module: 0x2a.plugins.luasnip
-- Plugin: L3MON4D3/LuaSnip
-- Description: Snippet Engine for Neovim written in Lua.
-- URL: https://github.com/L3MON4D3/LuaSnip
-- Requires:
--   - 0x2a.plugins.luasnip.snippets

local M = {}

M.config = function()
  local luasnip = prequire("luasnip")

  if not luasnip then
    return
  end

  local types = require("luasnip.util.types")

  luasnip.config.setup({
    -- dynamic snippet support
    history = true,

    update_events = "TextChanged,TextChangedI",
    region_check_events = "CursorMoved",
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

    if ls.expandable() then
      ls.expand()
    end
  end, { noremap = true, silent = false, desc = "Luasnip: Expand snippet" })

  vim.keymap.set({ "i", "s" }, "<M-l>", function()
    local ls = require("luasnip")

    if ls.jumpable(1) then
      ls.jump(1)
    end
  end, { noremap = true, silent = false, desc = "Luasnip: Jump" })

  vim.keymap.set({ "i", "s" }, "<M-h>", function()
    local ls = require("luasnip")

    if ls.jumpable(-1) then
      ls.jump(-1)
    end
  end, { noremap = true, silent = false, desc = "Luasnip: Jump back" })

  vim.keymap.set({ "i", "s" }, "<M-j>", function()
    local ls = require("luasnip")

    if ls.choice_active() then
      ls.change_choice(-1)
    end
  end, { noremap = true, silent = false, desc = "Luasnip: Cycle through choice nodes" })

  vim.keymap.set({ "i", "s" }, "<M-k>", function()
    local ls = require("luasnip")

    if ls.choice_active() then
      ls.change_choice(1)
    end
  end, { noremap = true, silent = false, desc = "Luasnip: Cycle back through choice nodes" })

  vim.keymap.set({ "i", "s" }, "<M-u>", function()
    local ls = require("luasnip")

    if ls.choice_active() then
      local select_choice = require("luasnip.extras.select_choice")
      select_choice()
    end
  end, { noremap = true, silent = false, desc = "Luasnip: Select choice node" })
end

return M
