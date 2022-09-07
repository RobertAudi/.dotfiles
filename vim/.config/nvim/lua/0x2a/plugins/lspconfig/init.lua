-- Module: 0x2a.plugins.lspconfig
-- Plugin: neovim/nvim-lspconfig
-- Description: Quickstart configurations for the Nvim LSP client
-- URL: https://github.com/neovim/nvim-lspconfig
-- Requires:
--   - hrsh7th/cmp-nvim-lsp
--   - stevearc/aerial.nvim

local M = {}

M.config = function()
  local lspconfig = prequire("lspconfig")

  if not lspconfig then
    return
  end

  -- ---

  local attach_navic = function(client, bufnr)
    local navic = prequire("nvim-navic")

    if navic then
      navic.attach(client, bufnr)
    end
  end

  local attach_aerial = function(client, bufnr)
    local aerial = prequire("aerial")

    if aerial then
      aerial.on_attach(client, bufnr)
    end
  end

  local set_keymaps = function(client, bufnr)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = bufnr, noremap = true, desc = "next diagnostic" })
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = bufnr, noremap = true, desc = "previous diagnostic" })
  end

  -- ---

  local diagnostics = require("0x2a.plugins.lspconfig.diagnostics")

  diagnostics.setup_signs_column_symbols()
  vim.diagnostic.config(diagnostics.config)
  vim.diagnostic.handlers.signs = diagnostics.handlers.signs

  -- ---

  local cmp_nvim_lsp = prequire("cmp_nvim_lsp")
  local capabilities

  if cmp_nvim_lsp then
    capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
  else
    capabilities = vim.lsp.protocol.make_client_capabilities()
  end

  -- local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, diagnostics.config)

  -- Ruby
  -- https://solargraph.org/
  lspconfig.solargraph.setup({
    capabilities = capabilities,
    init_options = {
      autoformat = false,
      formatting = false,
    },
    on_attach = function(client, bufnr)
      vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

      set_keymaps(client, bufnr)
      attach_aerial(client, bufnr)
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

      set_keymaps(client, bufnr)
      attach_navic(client, bufnr)
    end,
  })

  lspconfig.cssls.setup({
    capabilities = capabilities,
    init_options = {
      provideFormatter = false,
    },
    on_attach = function(client, bufnr)
      vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

      set_keymaps(client, bufnr)
      attach_navic(client, bufnr)
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

  -- XML
  lspconfig.lemminx.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      set_keymaps(client, bufnr)
      attach_navic(client, bufnr)
      attach_aerial(client, bufnr)
    end,
  })

  -- Swift and Objective-C.
  lspconfig.sourcekit.setup({
    root_dir = require("lspconfig.util").root_pattern("Package.swift", ".git", "*.xcodeproj"),
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
        IntelliSense = {
          traceLocalSet = true,
          traceReturn = true,
          traceBeSetted = true,
          traceFieldInject = true,
        },

        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
          -- Setup your lua path
          path = runtime_path,
        },

        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim", "use", "hs", "spoon", "use_rocks", "prequire", "packer_plugins" },

          disable = {
            "unused-local",
            "missing-parameter", -- HACK: for vim.fn.expand()
            "redundant-parameter", -- HACK: return function
            "need-check-nil", -- HACK: return tbl, err
          },
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

      set_keymaps(client, bufnr)
      attach_navic(client, bufnr)
      attach_aerial(client, bufnr)
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

      set_keymaps(client, bufnr)
      attach_navic(client, bufnr)
      attach_aerial(client, bufnr)
    end,
  })

  -- YAML
  -- https://github.com/redhat-developer/yaml-language-server
  lspconfig.yamlls.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

      set_keymaps(client, bufnr)
      attach_navic(client, bufnr)
      attach_aerial(client, bufnr)
    end,
  })
end

return M
