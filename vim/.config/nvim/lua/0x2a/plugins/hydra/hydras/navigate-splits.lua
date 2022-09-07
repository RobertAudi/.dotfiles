-- Module: 0x2a.plugins.hydra.hydras.navigate-splits
-- Plugin: anuvyklack/hydra.nvim
-- Description: Bind a bunch of key bindings together
--              Create custom submodes
-- URL: https://github.com/anuvyklack/hydra.nvim
-- Requires:
--   - 0x2a.symbols
--   - 0x2a.plugins.hydra.hydras.resize-splits

local Hydra = require("hydra")
local arrows = require("0x2a.symbols").arrows

return Hydra({
  name = "Navigate splits",
  config = {
    hint = {
      border = "single",
    },
  },
  mode = "n",
  body = "<C-w>",
  heads = {
    -- Size
    { "k", "<C-w>k", { desc = arrows.up } },
    { "j", "<C-w>j", { desc = arrows.down } },
    { "h", "<C-w>h", { desc = arrows.left } },
    { "l", "<C-w>l", { desc = arrows.right } },

    {
      "<Tab>",
      function()
        require("0x2a.plugins.hydra.hydras.resize-splits"):activate()
      end,
      { exit = true, nowait = true, desc = "Resize splits" },
    },
    --
    { "<Esc>", nil, { exit = true } },
  },
})
