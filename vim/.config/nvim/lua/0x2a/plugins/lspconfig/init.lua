-- Module: 0x2a.plugins.lspconfig
-- Plugin: neovim/nvim-lspconfig
-- Description: Quickstart configurations for the Nvim LSP client
-- URL: https://github.com/neovim/nvim-lspconfig
-- Requires:
--   - hrsh7th/cmp-nvim-lsp
--   - stevearc/aerial.nvim

local M = {}

M.config = function()
  local diagnostics = require("0x2a.plugins.lspconfig.diagnostics")

  diagnostics.setup_signs_column_symbols()
  vim.diagnostic.config(diagnostics.config)
  vim.diagnostic.handlers.signs = diagnostics.handlers.signs

  -- ---

  local lspconfig = require("lspconfig")
  local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    diagnostics.config
  )

  -- Ruby
  -- https://solargraph.org/
  lspconfig.solargraph.setup({
    capabilities = capabilities,
    init_options = { formatting = false },
    on_attach = function(client, bufnr)
      vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

      require("aerial").on_attach(client, bufnr)
    end,
  })

  -- Javascript / Typescript
  -- https://github.com/typescript-language-server/typescript-language-server
  lspconfig.tsserver.setup({})

  -- HTML / CSS / JSON
  -- https://github.com/hrsh7th/vscode-langservers-extracted
  lspconfig.html.setup({
    capabilities = capabilities,
    init_options = {
      configurationSection = { "html", "css", "javascript" },
      embeddedLanguages = { css = true, javascript = true },
      provideFormatter = false,
    },
    on_attach = function(client, bufnr)
      vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    end,
  })

  lspconfig.cssls.setup({
    capabilities = capabilities,
    init_options = {
      provideFormatter = false,
    },
    on_attach = function(client, bufnr)
      vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    end,
  })

  lspconfig.jsonls.setup({ capabilities = capabilities })

  -- CSS / SCSS formatting
  lspconfig.stylelint_lsp.setup({
    capabilities = capabilities,
    filetypes = { "css", "scss" },
    settings = {
      stylelintplus = {
        configFile = os.getenv("XDG_CONFIG_HOME") .. "/stylelint/config.json",
      },
    },
  })

  -- Rust
  lspconfig.rls.setup({
    settings = {
      rust = {
        unstable_features = true,
        build_on_save = false,
        all_features = true,
      },
    },
  })

  -- Lua
  -- https://github.com/sumneko/lua-language-server
  local sumneko_binary = os.getenv("LUA_LSP_HOME") .. "/bin/lua-language-server"
  local runtime_path = vim.split(package.path, ";")
  table.insert(runtime_path, "?.lua")
  table.insert(runtime_path, "?/init.lua")

  lspconfig.sumneko_lua.setup({
    capabilities = capabilities,
    cmd = { sumneko_binary, "-E", os.getenv("LUA_LSP_HOME") .. "/main.lua" },
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
          globals = { "vim", "use", "hs", "spoon" },
        },

        format = {
          enable = false,
        },

        workspace = {
          -- Make the server aware of Neovim runtime files
          library = require("lua-dev.sumneko").library({
            library = { vimruntime = true, types = true, plugins = true },
            runtime_path = false,
          }),
        },

        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },

    on_attach = function(client, bufnr)
      -- client.resolved_capabilities.document_formatting = false -- deprecated
      -- client.resolved_capabilities.document_range_formatting = false -- deprecated
      client.server_capabilities.document_formatting = false
      client.server_capabilities.document_range_formatting = false

      vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

      require("aerial").on_attach(client, bufnr)
    end,
  })

  -- Bash
  -- https://github.com/mads-hartmann/bash-language-server
  lspconfig.bashls.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    end,
  })

  -- Vim
  -- https://github.com/iamcco/vim-language-server
  lspconfig.vimls.setup({
    capabilities = capabilities,
    isNeovim = true,
    on_attach = function(client, bufnr)
      vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

      require("aerial").on_attach(client, bufnr)
    end,
  })

  -- YAML
  -- https://github.com/redhat-developer/yaml-language-server
  lspconfig.yamlls.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

      require("aerial").on_attach(client, bufnr)
    end,
  })
end

return M
