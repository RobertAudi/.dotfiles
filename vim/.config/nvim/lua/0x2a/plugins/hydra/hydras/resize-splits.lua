-- Module: 0x2a.plugins.hydra.hydras.resize-splits
-- Plugin: anuvyklack/hydra.nvim
-- Description: Bind a bunch of key bindings together
--              Create custom submodes
-- URL: https://github.com/anuvyklack/hydra.nvim
-- Requires:
--   - 0x2a.symbols
--   - 0x2a.plugins.hydra.hydras.navigate-splits

local Hydra = require("hydra")
local arrows = require("0x2a.symbols").arrows

return Hydra({
  name = "Resize splits",
  config = {
    hint = {
      border = "single",
    },
  },
  mode = "n",
  body = "<C-w>",
  heads = {
    -- Size
    { "+", "<C-w>+" },
    { "<Up>", "<C-w>+", { desc = arrows.up } },
    { "-", "<C-w>-" },
    { "<Down>", "<C-w>-", { desc = arrows.down } },
    { ">", "2<C-w>>" },
    { "<Left>", "2<C-w><", { desc = arrows.left } },
    { "<", "2<C-w><" },
    { "<Right>", "2<C-w>>", { desc = arrows.right } },
    { "", "<Cmd>GoldenViewResize<CR>", { desc = arrows.right } },

    {
      "<Tab>",
      function()
        require("0x2a.plugins.hydra.hydras.navigate-splits"):activate()
      end,
      { exit = true, nowait = true, desc = "Navigate splits" },
    },

    --
    { "<Esc>", nil, { exit = true } },
  },
})
