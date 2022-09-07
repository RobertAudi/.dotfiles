-- Module: 0x2a.plugins.vim-auto-cursorline
-- Plugin: delphinus/vim-auto-cursorline
-- Description: Show / hide cursorline automatically
-- URL: https://github.com/delphinus/vim-auto-cursorline

local M = {}

M.config = function()
  vim.g.auto_cursorline_wait_ms = 1200

  vim.api.nvim_create_autocmd({ "FileType" }, {
    group = vim.api.nvim_create_augroup("RAPluginsVimAutoCursoline", { clear = true }),
    pattern = { "alpha", "aerial", "TelescopePrompt", "TelescopeResults", "gitblame", "git", "ctrlsf", "help" },
    callback = function()
      vim.b.auto_cursorline_disabled = true
    end,
  })
end

return M
