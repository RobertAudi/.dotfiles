-- Module: 0x2a.plugins.nvim-tree
-- Plugin: kyazdani42/nvim-tree.lua
-- Description: A file explorer tree for neovim written in lua
-- URL: https://github.com/kyazdani42/nvim-tree.lua
-- Requires:
--   - 0x2a.symbols

local M = {}

M.config = function()
  local symbols = require("0x2a.symbols")
  local callbacks = require("0x2a.plugins.nvim-tree.callbacks")

  local mappings = {
    { key = { "<CR>", "<2-LeftMouse>" }, action = "edit" },
    { key = { "l", "o" }, action = "expand_or_edit", action_cb = callbacks.expand },
    { key = { "h", "H", "<BS>" }, action = "collapse", action_cb = callbacks.collapse },

    { key = "A", action = "zoom", action_cb = callbacks.zoom },
    { key = { "O" }, action = "edit_no_picker" },
    { key = { "<C-v>", "v", "s" }, action = "vsplit" },
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

    -- Will automatically open the tree when running setup if
    -- startup buffer is a directory, is empty or is unnamed.
    -- nvim-tree window will be focused.
    open_on_setup = true,

    -- Will ignore the buffer, when deciding to open the tree on setup
    ignore_buffer_on_setup = false,

    -- List of filetypes that will make `open_on_setup` not open.
    ignore_ft_on_setup = {},

    -- Reloads the explorer every time a buffer is written to
    auto_reload_on_write = true,

    -- Creating a file when the cursor is on a closed folder
    -- will set the path to be inside the closed folder
    create_in_closed_folder = true,

    -- Don't open the tree automatically when switching
    -- tabpage or opening a new tabpage
    open_on_tab = false,

    -- Don't force the cursor to stay on the first letter
    -- of the filename when moving in the tree
    hijack_cursor = true,

    -- Don't open in place of the unnamed buffer if it's empty
    hijack_unnamed_buffer_when_opening = false,

    -- Never change the tree root directory
    update_cwd = false,

    -- Change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
    respect_buf_cwd = true,

    -- Automatically reloads the tree on `BufEnter` nvim-tree
    reload_on_bufenter = true,

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

    renderer = {
      -- Appends a trailing slash to folder names
      add_trailing = true,

      group_empty = false,
      highlight_git = false,
      highlight_opened_files = "none",
      root_folder_modifier = ":~",
      indent_markers = {
        enable = false,
        icons = {
          corner = "└ ",
          edge = "│ ",
          none = "  ",
        },
      },

      icons = {
        webdev_colors = false,
        padding = " ",
        git_placement = "before",
        symlink_arrow = " ➛ ",

        show = {
          git = true,
          folder = true,
          file = true,
          folder_arrow = true,
        },

        glyphs = {
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
        },
      },

      -- A list of filenames that gets highlighted with `NvimTreeSpecialFile`
      special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "Gemfile" },
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
            filetype = { "notify", "packer", "vim-plug", "qf", "diff", "ctrlsf", "aerial" },
            buftype = { "nofile", "terminal", "help" },
          },
        },
      },
    },
  })

  vim.keymap.set("n", "-", "<Cmd>NvimTreeToggle<CR>", { noremap = true, silent = true })
  vim.keymap.set("n", "g-", "<Cmd>NvimTreeFocus<CR>", { noremap = true, silent = true })
  vim.keymap.set("n", "gF", "<Cmd>NvimTreeFindFile<CR>", { noremap = true, silent = true })
end

return M
