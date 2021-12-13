-- Plugin: nvim-lspconfig
-- Description: Quickstart configurations for the Nvim LSP client
-- URL: https://github.com/neovim/nvim-lspconfig

local lspconfig = require("lspconfig")
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  -- Underline warnings and errors
  underline = { severity = { min = vim.diagnostic.severity.WARN } },

  -- Show gutter sings
  signs = {
    -- With highest priority
    priority = 9999,

    -- Only for warnings and errors
    severity = { min = vim.diagnostic.severity.WARN },
  },

  -- Show virtual text only for errors
  virtual_text = { severity = { min = vim.diagnostic.severity.WARN } },

  -- Don't update diagnostics when typing
  update_in_insert = false,
})

-- Ruby
-- https://solargraph.org/
lspconfig.solargraph.setup({ capabilities = capabilities })

-- HTML / CSS
-- https://github.com/hrsh7th/vscode-langservers-extracted

lspconfig.html.setup({ capabilities = capabilities })
lspconfig.cssls.setup({ capabilities = capabilities })

-- Lua
-- https://github.com/sumneko/lua-language-server
local sumneko_binary = os.getenv("LUA_LSP_HOME") .. "/bin/macOS/lua-language-server"
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig.sumneko_lua.setup({
    capabilities = capabilities,
    cmd = { sumneko_binary, "-E", os.getenv("LUA_LSP_HOME") .. "/main.lua" };
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
          -- Setup your lua path
          path = runtime_path,
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  })

-- Bash
-- https://github.com/mads-hartmann/bash-language-server
lspconfig.bashls.setup({ capabilities = capabilities })

-- Vim
-- https://github.com/iamcco/vim-language-server
lspconfig.vimls.setup({ capabilities = capabilities })

-- YAML
-- https://github.com/redhat-developer/yaml-language-server
lspconfig.yamlls.setup({ capabilities = capabilities })
