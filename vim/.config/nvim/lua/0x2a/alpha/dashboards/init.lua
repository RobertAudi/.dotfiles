-- Module: 0x2a.alpha.dashboards
-- Requires:
--   - 0x2a.utils.fs
--   - 0x2a.alpha.dashboard
--   - 0x2a.alpha.dashboards.dotfiles
--   - 0x2a.alpha.dashboards.ghq

local fsutils = require("0x2a.utils.fs")

local M = {}

M.get = function()
  if fsutils.in_dotfiles_directory() then
    M.dotfiles = M.dotfiles or require("0x2a.alpha.dashboards.dotfiles")

    return M.dotfiles
  elseif fsutils.in_ghq_directory() then
    M.ghq = M.ghq or require("0x2a.alpha.dashboards.ghq")

    return M.ghq
  else
    M.default = M.default or require("0x2a.alpha.dashboard").build()

    return M.default
  end
end

return M
