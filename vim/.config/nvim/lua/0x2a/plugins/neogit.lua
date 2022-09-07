-- Module: 0x2a.plugins.neogit
-- Plugin: TimUntersberger/neogit
-- Description: Magit for Neovim
--              Complete text-based user interface to Git
-- URL: https://github.com/TimUntersberger/neogit

local M = {}

M.config = function()
  local ok, _ = pcall(require, "neogit")

  if not ok then
    return
  end

  local neogit = require("neogit")
  local symbols = require("0x2a.symbols")

  neogit.setup({
    disable_signs = false,
    disable_hint = false,
    disable_context_highlighting = false,
    disable_commit_confirmation = false,

    -- Neogit refreshes its internal state after specific events, which can be expensive depending on the repository size.
    -- Disabling `auto_refresh` will make it so you have to manually refresh the status after you open it.
    auto_refresh = false,
    disable_builtin_notifications = false,
    use_magit_keybindings = false,

    -- Change the default way of opening neogit
    kind = "tab",

    -- Change the default way of opening the commit popup
    commit_popup = {
      kind = "split",
    },

    -- Change the default way of opening popups
    popup = {
      kind = "split",
    },

    -- customize displayed signs
    signs = {
      -- { CLOSED, OPENED }
      section = { symbols.fold.closed, symbols.fold.open },
      item = { symbols.fold.closed, symbols.fold.open },
      hunk = { "", "" },
    },

    integrations = {
      diffview = false,
    },

    -- Setting any section to `false` will make the section not render at all
    sections = {
      untracked = { folded = false },
      unstaged = { folded = false },
      staged = { folded = false },
      stashes = { folded = true },
      unpulled = { folded = true },
      unmerged = { folded = false },
      recent = { folded = true },
    },

    mappings = {
      status = {
        -- Stage
        ["a"] = "Stage",
        ["A"] = "StageAll",
        ["s"] = "Stage",
        ["S"] = "StageUnstaged",

        -- Unstage
        ["r"] = "Unstage",
        ["R"] = "UnstageStaged",
        ["u"] = "Unstage",
        ["U"] = "UnstageStaged",

        -- Discard
        ["x"] = "Discard",
        ["X"] = "Discard",

        -- Diffs
        ["<Tab>"] = "Toggle",
        ["<Enter>"] = "Toggle",
        ["d"] = "DiffAtFile",
        ["D"] = "",

        -- Open files
        ["<C-o>"] = "GoToFile",
        ["<C-v>"] = "VSplitOpen",
        ["<C-x>"] = "SplitOpen",
        ["<C-t>"] = "TabOpen",

        -- Popups
        ["p"] = "PullPopup",
        ["P"] = "PushPopup",
        ["c"] = "CommitPopup",
        ["L"] = "LogPopup",
        ["Z"] = "StashPopup",
        ["b"] = "BranchPopup",

        -- Misc
        ["$"] = "CommandHistory",
        ["?"] = "HelpPopup",
        ["<C-r>"] = "RefreshBuffer",
        ["q"] = "Close",

        -- Disable default mappings
        ["1"] = "",
        ["2"] = "",
        ["3"] = "",
        ["4"] = "",
        ["<C-s>"] = "",
      },
    },
  })
end

return M
