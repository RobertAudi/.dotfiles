-- Module: 0x2a.plugins.nvim-cmp.sources
-- Plugin: hrsh7th/nvim-cmp
-- Description: A completion plugin for neovim coded in Lua.
-- URL: https://github.com/hrsh7th/nvim-cmp
-- Requires:
--   - 0x2a.utils.table

local table_utils = require("0x2a.utils.table")

local M = {}

M.sources = {
  nvim_lua = { name = "nvim_lua" },
  nvim_lsp = { name = "nvim_lsp" },
  ctags = { name = "ctags" },
  treesitter = { name = "treesitter" },
  plugins = { name = "plugins" },
  luasnip = { name = "luasnip" },
  crates = { name = "crates" },
  path = { name = "path" },
  buffer = {
    name = "buffer",
    keyword_length = 5,
    option = {
      get_bufnrs = function()
        local buffers = vim.api.nvim_list_bufs()
        local buffersToUse = {}
        local bufferIndex = 1

        for i = 1, #buffers, 1 do
          local buf = buffers[i]
          local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))

          if
            not (byte_size > 1024 * 128)
            and (vim.fn.buflisted(buf) == 1 or vim.fn.getbufvar(buf, "&buftype", "ERROR") == "terminal")
          then -- 1 Megabyte max
            buffersToUse[bufferIndex] = buf
            bufferIndex = bufferIndex + 1
          end
        end

        return buffersToUse
      end,
    },
  },
}

M.available_sources = table_utils.keys(M.sources)

M.source = function(name, opts)
  assert(type(name) == "string")
  assert(table_utils.has_key(M.sources, name))

  opts = opts or {}
  opts.name = nil

  return vim.tbl_deep_extend("force", M.sources[name], opts)
end

return M
