-- Plugin: nvim-treesitter/nvim-treesitter
-- Description: Nvim Treesitter configurations and abstraction layer
--              Treesitter: An incremental parsing system for programming tools
-- URL: https://github.com/nvim-treesitter/nvim-treesitter

vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
