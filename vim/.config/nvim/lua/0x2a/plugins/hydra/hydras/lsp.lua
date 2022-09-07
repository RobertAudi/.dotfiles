-- Module: 0x2a.plugins.hydra.hydras.lsp
-- Plugin: anuvyklack/hydra.nvim
-- Description: Bind a bunch of key bindings together
--              Create custom submodes
-- URL: https://github.com/anuvyklack/hydra.nvim

local Hydra = require("hydra")

local hint = [[
 _r_  References
 _i_  Implementations
 _s_  Symbols
 _R_  Rename
 ^                   ^
 ^             _<Esc>_
]]

return Hydra({
  name = "LSP",
  hint = hint,
  config = {
    color = "teal",
    invoke_on_body = true,
    hint = { border = "single" },
  },

  mode = "n",
  body = "<Leader>l",
  heads = {
    { "r", require("telescope.builtin").lsp_references, { desc = "references" } },
    { "i", require("telescope.builtin").lsp_implementations, { desc = "implementations" } },
    { "s", require("0x2a.plugins.telescope.pickers").document_symbols, { desc = "symbols" } },
    { "R", vim.lsp.buf.rename, { desc = "rename" } },
    { "<Esc>", nil, { exit = true } },
  },
})
