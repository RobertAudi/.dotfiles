-- Module: 0x2a.plugins.nvim-tree
-- Plugin: kyazdani42/nvim-tree.lua
-- Description: A file explorer tree for neovim written in lua
-- URL: https://github.com/kyazdani42/nvim-tree.lua
-- Requires:
--   - 0x2a.symbols

local M = {}

M.config = function()
  local symbols = require("0x2a.symbols")

  vim.g.nvim_tree_icons = {
    default = "",
    symlink = symbols.tree.symlink,

    git = {
      unstaged = symbols.git.unstaged,
      staged = symbols.git.staged,
      unmerged = symbols.git.unmerged,
      renamed = symbols.git.renamed,
      untracked = symbols.git.untracked,
      deleted = symbols.git.deleted,
      ignored = symbols.git.ignored,
    },

    folder = {
      arrow_open = symbols.tree.folder.arrow_open,
      arrow_closed = symbols.tree.folder.arrow_closed,
      default = symbols.tree.folder.default,
      open = symbols.tree.folder.open,
      empty = symbols.tree.folder.empty,
      empty_open = symbols.tree.folder.empty_open,
      symlink = symbols.tree.folder.symlink,
      symlink_open = symbols.tree.folder.symlink_open,
    },
  }

  vim.api.nvim_set_var("nvim_tree_show_icons", {
    git = 1,
    folders = 1,
    files = 1,
    folder_arrows = 1,
  })

  vim.api.nvim_set_var("nvim_tree_symlink_arrow", " ➛ ")
  vim.api.nvim_set_var("nvim_tree_respect_buf_cwd", 1)
  vim.api.nvim_set_var("nvim_tree_add_trailing", 1)

  local callbacks = require("0x2a.plugins.nvim-tree.callbacks")

  local mappings = {
    { key = { "<CR>", "<2-LeftMouse>" }, action = "edit" },
    { key = { "l", "o" }, action = "expand_or_edit", action_cb = callbacks.expand },
    { key = { "h", "H", "<BS>" }, action = "collapse", action_cb = callbacks.collapse },

    { key = "A", action = "zoom", action_cb = callbacks.zoom },
    { key = { "O" }, action = "edit_no_picker" },
    { key = { "<C-v>", "s" }, action = "vsplit" },
    { key = { "<C-x>", "i" }, action = "split" },
    { key = { "<C-t>", "t" }, action = "tabnew" },

    { key = "<", action = "prev_sibling" },
    { key = ">", action = "next_sibling" },
    { key = "P", action = "parent_node" },
    { key = "K", action = "first_sibling" },
    { key = "J", action = "last_sibling" },

    { key = "a", action = "create" },
    { key = "d", action = "remove" },
    { key = "D", action = "trash" },
    { key = "r", action = "rename" },
    { key = "<C-r>", action = "full_rename" },
    { key = "x", action = "cut" },
    { key = "c", action = "copy" },
    { key = "p", action = "paste" },
    { key = "y", action = "copy_name" },
    { key = "Y", action = "copy_path" },
    { key = "gy", action = "copy_absolute_path" },

    { key = "[c", action = "prev_git_item" },
    { key = "]c", action = "next_git_item" },

    { key = "W", action = "collapse_all" },
    { key = "S", action = "search_node" },
    { key = "<C-k>", action = "toggle_file_info" },
    { key = "I", action = "toggle_ignored" },
    { key = "R", action = "refresh" },
    { key = "-", action = "close" },
    { key = "go", action = "system_open" },
    { key = ".", action = "run_file_command" },

    { key = "<Space>", action = "preview", action_cb = callbacks.preview },
    { key = "q", action = "quit_or_close_help", action_cb = callbacks.quit_or_close_help },

    { key = "?", action = "toggle_help" },

    -- Disabled mappings
    { key = "<C-e>", action = "" },
    { key = { "<2-RightMouse>", "<C-]>" }, action = "" },
  }

  require("nvim-tree").setup({
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = false,
    ignore_buffer_on_setup = false,
    ignore_ft_on_setup = {},
    auto_reload_on_write = true,
    open_on_tab = false,
    hijack_cursor = true,
    hijack_unnamed_buffer_when_opening = false,
    update_cwd = false,

    diagnostics = {
      enable = false,
    },

    update_focused_file = {
      enable = false,
      update_cwd = false,
      ignore_list = {},
    },

    system_open = {
      cmd = "launch",
      args = {},
    },

    filters = {
      dotfiles = false,
      custom = {
        "^.git$",
        "^.gem$",
        "^cache$",
        "*.zwc",
        "*.zwc.old",
        ".DS_Store",
        "*.log",
        ".yardoc",
        "tags",
        "Gemfile.lock",
        "Gemfile.local.lock",
        "yarn.lock",
        "node_modules",
        "tmp/cache",
        "tmp/pids",
        "tmp/sockets",
        "tmp/letter_opener",
        "tmp/uploads",
        "tmp/store",
        "public/cache",
        "public/uploads",
        "public/store",
        "public/assets",
        "public/packs",
      },
    },

    git = {
      enable = true,
      ignore = false,
      timeout = 500,
    },

    view = {
      width = 30,
      height = 30,
      hide_root_folder = true,
      side = "left",

      mappings = {
        custom_only = true,
        list = mappings,
      },

      number = false,
      relativenumber = false,
    },

    trash = {
      cmd = "trash",
      require_confirm = true,
    },

    actions = {
      change_dir = {
        enable = false,
        global = false,
      },

      open_file = {
        quit_on_open = false,
        resize_window = true,
        window_picker = {
          enable = true,
          chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
          exclude = {
            filetype = { "notify", "vim-plug", "qf", "diff", "ctrlsf", "aerial" },
            buftype = { "nofile", "terminal", "help" },
          },
        },
      },
    },
  })

  vim.keymap.set("n", "-", "<Cmd>NvimTreeToggle<CR>", { silent = true })
  vim.keymap.set("n", "g-", "<Cmd>NvimTreeFocus<CR>", { silent = true })
  vim.keymap.set("n", "gF", "<Cmd>NvimTreeFindFile<CR>", { silent = true })
end

return M
