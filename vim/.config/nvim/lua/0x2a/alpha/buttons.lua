-- Module: 0x2a.alpha.buttons
-- Requires:
--   - nvim-telescope/telescope.nvim
--   - 0x2a.alpha.button
--   - 0x2a.git
--   - 0x2a.utils
--   - 0x2a.utils.fs

local button = require("0x2a.alpha.button")

return {
  new_file = button("e", "  New file", "<Cmd>enew <BAR> startinsert <CR>"),

  find_file = button("f", "  Find file", "", {
    callback = function()
      require("telescope.builtin").find_files()
    end,
  }),

  recent_files = button("o", "  Recent", "", {
    callback = function()
      require("telescope.builtin").oldfiles({ cwd_only = true })
    end,
  }),

  vim_files = button("v", "  Vim files", "", {
    callback = function()
      require("telescope.builtin").find_files({ cwd = require("0x2a.utils.fs").dotfiles_directory("vim/.config/nvim") })
    end,
  }),

  zsh_files = button("z", "  Zsh files", "", {
    callback = function()
      require("telescope.builtin").find_files({ cwd = require("0x2a.utils.fs").dotfiles_directory("zsh") })
    end,
  }),

  sandbox = button("s", "  Sandbox", "", {
    callback = function()
      require("telescope.builtin").find_files({ cwd = require("0x2a.utils.fs").dotfiles_directory("sandbox") })
    end,
  }),

  file_tree = button("-", "  File Tree", "<Cmd>enew <BAR> NvimTreeToggle<CR>"),

  restore_session = button("r", "  Restore previous session", "<Cmd>SessionManager load_current_dir_session<CR>"),

  browse = button("b", "  Browse", "", {
    callback = function()
      require("0x2a.utils").browse(require("0x2a.git").repo_url())
    end,
  }),

  neogit = button("g", "  Git", "", {
    callback = function()
      require("neogit").open()
    end,
  }),

  reload_config = button("R", "  Reload config", "<Cmd>PackerCompile<CR>"),
  update_plugins = button("U", "  Update plugins", "<Cmd>PackerSync<CR>"),
  quit = button("q", "  Quit Neovim", "<Cmd>quitall<CR>"),
  close = button("q", "  Close dashboard", "<Cmd>buffer #<CR>"),

  close_or_quit = button("q", function()
    if require("0x2a.utils.buffer").count() > 0 and require("0x2a.utils.buffer").alternate_buffer_exists() then
      return "  Close dashboard"
    else
      return "  Quit Neovim"
    end
  end, function()
    if require("0x2a.utils.buffer").count() > 0 and require("0x2a.utils.buffer").alternate_buffer_exists() then
      require("0x2a.alpha").close()
      vim.cmd.buffer("#")
    else
      vim.cmd.quitall()
    end
  end),
}
