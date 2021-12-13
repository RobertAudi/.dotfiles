-- Plugin: nvim-tree.lua
-- Description: A file explorer tree for neovim written in lua
-- URL: https://github.com/kyazdani42/nvim-tree.lua

vim.api.nvim_set_var("nvim_tree_icons", {
    default = "",
    symlink = "",
    git = {
      unstaged  = "○",
      staged    = "●",
      unmerged  = "‼",
      renamed   = "➜",
      untracked = "⁇",
      deleted   = "✗",
      ignored   = ""
    },
    folder = {
      arrow_open   = "▾",
      arrow_closed = "▸",
      default      = "",
      open         = "",
      empty        = "",
      empty_open   = "",
      symlink      = "",
      symlink_open = "",
    }
  })

vim.api.nvim_set_var("nvim_tree_show_icons", {
    git = 1,
    folders = 1,
    files = 1,
    folder_arrows = 1,
  })

vim.api.nvim_set_var("nvim_tree_symlink_arrow", " ➛ ")
vim.api.nvim_set_var("nvim_tree_respect_buf_cwd", 1)
vim.api.nvim_set_var("nvim_tree_add_trailing", 1)

local tree_cb = require("0x2a.nvim-tree").callback

require("nvim-tree").setup({
    disable_netrw       = true,
    hijack_netrw        = true,
    open_on_setup       = false,
    ignore_ft_on_setup  = {},
    auto_close          = false,
    open_on_tab         = true,
    hijack_cursor       = false,
    update_cwd          = false,
    update_to_buf_dir   = {
      enable = true,
      auto_open = true,
    },
    diagnostics = {
      enable = false,
    },
    update_focused_file = {
      enable      = false,
      update_cwd  = false,
      ignore_list = {}
    },
    system_open = {
      cmd  = "launch",
      args = {}
    },
    filters = {
      dotfiles = false,
      ignored = false,
      custom = {
        ".git", ".gem",
        "cache", "*.zwc", "*.zwc.old", ".DS_Store", "*.log",
        ".yardoc", "tags",
        "Gemfile.lock", "Gemfile.local.lock", "yarn.lock", "node_modules",
        "tmp/cache", "tmp/pids", "tmp/sockets", "tmp/letter_opener", "tmp/uploads", "tmp/store",
        "public/cache", "public/uploads", "public/store", "public/assets", "public/packs",
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
      auto_resize = true,
      mappings = {
        custom_only = true,
        list = {
          { key = {"<CR>", "l", "o", "<2-LeftMouse>"}, cb = tree_cb("expand") },
          { key = "h",                            cb = tree_cb("collapse") },
          { key = "A",                            cb = tree_cb("zoom") },
          { key = {"<C-v>", "s"},                 cb = tree_cb("vsplit") },
          { key = {"<C-x>", "i"},                 cb = tree_cb("split") },
          { key = {"<C-t>", "t"},                 cb = tree_cb("tabnew") },
          { key = "<BS>",                         cb = tree_cb("close_node") },
          { key = "P",                            cb = tree_cb("parent_node") },
          { key = "I",                            cb = tree_cb("toggle_ignored") },
          { key = "R",                            cb = tree_cb("refresh") },
          { key = {"a", "ma"},                    cb = tree_cb("create") },
          { key = "d",                            cb = tree_cb("remove") },
          { key = "D",                            cb = tree_cb("trash") },
          { key = "r",                            cb = tree_cb("rename") },
          { key = "<C-r>",                        cb = tree_cb("full_rename") },
          { key = "x",                            cb = tree_cb("cut") },
          { key = "c",                            cb = tree_cb("copy") },
          { key = "p",                            cb = tree_cb("paste") },
          { key = "[c",                           cb = tree_cb("prev_git_item") },
          { key = "]c",                           cb = tree_cb("next_git_item") },
          { key = "y",                            cb = tree_cb("copy_name") },
          { key = "Y",                            cb = tree_cb("copy_path") },
          { key = "gy",                           cb = tree_cb("copy_absolute_path") },
          { key = "q",                            cb = tree_cb("quit_or_close_help") },
          { key = "?",                            cb = tree_cb("toggle_help") },
        }
      },
      number = false,
      relativenumber = false
    },
    trash = {
      cmd = "trash",
      require_confirm = true
    }
  })

vim.api.nvim_set_keymap('n', '-', '<Cmd>NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'g-', '<Cmd>NvimTreeFocus<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gF', '<Cmd>NvimTreeFindFile<CR>', { noremap = true, silent = true })
