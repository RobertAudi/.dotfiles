-- Module: 0x2a.plugins.CtrlSF
-- Plugin: dyng/ctrlsf.vim
-- Description: An ack.vim alternative mimics Ctrl-Shift-F on Sublime Text 2
-- URL: https://github.com/dyng/ctrlsf.vim

local M = {}

M.config = function()
  vim.g.ctrlsf_position = "bottom"
  vim.g.ctrlsf_preview_position = "inside"
  vim.g.ctrlsf_default_root = "project"
  vim.g.ctrlsf_winsize = "30%"
  vim.g.ctrlsf_search_mode = "async"
  vim.g.ctrlsf_case_sensitive = "smart"
  vim.g.ctrlsf_ignore_dir = { ".git", ".gem", "bower_components", "node_modules", "vcr_cassettes", "sorbet" }
  vim.g.ctrlsf_auto_preview = true
  vim.g.ctrlsf_context = "-C 3"
  vim.g.ctrlsf_auto_close = { normal = false, compact = false }
  vim.g.ctrlsf_auto_focus = { at = "start", duration_less_than = 1000 }
  vim.g.ctrlsf_extra_backend_args = { ag = "--hidden", rg = "--hidden" }
  vim.g.ctrlsf_mapping = {
    open = { "<Enter>", "o" },
    openb = "O",
    split = "<C-O>",
    vsplit = "<C-v>",
    tab = "<C-t>",
    tabb = "g<C-t>",
    popen = "",
    popenf = "",
    quit = "q",
    next = "<C-n>",
    prev = "<C-p>",
    pquit = "",
    loclist = "",
    chgmode = "",
    fzf = "",
    stop = "<C-C>",
  }

  vim.keymap.set("n", "<C-f>", "<Plug>CtrlSFPrompt", { remap = true })
  vim.keymap.set("x", "<C-f>", "<Plug>CtrlSFVwordExec", { remap = true })
end

return M
