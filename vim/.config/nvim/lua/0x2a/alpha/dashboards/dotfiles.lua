-- Module: 0x2a.alpha.dashboards.dotfiles
-- Requires:
--   - 0x2a.utils.string
--   - 0x2a.alpha.buttons
--   - 0x2a.alpha.footers
--   - 0x2a.alpha.dashboard

local string_utils = require("0x2a.utils.string")
local headers = require("0x2a.utils.headers")
local buttons = require("0x2a.alpha.buttons")

return require("0x2a.alpha.dashboard").build({
  header = string_utils.split(headers.h1("dotfiles"), "\n"),
  buttons = {
    buttons.recent_files,
    buttons.sanbox,
    buttons.file_tree,
    buttons.restore_session,
    buttons.neogit,
    buttons.reload_config,
    buttons.update_plugins,
    buttons.close_or_quit,
  },

  footer = require("0x2a.alpha.footers").neovim_info,
})
