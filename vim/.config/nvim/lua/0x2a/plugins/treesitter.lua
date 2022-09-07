-- Module: 0x2a.plugins.treesitter
-- Plugin: nvim-treesitter/nvim-treesitter
-- Description: Nvim Treesitter configurations and abstraction layer
--              Treesitter: An incremental parsing system for programming tools
-- URL: https://github.com/nvim-treesitter/nvim-treesitter
--      https://github.com/nvim-treesitter/playground

local M = {}

M.config = function()
  local ok, _ = pcall(require, "nvim-treesitter.configs")

  if not ok then
    return
  end

  require("nvim-treesitter.configs").setup({
    -- One of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = {
      "ruby",
      "rust",
      "javascript",
      "lua",
      "teal",
      "fennel",

      "make",
      "bash",
      "vim",

      "html",
      "css",
      "scss",

      "json",
      "toml",
      "yaml",

      "query",
    },

    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,

    ignore_install = {},

    highlight = {
      enable = true,

      disable = function(lang, bufnr)
        return lang ~= "teal"
      end,

      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },

    incremental_selection = {
      enable = false,
    },

    indent = {
      enable = false,
    },

    matchup = {
      enable = true,
    },

    autotag = {
      enable = true,
      filetypes = { "html", "xml" },
    },

    context_commentstring = {
      enable = true,
      enable_autocmd = false,
      config = {
        swift = "// %s",
        objc = "// %s",
        cfg = "# %s",
        gitconfig = "# %s",
        gitignore = "# %s",
        eruby = "<%# %s %>",
        dosini = "# %s",
        yaml = "#%s",
        zinit = "# %s",
      },
    },

    textobjects = {
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]]"] = "@function.outer",
        },
        goto_next_end = {
          ["]["] = "@function.outer",
        },
        goto_previous_start = {
          ["[["] = "@function.outer",
        },
        goto_previous_end = {
          ["[]"] = "@function.outer",
        },
      },
    },

    playground = {
      enable = true,
      disable = {},
      updatetime = 25,
      persist_queries = false,
      keybindings = {
        toggle_query_editor = "o",
        toggle_hl_groups = "i",
        toggle_injected_languages = "t",
        toggle_anonymous_nodes = "a",
        toggle_language_display = "I",
        focus_language = "f",
        unfocus_language = "F",
        update = "R",
        goto_node = "<cr>",
        show_help = "?",
      },
    },
  })
end

return M
