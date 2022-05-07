-- Module: 0x2a.plugins.packer
-- Plugin: wbthomason/packer.nvim
-- Description: A use-package inspired plugin manager for Neovim.
-- URL: https://github.com/wbthomason/packer.nvim
-- Requires:
--   - 0x2a.notifications

local M = {}

M.config = function()
  local notifications = require("0x2a.notifications")
  local packer_autocmd_group = vim.api.nvim_create_augroup("RAPacker", { clear = true })

  vim.api.nvim_create_autocmd({ "User" }, {
    group = packer_autocmd_group,
    pattern = { "PackerComplete" },
    callback = function()
      require("0x2a.notifications").info(
        "Packer install, update, clean, or sync operation complete.",
        { title = "Packer" }
      )
    end,
  })

  vim.api.nvim_create_autocmd({ "User" }, {
    group = packer_autocmd_group,
    pattern = { "PackerCompileDone" },
    callback = function()
      require("0x2a.notifications").info("PackerCompile done.", { title = "Packer" })
    end,
  })
end

return M
