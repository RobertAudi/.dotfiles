-- Module: 0x2a.plugins.null-ls
-- Plugin: jose-elias-alvarez/null-ls.nvim
-- Description: Use Neovim as a language server to inject LSP diagnostics,
--              code actions, and more via Lua.
-- URL: https://github.com/jose-elias-alvarez/null-ls.nvim

local M = {}

M.config = function()
  local ok, null_ls = pcall(require, "null-ls")

  if not ok then
    return
  end

  null_ls.setup({
    sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.diagnostics.luacheck.with({
        extra_args = { "--default-config", os.getenv("XDG_CONFIG_HOME") .. "/luacheck/.luacheckrc" },
      }),

      null_ls.builtins.formatting.standardrb,
      null_ls.builtins.diagnostics.standardrb,

      -- Makefiles
      null_ls.builtins.diagnostics.checkmake,

      -- Vimscript
      null_ls.builtins.diagnostics.vint,

      -- YAML
      null_ls.builtins.diagnostics.yamllint,

      -- JSON
      null_ls.builtins.formatting.jq,

      -- TOML
      null_ls.builtins.formatting.taplo,

      null_ls.builtins.diagnostics.zsh,

      -- GitHub actions
      null_ls.builtins.diagnostics.actionlint.with({
        runtime_condition = function(params)
          return params.bufname:match("\\.github/workflows") ~= nil
        end,
      }),

      null_ls.builtins.formatting.prettierd.with({
        filetypes = { "javascript" },
      }),

      -- Markdown
      null_ls.builtins.formatting.remark,
    },
  })
end

return M
