-- Module: neovim-session-manager
-- Plugin: Shatur/neovim-session-manager
-- Description: A simple wrapper around :mksession
-- URL: https://github.com/Shatur/neovim-session-manager

local M = {}

M.config = function()
  local Path = require("plenary.path")

  require("session_manager").setup({
    sessions_dir = Path:new(vim.fn.stdpath("data"), "sessions"),
    autoload_mode = require("session_manager.config").AutoloadMode.Disabled,
    autosave_last_session = false,
  })

  vim.api.nvim_create_user_command("SaveSession", "SessionManager save_current_session", { nargs = 0 })
  vim.api.nvim_create_user_command("LoadSession", "SessionManager load_current_dir_session", { nargs = 0 })
end

return M
