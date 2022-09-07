-- Module: 0x2a.plugins.lualine.config

return {
  ignored_special_filetypes = { "help", "qf", "man" },
  ignored_plugin_filetypes = { "NvimTree", "fzf", "ctrlsf", "aerial" },
  special_filetypes = { help = "Help", qf = "Quickfix", man = "Man" },
  terminal_filetypes = { terminal = "", toggleterm = "ToggleTerm" },

  plugin_filetypes = {
    NvimTree = "Tree",
    TelescopePrompt = "Telescope",
    fzf = "FZF",
    ctrlsf = "CtrlSF",
    aerial = "Symbols",
  },
}
