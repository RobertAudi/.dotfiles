-- Module: 0x2a.alpha.footers

local M = {}

M.neovim_info = function()
  local total_plugins = #vim.tbl_keys(packer_plugins)
  local version = vim.version()
  local nvim_version_info = "  Neovim v" .. version.major .. "." .. version.minor .. "." .. version.patch

  return " " .. total_plugins .. " plugins" .. nvim_version_info
end

M.vim_tip = function()
  return require("0x2a.utils").fortune("vimtips")
end

return M
