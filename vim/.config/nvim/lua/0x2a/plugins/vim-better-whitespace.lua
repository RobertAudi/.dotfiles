-- Module: 0x2a.plugins.vim-better-whitespace
-- Plugin: ntpeters/vim-better-whitespace
-- Description: Better whitespace highlighting for Vim
-- URL: https://github.com/ntpeters/vim-better-whitespace

local M = {}

M.config = function()
  vim.g.strip_whitespace_on_save = false
  vim.g.better_whitespace_filetypes_blacklist = {
    "NvimTree",
    "Trouble",
    "packer",
    "help",
    "qf",
    "man",
    "ctrlsf",
    "aerial",
    "TelescopePrompt",
    "TelescopeResults",
    "toggleterm",
    "diff",
    "git",
    "gitcommit",
    "gitrebase",
    "gitblame",
  }

  vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    group = vim.api.nvim_create_augroup("RAPluginsBetterWhitespace", { clear = true }),
    pattern = { "*" },
    callback = function()
      if vim.bo.readonly or not vim.bo.modifiable then
        vim.cmd.DisableWhitespace()
      end
    end,
  })
end

return M
