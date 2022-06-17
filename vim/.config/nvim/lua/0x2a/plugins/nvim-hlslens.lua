-- Module: 0x2a.plugins.nvim-hlslens
-- Plugin: kevinhwang91/nvim-hlslens
-- Description: Hlsearch Lens for Neovim
-- URL: https://github.com/kevinhwang91/nvim-hlslens
-- Requires:
--   - haya14busa/vim-asterisk

local M = {}

M.config = function()
  require("hlslens").setup({
    calm_down = true,
    nearest_only = true,
    nearest_float_when = "never",
  })

  vim.keymap.set(
    "n",
    "n",
    [[<Cmd>execute("normal! " . v:count1 . "n")<CR><Cmd>lua require("hlslens").start()<CR>]],
    { noremap = true, silent = true }
  )

  vim.keymap.set(
    "n",
    "N",
    [[<Cmd>execute("normal! " . v:count1 . "N")<CR><Cmd>lua require("hlslens").start()<CR>]],
    { noremap = true, silent = true }
  )

  vim.keymap.set(
    { "n", "x" },
    "*",
    [[<Plug>(asterisk-z*)<Cmd>lua require("hlslens").start()<CR>]],
    { noremap = true, silent = true }
  )

  vim.keymap.set(
    { "n", "x" },
    "#",
    [[<Plug>(asterisk-z#)<Cmd>lua require("hlslens").start()<CR>]],
    { noremap = true, silent = true }
  )

  vim.keymap.set(
    { "n", "x" },
    "g*",
    [[<Plug>(asterisk-gz*)<Cmd>lua require("hlslens").start()<CR>]],
    { noremap = true, silent = true }
  )

  vim.keymap.set(
    { "n", "x" },
    "g#",
    [[<Plug>(asterisk-gz#)<Cmd>lua require("hlslens").start()<CR>]],
    { noremap = true, silent = true }
  )
end

return M
