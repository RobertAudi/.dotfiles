-- Module: 0x2a.plugins.hydra
-- Plugin: anuvyklack/hydra.nvim
-- Description: Bind a bunch of key bindings together
--              Create custom submodes
-- URL: https://github.com/anuvyklack/hydra.nvim

local M = {}

M.config = function()
  if not prequire("hydra") then
    return
  end

  require("0x2a.plugins.hydra.hydras.telescope-menu").setup()
  require("0x2a.plugins.hydra.hydras.telescope-menu-extended").setup()
  require("0x2a.plugins.hydra.hydras.resize-splits")
  require("0x2a.plugins.hydra.hydras.navigate-splits")
  require("0x2a.plugins.hydra.hydras.lsp")

  vim.api.nvim_create_user_command("Git", function(_)
    require("0x2a.plugins.hydra.hydras.git").activate()
  end, {})
end

return M
