-- Module: 0x2a.plugins.nvim-tree
-- Plugin: kyazdani42/nvim-tree.lua
-- Description: A file explorer tree for neovim written in lua
-- URL: https://github.com/kyazdani42/nvim-tree.lua
-- Requires:
--   - 0x2a.symbols
--   - 0x2a.plugins.nvim-tree.keymaps

local M = {}

M.config = function()
  local tree = prequire("nvim-tree")

  if not tree then
    return
  end

  local symbols = require("0x2a.symbols")

  tree.setup({
    -- Reloads the explorer every time a buffer is written to
    auto_reload_on_write = true,

    -- Creating a file when the cursor is on a closed folder
    -- will set the path to be inside the closed folder
    create_in_closed_folder = true,

    -- Completely disable netrw
    disable_netrw = true,

    -- Don't force the cursor to stay on the first letter
    -- of the filename when moving in the tree
    hijack_cursor = true,

    -- Hijack netrw windows (overriden if |disable_netrw| is `true`)
    hijack_netrw = true,

    -- Don't open in place of the unnamed buffer if it's empty
    hijack_unnamed_buffer_when_opening = false,

    -- Will ignore the buffer, when deciding to open the tree on setup
    ignore_buffer_on_setup = false,

    -- Will automatically open the tree when running setup if
    -- startup buffer is a directory, is empty or is unnamed.
    -- nvim-tree window will be focused.
    open_on_setup = true,

    -- Will automatically open the tree when running setup if startup buffer is a file.
    -- File window will be focused.
    -- File will be found if update_focused_file is enabled.
    open_on_setup_file = false,

    -- Don't open the tree automatically when switching
    -- tabpage or opening a new tabpage
    open_on_tab = false,

    -- Changes how files within the same directory are sorted.
    -- Can be one of 'name', 'case_sensitive', 'modification_time' or 'extension'.
    sort_by = "name",

    -- Changes the tree root directory on `DirChanged` and refreshes the tree.
    sync_root_with_cwd = false,

    -- Automatically reloads the tree on `BufEnter` nvim-tree
    reload_on_bufenter = true,

    -- Change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
    respect_buf_cwd = true,

    -- Remove default keymaps
    remove_keymaps = true,

    on_attach = function(bufnr)
      -- Set tree explorer keymaps
      require("0x2a.plugins.nvim-tree.keymaps").set_keymaps(bufnr)
    end,

    -- Window / buffer setup.
    view = { -- {{{
      -- Resize the window on each draw based on the longest line.
      adaptive_size = false,

      -- When entering nvim-tree, reposition the view so that the current node is initially centralized
      centralize_selection = false,

      -- Width of the window, can be a `%` string, a number representing columns or a function.
      width = 30,

      -- Height of the window, can be `%` string or a number representing rows or a function.
      height = 30,

      -- Hide the path of the current working directory on top of the tree.
      hide_root_folder = true,

      -- Side of the tree, can be `"left"`, `"right"`, `"bottom"`, `"top"`.
      side = "left",

      -- Preserves window proportions when opening a file.
      -- If `false`, the height and width of windows other than nvim-tree will be equalized.
      preserve_window_proportions = false,

      -- Print the line number in front of each line.
      number = false,

      -- Show the line number relative to the line with the cursor in front of each line.
      -- If the option `view.number` is also `true`, the number on the cursor line
      -- will be the line number instead of `0`.
      relativenumber = false,

      -- Show diagnostic sign column. Value can be `"yes"`, `"auto"`, `"no"`.
      signcolumn = "yes",
    }, -- }}}

    -- UI rendering setup
    renderer = { -- {{{
      -- Appends a trailing slash to folder names
      add_trailing = true,

      -- Compact folders that only contain a single folder into one node in the file tree.
      group_empty = false,

      -- Enable file highlight for git attributes using `NvimTreeGit*` highlight groups.
      -- This can be used with or without the icons.
      highlight_git = false,

      -- Display node whose name length is wider than the width of nvim-tree window in floating window.
      full_name = false,

      -- Highlight icons and/or names for opened files.
      -- Value can be `"none"`, `"icon"`, `"name"` or `"all"`.
      highlight_opened_files = "none",

      -- In what format to show root folder. See `:help filename-modifiers` for available options.
      root_folder_modifier = ":~",

      -- Configuration options for tree indent markers.
      indent_markers = {
        -- Display indent markers when folders are open
        enable = false,

        -- Icons shown before the file/directory.
        icons = symbols.tree.indent_markers,
      },

      -- Configuration options for icons.
      icons = {
        -- Use the webdev icon colors, otherwise `NvimTreeFileIcon`.
        webdev_colors = false,

        -- Place where the git icons will be rendered.
        -- Can be `"after"` or `"before"` filename (after the file/folders icons)
        -- or `"signcolumn"` (requires |nvim-tree.view.signcolumn| enabled).
        -- Note that the diagnostic signs will take precedence over the git signs.
        git_placement = "before",

        -- Inserted between icon and filename.
        padding = " ",

        -- Used as a separator between symlinks' source and target.
        symlink_arrow = symbols.tree.symlink_arrow,

        -- Configuration options for showing icon types.
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },

        -- Configuration options for icon glyphs.
        glyphs = {
          default = "",
          symlink = symbols.tree.symlink,
          bookmark = "",

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

          git = {
            unstaged = symbols.git.unstaged,
            staged = symbols.git.staged,
            unmerged = symbols.git.unmerged,
            renamed = symbols.git.renamed,
            untracked = symbols.git.untracked,
            deleted = symbols.git.deleted,
            ignored = symbols.git.ignored,
          },
        },
      },

      -- A list of filenames that gets highlighted with `NvimTreeSpecialFile`
      special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "Gemfile" },

      -- Whether to show the destination of the symlink.
      symlink_destination = true,
    }, -- }}}

    -- hijacks new directory buffers when they are opened
    hijack_directories = { enable = false },

    -- Update the focused file on `BufEnter`, un-collapses the folders recursively
    -- until it finds the file.
    update_focused_file = { enable = false },

    -- List of filetypes that will make `open_on_setup` not open.
    ignore_ft_on_setup = { "alpha" },

    -- Configuration options for the system open command.
    system_open = {
      -- The command to run, leaving empty should work but useful if you want to
      -- override the default command with another one.
      cmd = "launch",

      -- The command arguments as a list.
      args = {},
    },

    -- Don't show LSP and COC diagnostics in the signcolumn
    diagnostics = { enable = false },

    -- Filtering options.
    filters = { -- {{{
      -- Always show dotfiles
      dotfiles = false,

      -- Custom list of vim regex for file/directory names that will not be shown.
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

      -- List of directories or files to exclude from filtering: always show them.
      -- Overrides `git.ignore`, `filters.dotfiles` and `filters.custom`.
      exclude = {},
    }, -- }}}

    -- Will use file system watcher (libuv fs_poll) to watch the filesystem for changes.
    -- Using this will disable BufEnter / BufWritePost events in nvim-tree which
    -- were used to update the whole tree. With this feature, the tree will be
    -- updated only for the appropriate folder change, resulting in better performance.
    filesystem_watchers = {
      enable = true,

      -- Idle milliseconds between filesystem change and action
      debounce_delay = 50,
    },

    -- Git integration with icons and colors
    git = { -- {{{
      enable = true,

      -- Ignore files based on `.gitignore`
      ignore = false,

      -- Show status icons of children when directory itself has no status icon
      show_on_dirs = true,

      -- Kills the git process after some time if it takes too long
      timeout = 500,
    }, -- }}}

    -- Configuration options for trashing
    trash = { -- {{{
      -- The command used to trash items
      cmd = "trash",

      -- Show a prompt before trashing takes place
      require_confirm = true,
    }, -- }}}

    -- Configuration for various actions.
    actions = { -- {{{
      -- A boolean value that toggle the use of system clipboard when copy/paste function are invoked.
      -- When enabled, copied text will be stored in registers '+' (system),
      -- otherwise, it will be stored in '1' and '"'.
      use_system_clipboard = true,

      -- vim |current-directory| behaviour.
      change_dir = { enable = false },

      expand_all = {
        -- Limit the number of folders being explored when expanding every folders.
        -- Avoids hanging neovim when running this action on very large folders.
        max_folder_discovery = 300,

        -- A list of directories that should not be expanded automatically.
        exclude = {},
      },

      open_file = {
        -- Closes the explorer when opening a file.
        -- It will also disable preventing a buffer overriding the tree.
        quit_on_open = false,

        -- Resizes the tree when opening a file.
        resize_window = true,

        window_picker = {
          enable = true,

          -- A string of chars used as identifiers by the window picker.
          chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",

          -- Table of buffer option names mapped to a list of option values that indicates
          -- to the picker that the buffer's window should not be selectable.
          exclude = {
            filetype = { "notify", "packer", "qf", "diff", "ctrlsf", "aerial" },
            buftype = { "nofile", "terminal", "help" },
          },
        },
      },

      -- Close any window displaying a file when removing the file from the tree.
      remove_file = { close_window = true },
    }, -- }}}

    -- Disable logging
    log = { enable = false },
  })

  vim.keymap.set("n", "-", "<Cmd>NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "Toggle the files tree" })
  vim.keymap.set("n", "g-", "<Cmd>NvimTreeFocus<CR>", { noremap = true, silent = true, desc = "Focus the files tree" })
  vim.keymap.set("n", "gF", function()
    require("nvim-tree").find_file(true, nil, false)

    vim.schedule(function()
      vim.fn["x2a#movements#window#CenterCursorAesthetically"]()
    end)
  end, { noremap = true, silent = true, desc = "Focus the current file in in the files tree" })
end

return M
