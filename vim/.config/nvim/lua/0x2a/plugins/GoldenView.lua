-- Module: 0x2a.plugins.GoldenView
-- Plugin: RobertAudi/GoldenView.vim
-- Description: Always have a nice view for vim split windows!
-- URL: https://github.com/RobertAudi/GoldenView.vim

local M = {}

M.config = function()
  -- NOTE: Disabled because it fucks with floating windows
  vim.g.goldenview__enable_at_startup = false

  vim.g.goldenview__ignore_urule = {
    bufname = {},

    filetype = {
      "NvimTree",
      "Trouble",
      "aerial",
      "TelescopePrompt",
      "TelescopeResults",
      "toggleterm",
      "ctrlsf",
      "packer",
      "diff",
      "help",
      "qf",
      "man",
      "git",
      "gitblame",
      "gitcommit",
      "gitrebase",
    },

    buftype = {
      "help",
      "nofile",
      "prompt",
      "popup",
      "terminal",
      "acwrite",
      "qf",
    },
  }

  vim.keymap.set("n", "<C-w>~", "<Cmd>GoldenViewResize<CR>", { noremap = true })
end

return M
