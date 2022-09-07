-- Module: 0x2a.plugins.nvim-tree
-- Plugin: kyazdani42/nvim-tree.lua
-- Description: A file explorer tree for neovim written in lua
-- URL: https://github.com/kyazdani42/nvim-tree.lua
-- Requires:
--   - 0x2a.plugins.nvim-tree.callbacks

local API = require("nvim-tree.api")
local callbacks = require("0x2a.plugins.nvim-tree.callbacks")

local M = {}

M.keymaps = {
  {
    key = { "<Enter>", "<2-LeftMouse>" },
    callback = API.node.open.edit,
    desc = "open a file or folder; root will cd to the above directory",
  },

  {
    key = { "l", "o" },
    callback = callbacks.expand,
  },

  {
    key = "h",
    callback = callbacks.collapse,
  },

  {
    key = "A",
    callback = callbacks.zoom,
    desc = "Increase the size of the tree explorer",
  },

  -- {
  --   key = "<C-e>",
  --   callback = API.node.open.replace_tree_buffer,
  --   desc = "edit the file in place, effectively replacing the tree explorer",
  -- },

  {
    key = "O",
    callback = API.node.open.no_window_picker,
    desc = "same as (edit) with no window picker",
  },

  {
    key = { "<C-v>", "v", "s" },
    callback = API.node.open.vertical,
    desc = "open the file in a vertical split",
  },

  {
    key = { "<C-x>", "i" },
    callback = API.node.open.horizontal,
    desc = "open the file in a horizontal split",
  },

  {
    key = { "<C-t>", "t" },
    callback = API.node.open.tab,
    desc = "open the file in a new tab",
  },

  {
    key = "<",
    callback = API.node.navigate.sibling.prev,
    desc = "navigate to the previous sibling of current file/directory",
  },

  {
    key = ">",
    callback = API.node.navigate.sibling.next,
    desc = "navigate to the next sibling of current file/directory",
  },

  {
    key = "P",
    callback = API.node.navigate.parent,
    desc = "move cursor to the parent directory",
  },

  {
    key = "<BS>",
    callback = API.node.navigate.parent_close,
    desc = "close current opened directory or parent",
  },

  {
    key = "<Space>",
    callback = callbacks.preview, -- API.node.open.preview
    desc = "open the file as a preview (keeps the cursor in the tree)",
  },

  {
    key = "K",
    callback = API.node.navigate.sibling.first,
    desc = "navigate to the first sibling of current file/directory",
  },

  {
    key = "J",
    callback = API.node.navigate.sibling.last,
    desc = "navigate to the last sibling of current file/directory",
  },

  {
    key = "I",
    callback = API.tree.toggle_gitignore_filter,
    desc = "toggle visibility of files/folders hidden via |git.ignore| option",
  },

  -- {
  --   key = "H",
  --   callback = API.tree.toggle_hidden_filter,
  --   desc = "toggle visibility of dotfiles via |filters.dotfiles| option",
  -- },

  -- {
  --   key = "U",
  --   callback = API.tree.toggle_custom_filter,
  --   desc = "toggle visibility of files/folders hidden via |filters.custom| option",
  -- },

  {
    key = "R",
    callback = API.tree.reload,
    desc = "refresh the tree",
  },

  {
    key = "a",
    callback = API.fs.create,
    desc = "add a file; leaving a trailing `/` will add a directory",
  },

  {
    key = "D",
    callback = API.fs.remove,
    desc = "delete a file (will prompt for confirmation)",
  },

  {
    key = "d",
    callback = API.fs.trash,
    desc = "trash a file via |trash| option",
  },

  {
    key = "r",
    callback = API.fs.rename,
    desc = "rename a file",
  },

  {
    key = "<C-r>",
    callback = API.fs.rename_sub,
    desc = "rename a file and omit the filename on input",
  },

  {
    key = "x",
    callback = API.fs.cut,
    desc = "add/remove file/directory to cut clipboard",
  },

  {
    key = "c",
    callback = API.fs.copy.node,
    desc = "add/remove file/directory to copy clipboard",
  },

  {
    key = "p",
    callback = API.fs.paste,
    desc = "paste from clipboard; cut clipboard has precedence over copy; will prompt for confirmation",
  },

  {
    key = "y",
    callback = API.fs.copy.filename,
    desc = "copy name to system clipboard",
  },

  {
    key = "Y",
    callback = API.fs.copy.relative_path,
    desc = "copy relative path to system clipboard",
  },

  {
    key = "gy",
    callback = API.fs.copy.absolute_path,
    desc = "copy absolute path to system clipboard",
  },

  -- {
  --   key = "[e",
  --   callback = API.node.navigate.diagnostics.next,
  --   desc = "go to next diagnostic item",
  -- },

  {
    key = "]c",
    callback = API.node.navigate.git.next,
    desc = "go to next git item",
  },

  -- {
  --   key = "]e",
  --   callback = API.node.navigate.diagnostics.prev,
  --   desc = "go to prev diagnostic item",
  -- },

  {
    key = "[c",
    callback = API.node.navigate.git.prev,
    desc = "go to prev git item",
  },

  -- {
  --   key = "-",
  --   callback = API.tree.change_root_to_parent,
  --   desc = "navigate up to the parent directory of the current file/directory",
  -- },

  {
    key = "go",
    callback = API.node.run.system,
    desc = "open a file with default system application or a folder with default file manager, using |system_open| option",
  },

  -- {
  --   key = "f",
  --   callback = API.live_filter.start,
  --   desc = "live filter nodes dynamically based on regex matching.",
  -- },
  --
  -- {
  --   key = "F",
  --   callback = API.live_filter.clear,
  --   desc = "clear live filter",
  -- },

  {
    key = "-",
    callback = API.tree.close,
    desc = "close tree window",
  },

  {
    key = "q",
    callback = callbacks.quit_or_close_help,
    desc = "close the help or the tree window",
  },

  {
    key = "W",
    callback = API.tree.collapse_all,
    desc = "collapse the whole tree",
  },

  {
    key = "E",
    callback = API.tree.expand_all,
    desc = "expand the whole tree, stopping after expanding |callbacks.expand_all.max_folder_discovery| folders; this might hang neovim for a while if running on a big folder",
  },

  {
    key = "S",
    callback = API.tree.search_node,
    desc = "prompt the user to enter a path and then expands the tree to match the path",
  },

  {
    key = ".",
    callback = API.node.run.cmd,
    desc = "enter vim command mode with the file the cursor is on",
  },

  {
    key = "<C-k>",
    callback = API.node.show_info_popup,
    desc = "toggle a popup with file infos about the file under the cursor",
  },

  {
    key = "?",
    callback = API.tree.toggle_help,
    desc = "toggle help",
  },

  {
    key = "m",
    callback = API.marks.toggle,
    desc = "Toggle node in bookmarks",
  },

  {
    key = "bmv",
    callback = API.marks.bulk.move,
    desc = "Move all bookmarked nodes into specified location",
  },
}

M.set_keymaps = function(bufnr)
  local opts = { noremap = true, silent = true, nowait = true, buffer = bufnr }

  for _, km in ipairs(M.keymaps) do
    local keys = type(km.key) == "table" and km.key or { km.key }

    opts.desc = km.desc

    for _, key in ipairs(keys) do
      vim.keymap.set("n", key, km.callback, opts)
    end
  end
end

return M
