-- Module: 0x2a.plugins.hydra.hydras.telescope-menu-extended
-- Plugin: anuvyklack/hydra.nvim
-- Description: Bind a bunch of key bindings together
--              Create custom submodes
-- URL: https://github.com/anuvyklack/hydra.nvim
-- Requires:
--   - 0x2a.utils.fs
--   - 0x2a.plugins.hydra.utils
--   - TimUntersberger/neogit
--   - lewis6991/gitsigns.nvim

local Hydra = require("hydra")
local gitsigns = require("gitsigns")
local fsutils = require("0x2a.utils.fs")
local string_utils = require("0x2a.utils.string")

local M = {}

M.hint = string_utils.trim_lines([[
  _J_: next hunk   _s_: stage hunk        _d_: show deleted   _b_: blame line
  _K_: prev hunk   _u_: undo last stage   _p_: preview hunk   _B_: blame show full
  ^ ^              _S_: stage buffer      ^ ^                 _/_: show base file
  ^
  ^ ^              _<Enter>_: Neogit              _<Esc>_: exit
]])

M.heads = {
  {
    "J",

    function()
      if vim.wo.diff then
        return "]c"
      end

      vim.schedule(function()
        gitsigns.next_hunk()
      end)

      return "<Ignore>"
    end,

    { expr = true, desc = "next hunk" },
  },

  {
    "K",

    function()
      if vim.wo.diff then
        return "[c"
      end

      vim.schedule(function()
        gitsigns.prev_hunk()
      end)

      return "<Ignore>"
    end,

    { expr = true, desc = "prev hunk" },
  },

  { "s", gitsigns.stage_hunk, { desc = "stage hunk" } },
  { "u", gitsigns.undo_stage_hunk, { desc = "undo last stage" } },
  { "S", gitsigns.stage_buffer, { desc = "stage buffer" } },
  { "p", gitsigns.preview_hunk, { desc = "preview hunk" } },
  { "d", gitsigns.toggle_deleted, { nowait = true, desc = "toggle deleted" } },
  { "b", gitsigns.blame_line, { desc = "blame" } },

  {
    "B",

    function()
      gitsigns.blame_line({ full = true })
    end,

    { desc = "blame show full" },
  },

  { "/", gitsigns.show, { exit = true, desc = "show base file" } },
  { "<Enter>", require("neogit").open, { exit = true, desc = "Neogit" } },
  { "<Esc>", nil, { exit = true, nowait = true, desc = "exit" } },
}

M.activate = function()
  if vim.bo.buftype ~= "" or not fsutils.file_exists(fsutils.current_file().path) then
    require("neogit").open()
    return
  end

  Hydra({
    name = "Git",
    hint = M.hint,
    config = {
      buffer = vim.fn.bufnr(),
      color = "pink",
      invoke_on_body = true,
      hint = {
        border = "single",
      },

      on_enter = function()
        vim.cmd.mkview()
        vim.cmd("silent! %foldopen!")

        vim.bo.modifiable = false

        gitsigns.toggle_linehl(true)
      end,

      on_exit = function()
        local cursor_pos = vim.api.nvim_win_get_cursor(0)

        vim.cmd.loadview()
        vim.api.nvim_win_set_cursor(0, cursor_pos)
        vim.cmd.normal("zv")

        gitsigns.toggle_linehl(false)
      end,
    },

    mode = { "n", "x" },
    heads = M.heads,
  }):activate()
end

return M
