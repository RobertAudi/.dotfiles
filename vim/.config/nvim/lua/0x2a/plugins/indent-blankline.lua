-- Module: 0x2a.plugins.indent-blankline
-- Plugin: lukas-reineke/indent-blankline.nvim
-- Description: Indent guides for Neovim
-- URL: https://github.com/lukas-reineke/indent-blankline.nvim

local M = {}

M.config = function()
  vim.g.indent_blankline_char = "│"

  vim.g.indent_blankline_filetype_exclude = {
    "NvimTree",
    "Trouble",
    "aerial",
    "TelescopePrompt",
    "TelescopeResults",
    "toggleterm",
    "gitblame",
    "git",
    "ctrlsf",
  }

  vim.g.indent_blankline_bufname_exclude = {}
  vim.g.indent_blankline_buftype_exclude = { "terminal" }
end

return M
