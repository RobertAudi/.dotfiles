-- Requires:
--   - 0x2a.utils.table
--   -- 0x2a.utils.buffer

local filetypes = { "css", "html", "json", "lua", "markdown", "rspec", "ruby", "rust", "scss", "toml", "vim" }

vim.api.nvim_create_user_command("Format", function()
  if require("0x2a.utils.table").has_value(filetypes, vim.bo.filetype) then
    -- vim.lsp.buf.formatting({}) -- deprecated in HEAD. Use with 0.7
    vim.lsp.buf.format({ async = true })
  else
    require("0x2a.utils.buffer").reindent()
  end
end, { range = true, desc = "Format the current buffer using LSP or NeoFormat" })

vim.keymap.set("n", "<Leader>=", "<Cmd>Format<CR>", { noremap = true, silent = true })
