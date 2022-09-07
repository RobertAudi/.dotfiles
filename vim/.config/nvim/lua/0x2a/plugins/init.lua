-- Module: 0x2a.plugins.plugins
-- Requires:
--   - 0x2a.symbols
--   - 0x2a.utils
--   - 0x2a.utils.fs
--   - wbthomason/packer.nvim

local symbols = require("0x2a.symbols")

return require("packer").startup({
  function()
    -- A use-package inspired plugin manager for Neovim.
    --   https://github.com/wbthomason/packer.nvim
    use({ "wbthomason/packer.nvim", config = require("0x2a.plugins.packer").config })

    -- Improve startup time for Neovim
    --   https://github.com/lewis6991/impatient.nvim
    use("lewis6991/impatient.nvim")

    -- full; complete; entire; absolute; unqualified.
    -- All the lua functions I don't want to write twice.
    --   https://github.com/nvim-lua/plenary.nvim
    use("nvim-lua/plenary.nvim")

    -- The luv docs in vimdoc format.
    --   https://github.com/nanotee/luv-vimdocs
    --   https://github.com/luvit/luv/blob/master/docs.md
    use("nanotee/luv-vimdocs")

    -- FileType plugins {{{
    -- ------------------------------------------------------------------------------

    -- Context filetype library for Vim script
    --   https://github.com/Shougo/context_filetype.vim
    use("Shougo/context_filetype.vim")

    -- Vim {{{
    -- ------------------------------------------------------------------------------

    -- Better VimL syntax highlighting
    --   https://github.com/vim-jp/syntax-vim-ex
    use({ "vim-jp/syntax-vim-ex", ft = { "vim" } })

    -- Prettyprint vim variables
    --   https://github.com/thinca/vim-prettyprint
    use({ "thinca/vim-prettyprint", ft = { "vim" } })

    -- Better completion for Vim builtins
    --   https://github.com/fcpg/vim-complimentary
    use({
      "fcpg/vim-complimentary",
      ft = { "vim" },
      config = function()
        -- Disable all `:Set` commands.
        vim.g.cpty_no_set_cmd = true
      end,
    })

    -- Jump to the definition of variables or functions in VimL code.
    --   https://github.com/mhinz/vim-lookup
    use({ "mhinz/vim-lookup", ft = { "vim" } })

    -- Search Dash.app from Vim
    --   https://github.com/rizzatti/dash.vim
    use({
      "rizzatti/dash.vim",
      config = function()
        vim.g.dash_map = { ruby = { "ruby", "rubygems", "rails", "ruby-test" } }
      end,
    })

    -- Show syntax highlighting attributes of character under cursor.
    --   https://github.com/inkarkat/SyntaxAttr.vim
    use({
      "inkarkat/SyntaxAttr.vim",
      config = function()
        vim.api.nvim_create_user_command("ShowSyntax", "call SyntaxAttr#SyntaxAttr()", { nargs = 0 })
      end,
    })

    -- ------------------------------------------------------------------------------ }}}

    -- Syntax highlighting for AppleScript
    --   https://github.com/RobertAudi/applescript.vim
    use({ "RobertAudi/applescript.vim", ft = { "applescript" } })

    -- Vim runtime files for Swift
    --   https://github.com/keith/swift.vim
    use({ "keith/swift.vim", ft = { "swift" } })

    -- Vim runtime files for xcconfigs
    --   https://github.com/keith/xcconfig.vim
    use("keith/xcconfig.vim")

    -- Vim syntax for TOML
    --   https://github.com/cespare/vim-toml
    use({ "cespare/vim-toml", ft = { "toml" } })

    -- Vim Syntax for Homebrew formulae
    --   https://github.com/xu-cheng/brew.vim
    use("xu-cheng/brew.vim")

    -- Super small plugin to improve Vim’s highlighting of shell scripts
    --   https://github.com/arzg/vim-sh
    use("arzg/vim-sh")

    -- Vim support for editing fish scripts
    --   https://github.com/dag/vim-fish
    use({ "dag/vim-fish", ft = { "fish" } })

    -- CSS {{{
    -- ------------------------------------------------------------------------------

    -- CSS3 syntax support
    --   https://github.com/hail2u/vim-css3-syntax
    use({ "hail2u/vim-css3-syntax", ft = { "css" } })

    -- Vim syntax file for scss
    --   https://github.com/cakebaker/scss-syntax.vim
    use({ "cakebaker/scss-syntax.vim", ft = { "scss" } })

    -- ------------------------------------------------------------------------------ }}}

    -- Read and browse info files in Vim
    --   https://github.com/HiPhish/info.vim
    use({ "HiPhish/info.vim", ft = { "info" } })

    -- Improved Lua 5.3 syntax and indentation support for Vim
    --   https://github.com/tbastos/vim-lua
    use({ "tbastos/vim-lua", ft = { "lua" } })

    -- Interactive real time neovim scratchpad for embedded lua engine - type and watch!
    --   https://github.com/rafcamlet/nvim-luapad
    use({
      "rafcamlet/nvim-luapad",
      opt = true,
      cmd = { "Luapad", "LuaRun" },
      config = function()
        require("luapad").setup({
          count_limit = 150000,
          split_orientation = "horizontal",
          preview = false,
        })
      end,
    })

    -- Python syntax highlighting for Vim (enhanced version)
    --   https://github.com/vim-python/python-syntax
    use({ "vim-python/python-syntax", ft = { "python" } })

    -- Support for Perl 5 in Vim
    --   https://github.com/vim-perl/vim-perl
    use({ "vim-perl/vim-perl", ft = { "perl" } })

    -- Vim configuration for Rust.
    --   https://github.com/rust-lang/rust.vim
    use({
      "rust-lang/rust.vim",
      ft = { "rust" },
      config = function()
        -- Disable cargo commands
        vim.g.loaded_rust_vim_plugin_cargo = true
      end,
    })

    -- SQL {{{
    -- ------------------------------------------------------------------------------

    -- Postgresql syntax
    --   https://github.com/exu/pgsql.vim
    use({
      "exu/pgsql.vim",
      ft = { "sql", "pgsql" },
      config = function()
        -- Make pgsql.vim the default for SQL syntax
        vim.g.sql_type_default = "pgsql"
      end,
    })

    -- A plugin for SQL formatter like gofmt
    --   https://github.com/b4b4r07/vim-sqlfmt
    use({
      "b4b4r07/vim-sqlfmt",
      config = function()
        if require("0x2a.utils.fs").is_executable("sqlfmt") then
          vim.g.sqlfmt_command = "sqlfmt"
          vim.g.sqlfmt_options = ""
        elseif require("0x2a.utils.fs").is_executable("sqlformat") then
          vim.g.sqlfmt_command = "sqlformat"
          vim.g.sqlfmt_options = "-r -k upper"
        end
      end,
    })

    -- Syntax highlighting for SQL heredocs
    --   https://github.com/aliou/sql-heredoc.vim
    use("aliou/sql-heredoc.vim")

    -- ------------------------------------------------------------------------------ }}}

    -- HTML5 omnicomplete and syntax
    --   https://github.com/othree/html5.vim
    use("othree/html5.vim")

    -- Override vim syntax for yaml files (faster)
    --   https://github.com/stephpy/vim-yaml
    use({ "stephpy/vim-yaml", ft = { "yaml" } })

    -- A better JSON for Vim
    --   https://github.com/elzr/vim-json
    use({ "elzr/vim-json", ft = { "json" } })

    -- Javascript {{{
    -- ------------------------------------------------------------------------------

    -- Vastly improved Javascript indentation and syntax support in Vim.
    --   https://github.com/pangloss/vim-javascript
    use({ "pangloss/vim-javascript", ft = { "javascript", "typescript" } })

    -- Typescript syntax files for Vim
    --   https://github.com/leafgarland/typescript-vim
    use({ "leafgarland/typescript-vim", ft = { "javascript", "typescript" } })

    -- CoffeeScript support for vim
    --   https://github.com/kchmck/vim-coffee-script
    use({ "kchmck/vim-coffee-script", ft = { "coffee", "litcoffee" } })

    -- A vim plugin for highlighting and indenting JST/EJS syntax
    --   https://github.com/briancollins/vim-jst
    use({ "briancollins/vim-jst", ft = { "javascript", "typescript" } })

    -- Standalone JSDoc syntax for vim
    --   https://github.com/othree/jsdoc-syntax.vim
    use({ "othree/jsdoc-syntax.vim", ft = { "javascript", "typescript" } })

    -- JSX and TSX syntax pretty highlighting for vim.
    --   https://github.com/MaxMEllon/vim-jsx-pretty
    use({ "MaxMEllon/vim-jsx-pretty", ft = { "javascript", "typescript" } })

    -- React JSX syntax highlighting for vim and Typescript
    --   https://github.com/peitalin/vim-jsx-typescript
    use({ "peitalin/vim-jsx-typescript", ft = { "javascript", "typescript" } })

    -- Vim bundle for http://styled-components.com based javascript files
    --   https://github.com/styled-components/vim-styled-components
    use("styled-components/vim-styled-components")

    -- ------------------------------------------------------------------------------ }}}

    -- Mustache and Handlebars mode for vim
    --   https://github.com/mustache/vim-mustache-handlebars
    use("mustache/vim-mustache-handlebars")

    -- Markdown {{{
    -- ------------------------------------------------------------------------------

    -- A vim 7.4+ plugin to generate table of contents for Markdown files.
    --   https://github.com/mzlogin/vim-markdown-toc
    use({
      "mzlogin/vim-markdown-toc",
      ft = { "markdown" },
      config = function()
        vim.g.vmt_auto_update_on_save = false
        vim.g.vmt_dont_insert_fence = true
        vim.g.vmt_list_item_char = "-"
      end,
    })

    -- GitHub Flavored Markdown syntax highlight extension for Vim
    --   https://github.com/rhysd/vim-gfm-syntax
    use({
      "rhysd/vim-gfm-syntax",
      ft = { "markdown" },
      config = function()
        vim.g.gfm_syntax_enable_always = false
        vim.g.gfm_syntax_highlight_emoji = false
        vim.g.gfm_syntax_enable_filetypes = { "markdown" }
      end,
    })

    -- Open the current Markdown buffer in Marked.app
    --   https://github.com/itspriddle/vim-marked
    use({ "itspriddle/vim-marked", ft = { "markdown" } })

    -- VIM Table Mode for instant table creation.
    --   https://github.com/dhruvasagar/vim-table-mode
    use({
      "dhruvasagar/vim-table-mode",
      ft = { "markdown" },
      setup = function()
        vim.g.table_mode_disable_tableize_mappings = true
      end,
    })

    -- 🔫 Bullets.vim is a Vim/NeoVim plugin for automated bullet lists.
    --   https://github.com/dkarter/bullets.vim
    use({
      "dkarter/bullets.vim",
      ft = { "markdown", "text", "gitcommit" },
      config = function()
        vim.g.bullets_enabled_file_types = { "markdown", "text", "gitcommit" }
      end,
    })

    -- ------------------------------------------------------------------------------ }}}

    -- Asciidoc syntax and configuration for Vim
    --   https://github.com/mjakl/vim-asciidoc
    use({
      "mjakl/vim-asciidoc",
      ft = { "asciidoc" },
      config = function()
        vim.g.vim_asciidoc_folding_disabled = false
      end,
    })

    -- Syntax highlighting for generic log files in VIM
    --   https://github.com/MTDL9/vim-log-highlighting
    use("MTDL9/vim-log-highlighting")

    -- Vim syntax file & snippets for Docker's Dockerfile
    --   https://github.com/ekalinin/Dockerfile.vim
    use("ekalinin/Dockerfile.vim")

    -- Improved nginx vim plugin (incl. syntax highlighting)
    --   https://github.com/chr4/nginx.vim
    use("chr4/nginx.vim")

    -- Git {{{
    -- ------------------------------------------------------------------------------

    -- Vim Git runtime files
    --   https://github.com/tpope/vim-git
    use("tpope/vim-git")

    -- Provides the branch name of the current git repository
    --   https://github.com/itchyny/vim-gitbranch
    use({
      "itchyny/vim-gitbranch",
      config = function()
        -- Show git branch with ctrl-g info
        vim.keymap.set("n", "<C-g>", "<Cmd>call x2a#gitbranch#ctrl_g(v:count)<CR>", { noremap = true })
      end,
    })

    -- Git integration for buffers
    --   https://github.com/lewis6991/gitsigns.nvim
    use({
      "lewis6991/gitsigns.nvim",
      opt = true,

      setup = function()
        require("0x2a.utils.plugins").packer_lazy_load("gitsigns.nvim")
      end,

      config = require("0x2a.plugins.gitsigns").config,
    })

    -- Weapon to fight against conflicts in Vim.
    --   https://github.com/rhysd/conflict-marker.vim
    use({
      "rhysd/conflict-marker.vim",
      event = "BufRead",
      config = require("0x2a.plugins.conflict-marker").config,
    })

    -- A Vim plugin for more pleasant editing on commit messages
    --   https://github.com/rhysd/committia.vim
    use({
      "rhysd/committia.vim",
      cond = function()
        return vim.fn.expand("%:t") == "COMMIT_EDITMSG"
      end,
    })

    -- A plugin to run `git blame` on the current buffer.
    --   https://github.com/RobertAudi/git-blame.vim
    use({
      "RobertAudi/git-blame.vim",
      cmd = "GBlame",
      config = function()
        vim.g.gitblame_mappings = { previewCommit = "<Enter>", close = "q" }

        vim.api.nvim_create_user_command("GBlame", "call gitblame#blame()", { nargs = 0 })
      end,
    })

    -- ------------------------------------------------------------------------------ }}}

    -- Vim configuration files for Nix
    --   https://github.com/LnL7/vim-nix
    --   http://nixos.org/nix
    use({ "LnL7/vim-nix", ft = { "nix" } })

    -- Ruby {{{
    -- ------------------------------------------------------------------------------

    -- Vim/Ruby Configuration Files
    --   https://github.com/vim-ruby/vim-ruby
    use({
      "vim-ruby/vim-ruby",
      ft = { "ruby", "rspec", "ruby.rake", "eruby", "rbs" },
      config = function()
        vim.g.rubycomplete_buffer_loading = false
        vim.g.rubycomplete_classes_in_global = true
        vim.g.rubycomplete_rails = true
        vim.g.rubycomplete_load_gemfile = false
        vim.g.rubycomplete_use_bundler = false
      end,
    })

    -- Syntax plugin for RBS
    --   https://github.com/pocke/rbs.vim
    use({ "pocke/rbs.vim", ft = { "rbs" } })

    -- Ruby on Rails power tools
    --   https://github.com/tpope/vim-rails
    use({ "tpope/vim-rails", ft = { "ruby", "rspec", "ruby.rake", "eruby", "rbs" } })

    -- It's like rails.vim without the rails
    --   https://github.com/tpope/vim-rake
    use({ "tpope/vim-rake", ft = { "ruby.rake" } })

    -- Lightweight support for Ruby's Bundler
    --   https://github.com/tpope/vim-bundler
    use({ "tpope/vim-bundler", ft = { "ruby", "gemfilelock" } })

    -- Vim plugin for highliting code in ruby here document
    --   https://github.com/joker1007/vim-ruby-heredoc-syntax
    use({ "joker1007/vim-ruby-heredoc-syntax", ft = { "ruby", "rspec", "ruby.rake", "rbs" } })

    -- Better rspec syntax highlighting for Vim
    --   https://github.com/keith/rspec.vim
    use({ "keith/rspec.vim", ft = { "ruby", "rspec" } })

    -- Ruby syntax extensions for highlighting YARD documentation.
    --   https://github.com/noprompt/vim-yardoc
    use({ "noprompt/vim-yardoc", ft = { "ruby", "ruby.rake" } })

    -- Slim syntax highlighting for VIM
    --   https://github.com/slim-template/vim-slim
    use({ "slim-template/vim-slim", ft = { "slim" } })

    -- ------------------------------------------------------------------------------ }}}

    -- Tmux {{{
    -- ------------------------------------------------------------------------------

    -- Vim plugin for tmux.conf
    --   https://github.com/tmux-plugins/vim-tmux
    use("tmux-plugins/vim-tmux")

    -- Seamless navigation between tmux panes and vim splits
    --   https://github.com/christoomey/vim-tmux-navigator
    use({
      "christoomey/vim-tmux-navigator",
      setup = function()
        vim.g.tmux_navigator_no_mappings = true
      end,

      config = function()
        vim.keymap.set(
          { "n", "x" },
          "<C-h>",
          "<Cmd>TmuxNavigateLeft<CR>",
          { noremap = true, desc = "Move to the split on the left" }
        )

        vim.keymap.set(
          { "n", "x" },
          "<C-j>",
          "<Cmd>TmuxNavigateDown<CR>",
          { noremap = true, desc = "Move to the split below" }
        )

        vim.keymap.set(
          { "n", "x" },
          "<C-k>",
          "<Cmd>TmuxNavigateUp<CR>",
          { noremap = true, desc = "Move to the split above" }
        )

        vim.keymap.set(
          { "n", "x" },
          "<C-l>",
          "<Cmd>TmuxNavigateRight<CR>",
          { noremap = true, desc = "Move to the split on the right" }
        )
      end,
    })

    -- ------------------------------------------------------------------------------ }}}

    -- A Vim syntax definition for Zinit commands in any ft=zsh file
    --   https://github.com/zdharma-continuum/zinit-vim-syntax
    use({ "zdharma-continuum/zinit-vim-syntax", ft = { "zsh" } })

    -- ------------------------------------------------------------------------------ }}}

    -- Nvim Treesitter configurations and abstraction layer
    --   https://github.com/nvim-treesitter/nvim-treesitter
    use({
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      requires = {
        -- Treesitter playground integrated into Neovim
        --   https://github.com/nvim-treesitter/playground
        { "nvim-treesitter/playground", after = "nvim-treesitter" },

        -- Neovim treesitter plugin for setting the commentstring based on the cursor location in a file.
        --   https://github.com/JoosepAlviste/nvim-ts-context-commentstring
        { "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter" },

        -- Syntax aware text-objects, select, move, swap, and peek support.
        --   https://github.com/nvim-treesitter/nvim-treesitter-textobjects
        { "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" },
      },

      config = require("0x2a.plugins.treesitter").config,
    })

    -- Quoting/parenthesizing made simple
    --   https://github.com/tpope/vim-surround
    use({
      "tpope/vim-surround",
      config = function()
        -- Toggle between single/double quotes
        vim.keymap.set("n", "['", [[cs'"]], { silent = true, remap = true })
        vim.keymap.set("n", "]'", [[cs"']], { silent = true, remap = true })
        vim.keymap.set("n", "[\"", [[cs"']], { silent = true, remap = true })
        vim.keymap.set("n", "]\"", [[cs'"]], { silent = true, remap = true })
      end,
    })

    -- Smart and powerful comment plugin for neovim.
    --   https://github.com/numToStr/Comment.nvim
    use({
      "numToStr/Comment.nvim",
      after = "nvim-ts-context-commentstring",
      config = require("0x2a.plugins.Comment").config,
    })

    -- Unicode character metadata
    --   https://github.com/tpope/vim-characterize
    use("tpope/vim-characterize")

    -- Wisely add "end" in ruby, endfunction/endif/more in vim script, etc
    --   https://github.com/tpope/vim-endwise
    use("tpope/vim-endwise")

    -- Ghetto HTML/XML mappings
    --   https://github.com/tpope/vim-ragtag
    use({
      "tpope/vim-ragtag",
      config = function()
        vim.g.ragtag_global_maps = false
      end,
    })

    -- Granular project configuration
    --   https://github.com/tpope/vim-projectionist
    use("tpope/vim-projectionist")

    -- Set the 'path' option for miscellaneous file types
    --   https://github.com/tpope/vim-apathy
    use("tpope/vim-apathy")

    -- Enable repeating supported plugin maps with "."
    --   https://github.com/tpope/vim-repeat
    use("tpope/vim-repeat")

    -- Create repeat.vim mappings with one simple "Repeatable" command
    --   https://github.com/kreskij/Repeatable.vim
    use("kreskij/Repeatable.vim")

    -- Secure load local config files for neovim
    --   https://github.com/klen/nvim-config-local
    use({
      "klen/nvim-config-local",
      config = function()
        require("config-local").setup({})
      end,
    })

    -- Completion, Snippets, LSP {{{
    -- ------------------------------------------------------------------------------

    -- Snippet Engine for Neovim written in Lua.
    --   https://github.com/L3MON4D3/LuaSnip
    use({ "L3MON4D3/LuaSnip", config = require("0x2a.plugins.luasnip").config })

    -- Easy and high speed coding method
    --   https://github.com/mattn/vim-sonictemplate
    use({
      "mattn/vim-sonictemplate",
      config = function()
        local nvim_data_home = (os.getenv("NVIM_DATA_HOME") or vim.fn.expand("~/.local/share/nvim"))
        local template_dir = nvim_data_home .. "/templates"

        os.execute("mkdir -p " .. template_dir)

        vim.g.sonictemplate_vim_template_dir = template_dir
      end,
    })

    -- Use Neovim as a language server to inject LSP diagnostics,
    -- code actions, and more via Lua.
    --   https://github.com/jose-elias-alvarez/null-ls.nvim
    use({
      "jose-elias-alvarez/null-ls.nvim",
      config = require("0x2a.plugins.null-ls").config,
    })

    -- 🚦 A pretty diagnostics, references, telescope results,
    --    quickfix and location list to help you solve all the
    --    trouble your code is causing.
    --   https://github.com/folke/trouble.nvim
    use({
      "folke/trouble.nvim",
      cmd = { "Trouble", "TroubleClose", "TroubleToggle", "TroubleRefresh" },
      config = require("0x2a.plugins.trouble").config,
    })

    -- Neovim plugin for a code outline window
    --   https://github.com/stevearc/aerial.nvim
    use({
      "stevearc/aerial.nvim",
      requires = {
        -- Nvim Treesitter configurations and abstraction layer
        --   https://github.com/nvim-treesitter/nvim-treesitter
        "nvim-treesitter/nvim-treesitter",

        -- Quickstart configurations for the Nvim LSP client
        --   https://github.com/neovim/nvim-lspconfig
        "neovim/nvim-lspconfig",
      },
      module = "aerial",
      config = require("0x2a.plugins.aerial").config,
    })

    -- Simple winbar/statusline plugin that shows your current code context
    --   https://github.com/SmiteshP/nvim-navic
    use({
      "SmiteshP/nvim-navic",
      module = "nvim-navic",
      config = require("0x2a.plugins.nvim-navic").config,
    })

    -- Virtual text context for neovim treesitter
    --   https://github.com/haringsrob/nvim_context_vt
    use({
      "haringsrob/nvim_context_vt",
      config = require("0x2a.plugins.nvim_context_vt").config,
    })

    -- Complete whole lines from any partial therein
    --   https://github.com/dahu/vim-foist
    use({ "dahu/vim-foist", event = "InsertEnter" })

    -- A completion plugin for neovim coded in Lua.
    --   https://github.com/hrsh7th/nvim-cmp
    use({
      "hrsh7th/nvim-cmp",
      requires = {
        -- nvim-cmp source for neovim's built-in language server client
        --   https://github.com/hrsh7th/cmp-nvim-lsp
        { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },

        -- nvim-cmp source for buffer words
        --   https://github.com/hrsh7th/cmp-buffer
        { "hrsh7th/cmp-buffer", after = "nvim-cmp" },

        -- nvim-cmp source for filesystem paths
        --   https://github.com/hrsh7th/cmp-path
        { "hrsh7th/cmp-path", after = "nvim-cmp" },

        -- nvim-cmp source for neovim Lua API
        --   https://github.com/hrsh7th/cmp-nvim-lua
        { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },

        -- A source for nvim-cmp to gather candidates from Universal Ctags
        --   https://github.com/delphinus/cmp-ctags
        { "delphinus/cmp-ctags", after = "nvim-cmp" },

        -- luasnip completion source for nvim-cmp
        --   https://github.com/saadparwaiz1/cmp_luasnip
        {
          "saadparwaiz1/cmp_luasnip",
          requires = {
            -- Snippet Engine for Neovim written in Lua.
            --   https://github.com/L3MON4D3/LuaSnip
            "L3MON4D3/LuaSnip",
          },
        },

        -- nvim-cmp source for Neovim plugins
        --   https://github.com/KadoBOT/cmp-plugins
        {
          "KadoBOT/cmp-plugins",
          after = "nvim-cmp",
          config = function()
            require("cmp-plugins").setup({
              files = { "lua/0x2a/.*\\.lua$" }, -- default
            })
          end,
        },
      },

      after = "LuaSnip",
      config = require("0x2a.plugins.nvim-cmp").config,
    })

    -- Quickstart configurations for the Nvim LSP client
    --   https://github.com/neovim/nvim-lspconfig
    use({
      "neovim/nvim-lspconfig",
      event = "BufRead",
      after = "cmp-nvim-lsp",
      config = require("0x2a.plugins.lspconfig").config,
    })

    -- LSP signature hint as you type
    --   https://github.com/ray-x/lsp_signature.nvim
    use({
      "ray-x/lsp_signature.nvim",
      config = require("0x2a.plugins.lsp_signature").config,
    })

    -- lsp_lines is a simple neovim plugin that renders diagnostics
    -- using virtual lines on top of the real line of code.
    --   https://git.sr.ht/~whynothugo/lsp_lines.nvim
    use({
      "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
      after = "nvim-lspconfig",
      config = function()
        require("lsp_lines").setup()
      end,
      cond = function()
        return false
      end,
    })

    -- Standalone UI for nvim-lsp progress
    --   https://github.com/j-hui/fidget.nvim
    use({
      "j-hui/fidget.nvim",
      requires = {
        -- Quickstart configurations for the Nvim LSP client
        --   https://github.com/neovim/nvim-lspconfig
        "neovim/nvim-lspconfig",
      },

      after = "nvim-lspconfig",
      config = require("0x2a.plugins.fidget").config,
    })

    -- ------------------------------------------------------------------------------ }}}

    -- File management and manipulation {{{
    -- ------------------------------------------------------------------------------

    -- Plugin for vim to enabling opening a file in a given line
    --   https://github.com/bogado/file-line
    -- use("RobertAudi/file-line")
    use("bogado/file-line")

    -- Automatically create missing directories when saving a (new) file
    --   https://github.com/haya14busa/vim-auto-mkdir
    use({
      "haya14busa/vim-auto-mkdir",
      config = function()
        vim.g["automkdir#confirm"] = false
      end,
    })

    -- A file explorer tree for neovim written in lua
    --   https://github.com/kyazdani42/nvim-tree.lua
    use({
      "kyazdani42/nvim-tree.lua",
      keys = { "-", "g-", "gF" },
      cmd = { "NvimTreeToggle", "NvimTreeFocus" },
      config = require("0x2a.plugins.nvim-tree").config,
    })

    -- A file manager for Neovim which lets you edit your filesystem like you edit text
    --   https://github.com/elihunter173/dirbuf.nvim
    use({
      "elihunter173/dirbuf.nvim",
      cmd = { "Dirbuf", "DirbufQuit", "DirbufSync" },
      config = function()
        require("dirbuf").setup({
          hash_padding = 2,
          show_hidden = true,
          sort_order = "directories_first",
          write_cmd = "DirbufSync -confirm",
        })
      end,
    })

    -- ------------------------------------------------------------------------------ }}}

    -- An implementation of the Popup API from vim in Neovim.
    --   https://github.com/nvim-lua/popup.nvim
    use("nvim-lua/popup.nvim")

    -- 💻 Dev setup for init.lua and plugin development with full
    --    signature help, docs and completion for the nvim lua API.
    --   https://github.com/max397574/lua-dev.nvim
    use("max397574/lua-dev.nvim")

    -- Find, Filter, Preview, Pick. All lua, all the time.
    --   https://github.com/nvim-telescope/telescope.nvim
    use({
      "nvim-telescope/telescope.nvim",
      requires = {
        -- full; complete; entire; absolute; unqualified.
        -- All the lua functions I don't want to write twice.
        --   https://github.com/nvim-lua/plenary.nvim
        { "nvim-lua/plenary.nvim" },

        -- FZF sorter for telescope written in c
        --   https://github.com/nvim-telescope/telescope-fzf-native.nvim
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
      },

      setup = function()
        require("0x2a.utils.plugins").packer_lazy_load("telescope.nvim")
      end,

      config = require("0x2a.plugins.telescope").config,
    })

    -- Neovim plugin to improve the default vim.ui interfaces
    --   https://github.com/stevearc/dressing.nvim
    use({ "stevearc/dressing.nvim", config = require("0x2a.plugins.dressing").config })

    -- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
    --   https://github.com/nvim-lualine/lualine.nvim
    use({
      "nvim-lualine/lualine.nvim",
      requires = {
        -- Simple winbar/statusline plugin that shows your current code context
        --   https://github.com/SmiteshP/nvim-navic
        "SmiteshP/nvim-navic",
      },

      config = require("0x2a.plugins.lualine").config,
    })

    -- Show / hide cursorline automatically
    --   https://github.com/delphinus/vim-auto-cursorline
    use({
      "delphinus/vim-auto-cursorline",
      config = require("0x2a.plugins.vim-auto-cursorline").config,
    })

    -- Underlines the word under the cursor
    --   https://github.com/itchyny/vim-cursorword
    use({
      "itchyny/vim-cursorword",
      event = { "BufRead" },
    })

    -- Indent guides for Neovim
    --   https://github.com/lukas-reineke/indent-blankline.nvim
    use({
      "lukas-reineke/indent-blankline.nvim",
      event = "BufRead",
      config = require("0x2a.plugins.indent-blankline").config,
    })

    -- An ack.vim alternative mimics Ctrl-Shift-F on Sublime Text 2
    --   https://github.com/dyng/ctrlsf.vim
    use({ "dyng/ctrlsf.vim", config = require("0x2a.plugins.CtrlSF").config })

    -- Tame the quickfix window
    --   https://github.com/romainl/vim-qf
    use("romainl/vim-qf")

    -- Hlsearch Lens for Neovim
    --   https://github.com/kevinhwang91/nvim-hlslens
    use({
      "kevinhwang91/nvim-hlslens",
      requires = {
        -- *-Improved
        --   https://github.com/haya14busa/vim-asterisk
        "haya14busa/vim-asterisk",
      },

      config = require("0x2a.plugins.nvim-hlslens").config,
    })

    -- autopairs for neovim written by lua
    --   https://github.com/windwp/nvim-autopairs
    use({
      "windwp/nvim-autopairs",
      config = function()
        require("nvim-autopairs").setup({
          check_ts = true, -- check treesitter
          disable_in_macro = true, -- disable when recording or executing a macro
        })
      end,
    })

    -- Use treesitter to auto close and auto rename html tag
    --   https://github.com/windwp/nvim-ts-autotag
    use("windwp/nvim-ts-autotag")

    -- A Vim alignment plugin
    --   https://github.com/junegunn/vim-easy-align
    use({
      "junegunn/vim-easy-align",
      config = function()
        vim.keymap.set("v", "<Space>", "<Plug>(EasyAlign)", { noremap = true })
      end,
    })

    -- A better user experience for viewing and interacting with Vim marks.
    --   https://github.com/chentoast/marks.nvim
    use({ "chentoast/marks.nvim", config = require("0x2a.plugins.marks").config })

    -- Create temporary file for memo, testing, etc.
    --   https://github.com/RobertAudi/junkfile.nvim
    use({
      "RobertAudi/junkfile.nvim",
      cmd = {
        "JunkfileOpen",
        "JunkfileEdit",
        "JunkfileSplit",
        "JunkfileVsplit",
        "JunkfileTabEdit",
        "JunkfileWrite",
        "JunkfileSave",
        "JunkfileSplitSave",
        "JunkfileVsplitSave",
        "JunkfileTabSave",
      },

      config = function()
        require("junkfile").setup({
          directory = os.getenv("NVIM_DATA_HOME") .. "/junk",
        })
      end,
    })

    -- A simple wrapper around :mksession
    --   https://github.com/Shatur/neovim-session-manager
    use({
      "Shatur/neovim-session-manager",
      after = "plenary.nvim",
      requires = {
        -- full; complete; entire; absolute; unqualified.
        -- All the lua functions I don't want to write twice.
        --   https://github.com/nvim-lua/plenary.nvim
        "nvim-lua/plenary.nvim",
      },

      config = require("0x2a.plugins.neovim-session-manager").config,
    })

    -- Modern matchit and matchparen replacement
    --   https://github.com/andymass/vim-matchup
    use({
      "andymass/vim-matchup",
      opt = true,

      setup = function()
        require("0x2a.utils.plugins").packer_lazy_load("vim-matchup")
      end,

      config = function()
        vim.g.matchup_motion_enabled = true
        vim.g.matchup_text_obj_enabled = false
        vim.g.matchup_matchparen_deferred = true
        vim.g.matchup_matchparen_deferred_show_delay = 250
        vim.g.matchup_matchparen_deferred_hide_delay = 750
        vim.g.matchup_matchparen_status_offscreen = 0
        vim.g.matchup_matchparen_timeout = 100
        vim.g.matchup_matchparen_insert_timeout = 50

        -- Don't match anything within strings and comments
        vim.g.matchup_delim_noskips = true
      end,
    })

    -- Repeat command extended to visual mode.
    --   https://github.com/inkarkat/vim-visualrepeat
    use({
      "inkarkat/vim-visualrepeat",
      requires = {
        -- Enable repeating supported plugin maps with "."
        --   https://github.com/tpope/vim-repeat
        "tpope/vim-repeat",

        -- Vimscript library of common functions
        --   https://github.com/inkarkat/vim-ingo-library
        "inkarkat/vim-ingo-library",
      },
    })

    -- A vim plugin to yank code.
    --   https://github.com/AaronLasseigne/yank-code
    use({
      "AaronLasseigne/yank-code",
      config = function()
        -- Yank visual selection unindented
        vim.keymap.set("x", "Y", "<Plug>YankCode", { noremap = true })
      end,
    })

    -- Land on window you chose like tmux's 'display-pane'
    --   https://github.com/t9md/vim-choosewin
    use({
      "t9md/vim-choosewin",
      config = function()
        vim.g.choosewin_overlay_enable = true
        vim.g.choosewin_blink_on_land = false
        vim.g.choosewin_return_on_single_win = true

        vim.keymap.set("n", "<C-w>/", "<Plug>(choosewin)", { remap = true })
      end,
    })

    -- Simple window picker for Neovim
    --   https://codeberg.org/gbrlsnchs/winpick.nvim
    --   https://github.com/gbrlsnchs/winpick.nvim
    use({
      "https://codeberg.org/gbrlsnchs/winpick.nvim",
      config = require("0x2a.plugins.winpick").config,
    })

    -- A port of the Vim plugin vim-lastplace. It uses the same logic as vim-lastplace, but leverages the Neovim Lua API.
    -- Intelligently reopen files at your last edit position in Vim.
    --   https://github.com/vladdoster/remember.nvim
    use({
      "vladdoster/remember.nvim",
      config = function()
        require("remember").setup({
          open_folds = false,
        })
      end,
    })

    -- Vim plugin for direnv support
    --   https://github.com/direnv/direnv.vim
    use("direnv/direnv.vim")

    -- A secure alternative to Vim modelines
    --   https://github.com/RobertAudi/securemodelines
    use({ "RobertAudi/securemodelines", config = require("0x2a.plugins.securemodelines").config })

    -- Easy text manupilation for vim
    --   https://github.com/t9md/vim-textmanip
    use({
      "t9md/vim-textmanip",
      config = function()
        -- use allow key to force replace movement
        vim.keymap.set("n", "<A-Up>", "<Plug>(textmanip-move-up)", { remap = true })
        vim.keymap.set("n", "<A-Down>", "<Plug>(textmanip-move-down)", { remap = true })
        vim.keymap.set("x", "<Up>", "<Plug>(textmanip-move-up)", { remap = true })
        vim.keymap.set("x", "<Down>", "<Plug>(textmanip-move-down)", { remap = true })
        vim.keymap.set("x", "<Left>", "<Plug>(textmanip-move-left)", { remap = true })
        vim.keymap.set("x", "<Right>", "<Plug>(textmanip-move-right)", { remap = true })
      end,
    })

    -- VS Code-like renaming UI for Neovim, writen in Lua
    --   https://github.com/filipdutescu/renamer.nvim
    use({
      "filipdutescu/renamer.nvim",
      branch = "master",
      requires = {
        -- full; complete; entire; absolute; unqualified.
        -- All the lua functions I don't want to write twice.
        --   https://github.com/nvim-lua/plenary.nvim
        "nvim-lua/plenary.nvim",
      },

      config = require("0x2a.plugins.renamer").config,
    })

    -- Nvim-plugin for doing the opposite of join-line (J) of arguments, powered by treesitter
    --   https://github.com/AckslD/nvim-trevJ.lua
    use({
      "AckslD/nvim-trevJ.lua",
      config = function()
        require("trevj").setup()
      end,
    })

    -- A vim plugin that simplifies the transition between multiline and single-line code
    --   https://github.com/AndrewRadev/splitjoin.vim
    use({
      "AndrewRadev/splitjoin.vim",
      config = function()
        vim.g.splitjoin_ruby_hanging_args = false
        vim.g.splitjoin_trailing_comma = true
      end,
    })

    -- A simple Vim plugin to switch segments of text with predefined replacements
    --   https://github.com/AndrewRadev/switch.vim
    use("AndrewRadev/switch.vim")

    -- Change an HTML(ish) opening tag and take the closing one along as well
    --   https://github.com/AndrewRadev/tagalong.vim
    use("AndrewRadev/tagalong.vim")

    -- A Vim plugin to move function arguments (and other delimited-by-something items) left and right.
    --   https://github.com/AndrewRadev/sideways.vim
    use("AndrewRadev/sideways.vim")

    -- Execute a :command and show the output in a temporary buffer
    --   https://github.com/AndrewRadev/bufferize.vim
    use({
      "AndrewRadev/bufferize.vim",
      config = function()
        vim.api.nvim_create_user_command("Messages", "Bufferize messages", { nargs = 0 })

        vim.api.nvim_create_autocmd("FileType", {
          group = vim.api.nvim_create_augroup("RAPluginsBufferize", { clear = true }),
          pattern = "bufferize",
          callback = function()
            -- For some reason using vim.api.nvim_create_user_command here doesn't work
            vim.cmd([[command! -buffer Refresh execute "Bufferize " . b:bufferize_source_command]])
          end,
        })
      end,
    })

    -- A vim plugin to perform diffs on blocks of code
    --   https://github.com/AndrewRadev/linediff.vim
    use({ "AndrewRadev/linediff.vim", cmd = { "Linediff" } })

    -- A neovim lua plugin to help easily manage multiple terminal windows
    --   https://github.com/akinsho/toggleterm.nvim
    use({
      "akinsho/toggleterm.nvim",
      config = function()
        require("toggleterm").setup({})
        require("0x2a.abolish").command("ToggleTerm", "TT")

        vim.keymap.set("n", "<Leader>tt", "<Cmd>ToggleTerm<CR>", { noremap = true })
        vim.keymap.set("n", "<C-t>", "<Cmd>ToggleTerm<CR>", { noremap = true })
      end,
    })

    -- Run your tests at the speed of thought
    --   https://github.com/vim-test/vim-test
    use({ "vim-test/vim-test", after = "toggleterm.nvim" })

    -- A Neovim wrapper for running tests
    --   https://github.com/klen/nvim-test
    use({
      "klen/nvim-test",
      disable = true,
      config = function()
        require("nvim-test").setup({
          term = "toggleterm",
          runners = {
            ["rspec.ruby"] = "0x2a.plugins.nvim-test.runners.rspec",
          },
          termOpts = {
            direction = "float",
          },
        })
      end,
    })

    -- Highlights terminal color code numbers (0-255)
    --   https://github.com/sunaku/vim-hicterm
    use({ "sunaku/vim-hicterm", cmd = { "HiCterm", "HiCtermFg", "HiCtermBg" } })

    -- All 256 xterm colors with their RGB equivalents, right in Vim!
    --   https://github.com/guns/xterm-color-table.vim
    use({
      "guns/xterm-color-table.vim",
      cmd = { "XtermColorTable" },
      config = function()
        vim.g.XtermColorTableDefaultOpen = "split"
      end,
    })

    -- dircolors in your vidir session
    --   https://github.com/trapd00r/vim-syntax-vidir-ls
    use("trapd00r/vim-syntax-vidir-ls")

    -- Better whitespace highlighting for Vim
    --   https://github.com/ntpeters/vim-better-whitespace
    use({ "ntpeters/vim-better-whitespace", config = require("0x2a.plugins.vim-better-whitespace").config })

    -- Highlight insecure SSL configuration in Vim
    --   https://github.com/chr4/sslsecure.vim
    use("chr4/sslsecure.vim")

    -- Stop Unicode trolls from messing with your code.
    --   https://github.com/vim-utils/vim-troll-stopper
    use("vim-utils/vim-troll-stopper")

    -- ANSI escape sequences concealed, but highlighted as specified (conceal)
    --   https://github.com/powerman/vim-plugin-AnsiEsc
    use({
      "powerman/vim-plugin-AnsiEsc",
      config = function()
        vim.g.no_cecutil_maps = true
        vim.g.no_drchip_menu = true
        vim.g.no_ansiesc_menu = true
      end,
    })

    -- THE FASTEST NEOVIM COLORIZER
    --   https://github.com/norcalli/nvim-colorizer.lua
    use({
      "norcalli/nvim-colorizer.lua",
      cmd = { "ColorizerToggle", "ColorizerAttachToBuffer", "ColorizerDetachFromBuffer", "ColorizerReloadAllBuffers" },
      ft = { "css", "javascript", "scss", "html", "haml", "erb" },
      config = function()
        require("colorizer").setup({
          "css",
          "javascript",
          "scss",
          "html",
          "haml",
          "erb",
        })
      end,
    })

    -- Insert block quotes
    --   https://github.com/RobertAudi/BlockQuote.vim
    use({ "RobertAudi/BlockQuote.vim", cmd = { "BlockQuote", "BlockQuoteFile", "BlockUnQuote" } })

    -- Create banners
    --   https://github.com/RobertAudi/bannerizor.vim
    use({
      "RobertAudi/bannerizor.vim",
      keys = { "\\1", "\\2" },
      config = function()
        vim.keymap.set("n", "\\1", [[<Cmd>call bannerizor#titleize("=")<CR>]], { noremap = true, silent = true })
        vim.keymap.set("n", "\\2", [[<Cmd>call bannerizor#titleize("-")<CR>]], { noremap = true, silent = true })
      end,
    })

    -- A fancy, configurable, notification manager for NeoVim
    --   https://github.com/rcarriga/nvim-notify
    use({ "rcarriga/nvim-notify", config = require("0x2a.plugins.notify").config })

    -- Vim plugin for generating images of source code using Aloxaf/silicon
    --   https://github.com/segeljakt/vim-silicon
    --   https://github.com/Aloxaf/silicon
    use({
      "segeljakt/vim-silicon",
      cmd = "Silicon",
      opt = true,

      cond = function()
        return vim.fn.executable("silicon") > 0
      end,

      config = function()
        vim.g.silicon = {
          ["theme"] = "TwoDark",
          ["font"] = "JetBrains Mono",
          ["background"] = "#A8C3E1",
          ["shadow-color"] = "#555555",
          ["line-pad"] = 2,
          ["pad-horiz"] = 80,
          ["pad-vert"] = 100,
          ["shadow-blur-radius"] = 0,
          ["shadow-offset-x"] = 0,
          ["shadow-offset-y"] = 0,
          ["line-number"] = true,
          ["round-corner"] = true,
          ["window-controls"] = true,
          ["default-file-pattern"] = "~/Pictures/Screenshots/silicon-{time:%Y-%m-%d-%H%M%S}.png",
        }
      end,
    })

    -- Fix CursorHold Performance.
    --   https://github.com/antoinemadec/FixCursorHold.nvim
    use("antoinemadec/FixCursorHold.nvim")

    -- Translating plugin for Vim/Neovim
    --   https://github.com/voldikss/vim-translator
    use({ "voldikss/vim-translator", disable = true })

    -- 🔎 Neovim plugin for viewing all the URLs in a buffer
    --   https://github.com/axieax/urlview.nvim
    use({ "axieax/urlview.nvim", config = require("0x2a.plugins.urlview").config })

    -- Neovim plugin to stabilize window open/close events.
    --   https://github.com/luukvbaal/stabilize.nvim
    use({
      "luukvbaal/stabilize.nvim",
      config = function()
        require("stabilize").setup({
          force = true, -- stabilize window even when current cursor position will be hidden behind new window
          forcemark = nil, -- set context mark to register on force event which can be jumped to with '<forcemark>
          ignore = { -- do not manage windows matching these file/buftypes
            filetype = { "help", "list", "Trouble" },
            buftype = { "terminal", "quickfix", "loclist" },
          },
          nested = "QuickFixCmdPost,DiagnosticChanged *", -- comma-separated list of autocmds that wil trigger the plugins window restore function
        })
      end,
    })

    -- Peek lines just when you intend
    --   https://github.com/nacro90/numb.nvim
    use({
      "nacro90/numb.nvim",
      config = function()
        require("numb").setup({
          show_numbers = true, -- Enable 'number' for the window while peeking
          show_cursorline = true, -- Enable 'cursorline' for the window while peeking
          number_only = true, -- Peek only when the command is only a number instead of when it starts with a number
          centered_peeking = true, -- Peeked line will be centered relative to window
        })
      end,
    })

    -- Always have a nice view for vim split windows!
    --   https://github.com/RobertAudi/GoldenView.vim
    use({ "RobertAudi/GoldenView.vim", config = require("0x2a.plugins.GoldenView").config })

    -- Key mapping hints in a floating window
    --   https://github.com/linty-org/key-menu.nvim
    use({
      "linty-org/key-menu.nvim",
      config = function()
        require("key-menu").set("n", "<Leader>", { noremap = true })
        require("key-menu").set("n", "<LocalLeader>", { noremap = true })
      end,
    })

    -- Readline motions and deletions in Neovim
    --   https://github.com/linty-org/readline.nvim
    use({
      "linty-org/readline.nvim",
      config = function()
        local readline = require("readline")

        vim.keymap.set("c", "<M-f>", readline.forward_word, { noremap = true })
        vim.keymap.set("c", "<M-b>", readline.backward_word, { noremap = true })
        vim.keymap.set("c", "<C-a>", readline.beginning_of_line, { noremap = true })
        vim.keymap.set("c", "<C-e>", readline.end_of_line, { noremap = true })
        vim.keymap.set("c", "<M-d>", readline.kill_word, { noremap = true })
        vim.keymap.set("c", "<C-w>", readline.backward_kill_word, { noremap = true })
        vim.keymap.set("c", "<M-BS>", readline.backward_kill_word, { noremap = true })
        vim.keymap.set("c", "<C-k>", readline.kill_line, { noremap = true })
        vim.keymap.set("c", "<C-u>", readline.backward_kill_line, { noremap = true })
      end,
    })

    -- Enhanced increment/decrement plugin for Neovim
    --   https://github.com/monaqa/dial.nvim
    use({
      "monaqa/dial.nvim",
      opt = true,
      setup = function()
        require("0x2a.utils.plugins").packer_lazy_load("dial.nvim")
      end,

      config = require("0x2a.plugins.dial").config,
    })

    -- ✨ Clarify and beautify your comments using boxes and lines.
    --   https://github.com/LudoPinelli/comment-box.nvim
    use({ "LudoPinelli/comment-box.nvim", config = require("0x2a.plugins.comment-box").config })

    -- Sorting plugin for Neovim that supports line-wise and delimiter sorting.
    --   https://github.com/sQVe/sort.nvim
    use({
      "sQVe/sort.nvim",
      cmd = "Sort",
      config = function()
        require("sort").setup({})
      end,
    })

    -- Bind a bunch of key bindings together.
    -- Create custom submodes
    --   https://github.com/anuvyklack/hydra.nvim
    use({
      "anuvyklack/hydra.nvim",
      opt = true,
      requires = {
        -- Create a key layer in Neovim
        --   https://github.com/anuvyklack/keymap-layer.nvim
        "anuvyklack/keymap-layer.nvim",
      },

      setup = function()
        require("0x2a.utils.plugins").packer_lazy_load("hydra.nvim")
      end,

      config = require("0x2a.plugins.hydra").config,
    })

    -- Magit for Neovim
    -- Complete text-based user interface to Git
    --   https://github.com/TimUntersberger/neogit
    use({
      "TimUntersberger/neogit",
      requires = {
        {
          -- full; complete; entire; absolute; unqualified.
          -- All the lua functions I don't want to write twice.
          --   https://github.com/nvim-lua/plenary.nvim
          "nvim-lua/plenary.nvim",
        },
      },

      module = "neogit",
      command = "Neogit",

      setup = function()
        require("0x2a.utils.plugins").packer_lazy_load("neogit")
      end,

      config = require("0x2a.plugins.neogit").config,
    })

    use({
      "xbase-lab/xbase",
      run = "make install",
      requires = {
        -- full; complete; entire; absolute; unqualified.
        -- All the lua functions I don't want to write twice.
        --   https://github.com/nvim-lua/plenary.nvim
        "nvim-lua/plenary.nvim",

        -- Find, Filter, Preview, Pick. All lua, all the time.
        --   https://github.com/nvim-telescope/telescope.nvim
        "nvim-telescope/telescope.nvim",

        -- Quickstart configurations for the Nvim LSP client
        --   https://github.com/neovim/nvim-lspconfig
        "neovim/nvim-lspconfig",
      },
      config = function()
        require("xbase").setup({
          mappings = {
            enable = true,
          },
        })
      end,
    })
  end,

  config = {
    ensure_dependencies = true,
    compile_on_sync = true,

    max_jobs = 50,
    auto_clean = true,
    autoremove = true,

    git = {
      clone_timeout = 20,
    },

    display = {
      open_cmd = "80vnew \\[packer\\]",
      working_sym = symbols.packer.working,
      error_sym = symbols.packer.error,
      done_sym = symbols.packer.done,
      removed_sym = symbols.packer.removed,
      moved_sym = symbols.packer.moved,
      header_sym = symbols.packer.header,
    },

    profile = {
      enable = false,
      threshold = 1,
    },
  },
})
