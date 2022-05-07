-- Module: 0x2a.plugins.gitsigns
-- Plugin: lewis6991/gitsigns.nvim
-- Description: Git integration for buffers
-- URL: https://github.com/lewis6991/gitsigns.nvim
-- Requires:
--   - 0x2a.symbols

local M = {}

M.config = function()
  local symbols = require("0x2a.symbols")

  require("gitsigns").setup({
    signs = {
      add = {
        hl = "GitSignsAdd",
        text = symbols.gitsigns.add,
        numhl = "GitSignsAddNr",
        linehl = "GitSignsAddLn"
      },

      change = {
        hl = "GitSignsChange",
        text = symbols.gitsigns.change,
        numhl = "GitSignsChangeNr",
        linehl = "GitSignsChangeLn",
      },

      delete = {
        hl = "GitSignsDelete",
        text = symbols.gitsigns.delete,
        numhl = "GitSignsDeleteNr",
        linehl = "GitSignsDeleteLn",
      },

      topdelete = {
        hl = "GitSignsDelete",
        text = symbols.gitsigns.topdelete,
        numhl = "GitSignsDeleteNr",
        linehl = "GitSignsDeleteLn",
      },

      changedelete = {
        hl = "GitSignsChange",
        text = symbols.gitsigns.changedelete,
        numhl = "GitSignsChangeNr",
        linehl = "GitSignsChangeLn",
      },
    },

    signcolumn = true,
    numhl = false,
    linehl = false,
    word_diff = false,

    watch_gitdir = {
      interval = 1000,
      follow_files = true,
    },

    attach_to_untracked = true,
    current_line_blame = false,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol",
      delay = 1000,
      ignore_whitespace = false,
    },

    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil,
    max_file_length = 40000,

    preview_config = {
      border = "single",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },

    yadm = { enable = false },

    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      map("n", "]c", function()
        if vim.wo.diff then
          return "]c"
        else
          vim.schedule(function()
            gs.next_hunk()
          end)

          return "<Ignore>"
        end
      end, { expr = true })

      map("n", "[c", function()
        if vim.wo.diff then
          return "[c"
        else
          vim.schedule(function()
            gs.prev_hunk()
          end)

          return "<Ignore>"
        end
      end, { expr = true })
    end,
  })
end

return M
