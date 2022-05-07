-- Module: 0x2a.plugins.plugins
-- Requires:
--   - 0x2a.symbols
--   - 0x2a.utils
--   - 0x2a.utils.files
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

    -- Neovim plugin for building a sync base16 colorscheme.
    -- Includes support for Treesitter and LSP highlight groups.
    --   https://github.com/RRethy/nvim-base16
    use({ "RRethy/nvim-base16", after = "packer.nvim", disable = true })

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
        if require("0x2a.utils.files").is_executable("sqlfmt") then
          vim.g.sqlfmt_command = "sqlfmt"
          vim.g.sqlfmt_options = ""
        elseif require("0x2a.utils.files").is_executable("sqlformat") then
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
        vim.keymap.set("n", "<C-g>", "<Cmd>call x2a#gitbranch#ctrl_g(v:count)<CR>")
      end,
    })

    -- Git integration for buffers
    --   https://github.com/lewis6991/gitsigns.nvim
    use({
      "lewis6991/gitsigns.nvim",
      opt = true,

      setup = function()
        require("0x2a.utils").packer_lazy_load("gitsigns.nvim")
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
        return vim.fn.expand("%:t", false, false) == "COMMIT_EDITMSG"
      end,
    })

    -- A plugin to run `git blame` on the current buffer.
    --   https://github.com/RobertAudi/git-blame.vim
    use({
      "RobertAudi/git-blame.vim",
      cmd = "GBlame",
      config = function()
        vim.g.gitblame_mappings = { previewCommit = "<CR>", close = "q" }

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
    use("christoomey/vim-tmux-navigator")

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
      },

      config = require("0x2a.plugins.nvim-treesitter").config,
    })

    -- Quoting/parenthesizing made simple
    --   https://github.com/tpope/vim-surround
    use("tpope/vim-surround")

    -- Smart and powerful comment plugin for neovim.
    --   https://github.com/numToStr/Comment.nvim
    use({
      "numToStr/Comment.nvim",
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

    -- Changes Vim working directory to project root
    -- (identified by presence of known directory or file).
    --   https://github.com/airblade/vim-rooter
    use({
      "airblade/vim-rooter",
      config = function()
        -- Stop vim-rooter changing directory automatically
        vim.g.rooter_manual_only = 1
      end,
    })

    -- KISS local vimrc with hash protection
    --   https://github.com/RobertAudi/local-vimrc
    use("RobertAudi/local-vimrc")

    -- Completion, Snippets, LSP {{{
    -- ------------------------------------------------------------------------------

    -- Snippet Engine for Neovim written in Lua.
    --   https://github.com/L3MON4D3/LuaSnip
    use({ "L3MON4D3/LuaSnip", config = require("0x2a.plugins.luasnip").config })

    -- Use Neovim as a language server to inject LSP diagnostics,
    -- code actions, and more via Lua.
    --   https://github.com/jose-elias-alvarez/null-ls.nvim
    use({ "jose-elias-alvarez/null-ls.nvim", config = require("0x2a.plugins.null-ls").config })

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
      requires = { "nvim-treesitter/nvim-treesitter", "neovim/nvim-lspconfig" },
      module = "aerial",
      config = require("0x2a.plugins.aerial").config,
    })

    -- Simple statusline component that shows what scope you are working inside
    --   https://github.com/SmiteshP/nvim-gps
    use({
      "SmiteshP/nvim-gps",
      requires = "nvim-treesitter/nvim-treesitter",
      module = "nvim-gps",
      config = require("0x2a.plugins.nvim-gps").config,
    })

    -- Complete whole lines from any partial therein
    --   https://github.com/dahu/vim-foist
    use({ "dahu/vim-foist", event = "InsertEnter" })

    -- A completion plugin for neovim coded in Lua.
    --   https://github.com/hrsh7th/nvim-cmp
    use({
      "hrsh7th/nvim-cmp",
      requires = {
        { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
        { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
        { "hrsh7th/cmp-path", after = "nvim-cmp" },
        { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
        { "quangnguyen30192/cmp-nvim-tags", after = "nvim-cmp" },
        { "saadparwaiz1/cmp_luasnip", requires = { "L3MON4D3/LuaSnip" } },
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

    -- Standalone UI for nvim-lsp progress
    --   https://github.com/j-hui/fidget.nvim
    use({
      "j-hui/fidget.nvim",
      requires = "neovim/nvim-lspconfig",
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

    -- Improved Yank and Put functionalities for Neovim
    --   https://github.com/gbprod/yanky.nvim
    use({ "gbprod/yanky.nvim", config = require("0x2a.plugins.yanky").config })

    -- Find, Filter, Preview, Pick. All lua, all the time.
    --   https://github.com/nvim-telescope/telescope.nvim
    use({
      "nvim-telescope/telescope.nvim",
      requires = {
        { "nvim-lua/plenary.nvim" },
        {
          -- FZF sorter for telescope written in c
          --   https://github.com/nvim-telescope/telescope-fzf-native.nvim
          "nvim-telescope/telescope-fzf-native.nvim",
          run = "make",
        },
        { "nvim-telescope/telescope-ui-select.nvim" },
      },
      keys = { "<C-p>", "<C-b>", "<C-Space>", "<C-y>" },
      config = require("0x2a.plugins.telescope").config,
    })

    -- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
    --   https://github.com/nvim-lualine/lualine.nvim
    use({
      "nvim-lualine/lualine.nvim",
      requires = { "SmiteshP/nvim-gps" },
      config = require("0x2a.plugins.lualine").config,
    })

    -- Show / hide cursorline automatically
    --   https://github.com/delphinus/vim-auto-cursorline
    use({ "delphinus/vim-auto-cursorline", config = require("0x2a.plugins.vim-auto-cursorline").config })

    -- Underlines the word under the cursor
    --   https://github.com/itchyny/vim-cursorword
    use({ "itchyny/vim-cursorword", event = { "BufRead" } })

    -- Indent guides for Neovim
    --   https://github.com/lukas-reineke/indent-blankline.nvim
    use({
      "lukas-reineke/indent-blankline.nvim",
      event = "BufRead",
      config = require("0x2a.plugins.indent-blankline").config,
    })

    -- Auto-Focusing and Auto-Resizing Splits/Windows
    --   https://github.com/beauwilliams/focus.nvim
    use({ "beauwilliams/focus.nvim", config = require("0x2a.plugins.focus").config })

    -- An ack.vim alternative mimics Ctrl-Shift-F on Sublime Text 2
    --   https://github.com/dyng/ctrlsf.vim
    use({ "dyng/ctrlsf.vim", config = require("0x2a.plugins.CtrlSF").config })

    -- Tame the quickfix window
    --   https://github.com/romainl/vim-qf
    use("romainl/vim-qf")

    -- Hlsearch Lens for Neovim
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
        require("nvim-autopairs").setup({})
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
        vim.keymap.set("v", "<Space>", "<Plug>(EasyAlign)")
      end,
    })

    -- A better user experience for viewing and interacting with Vim marks.
    --   https://github.com/chentau/marks.nvim
    use({ "chentau/marks.nvim", config = require("0x2a.plugins.marks").config })

    -- Create temporary file for memo, testing, etc.
    --   https://github.com/RobertAudi/junkfile.vim
    use({
      "RobertAudi/junkfile.vim",
      cmd = {
        "JunkfileOpen",
        "JunkfileEdit",
        "JunkfileSplit",
        "JunkfileVsplit",
        "JunkfileTabEdit",
        "JunkfileSave",
        "JunkfileSplitSave",
        "JunkfileVsplitSave",
        "JunkfileTabSave",
      },
      config = function()
        vim.g["junkfile#directory"] = os.getenv("NVIM_DATA_HOME") .. "/junk"
      end,
    })

    -- A neovim plugin to run lines/blocs of code (independently of the
    -- rest of the file), supporting multiples languages
    --   https://github.com/michaelb/sniprun
    use({ "michaelb/sniprun", run = "bash install.sh" })

    -- A simple wrapper around :mksession
    --   https://github.com/Shatur/neovim-session-manager
    use({
      "Shatur/neovim-session-manager",
      after = "plenary.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = require("0x2a.plugins.neovim-session-manager").config,
    })

    -- Modern matchit and matchparen replacement
    --   https://github.com/andymass/vim-matchup
    use({
      "andymass/vim-matchup",
      opt = true,
      setup = function()
        require("0x2a.utils").packer_lazy_load("vim-matchup")
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

        vim.api.nvim_create_autocmd("ColorScheme", {
          group = vim.api.nvim_create_augroup("RAPluginsMatchup", { clear = true }),
          pattern = "*",
          callback = function()
            vim.cmd(
              "highlight MatchParen term=underline cterm=underline ctermfg=196 ctermbg=NONE gui=underline guifg=#ff4500 guibg=NONE"
            )
          end,
        })
      end,
    })

    -- Make blockwise Visual mode more useful
    --   https://github.com/kana/vim-niceblock
    use("kana/vim-niceblock")

    -- Enhanced jump and change list navigation commands.
    --   https://github.com/inkarkat/vim-EnhancedJumps
    use({ "inkarkat/vim-EnhancedJumps", requires = { "inkarkat/vim-ingo-library" } })

    -- Repeat command extended to visual mode.
    --   https://github.com/inkarkat/vim-visualrepeat
    use({ "inkarkat/vim-visualrepeat", requires = { "tpope/vim-repeat", "inkarkat/vim-ingo-library" } })

    -- Preserve missing EOL at the end of text files.
    --   https://github.com/inkarkat/vim-PreserveNoEOL
    use({ "inkarkat/vim-PreserveNoEOL", requires = { "inkarkat/vim-ingo-library" } })

    -- A vim plugin to yank code.
    --   https://github.com/AaronLasseigne/yank-code
    use({
      "AaronLasseigne/yank-code",
      config = function()
        -- Yank visual selection unindented
        vim.keymap.set("x", "Y", "<Plug>YankCode")
      end,
    })

    -- Simple plugin to zoom windows
    --   https://github.com/RobertAudi/ZoomWinTab
    use({
      "RobertAudi/ZoomWinTab",
      keys = { "\\\\" },
      config = function()
        vim.g.ZoomWinTabHideTabBar = false

        vim.keymap.set("n", "\\\\", [[<Cmd>silent! ZoomWinTabToggle<CR>]], { silent = true })
      end,
    })

    -- Delete buffers and close files in Vim without closing your windows or messing up your layout.
    --   https://github.com/RobertAudi/vim-bbye
    use("RobertAudi/vim-bbye")

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

    -- Intelligently reopen files at your last edit position in Vim.
    --   https://github.com/farmergreg/vim-lastplace
    use({
      "farmergreg/vim-lastplace",
      config = function()
        vim.g.lastplace_open_folds = false
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
        vim.keymap.set("x", "<Up>", "<Plug>(textmanip-move-up)", { remap = true })
        vim.keymap.set("x", "<Down>", "<Plug>(textmanip-move-down)", { remap = true })
        vim.keymap.set("x", "<Left>", "<Plug>(textmanip-move-left)", { remap = true })
        vim.keymap.set("x", "<Right>", "<Plug>(textmanip-move-right)", { remap = true })
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

        vim.keymap.set("n", "<Leader>tt", "<Cmd>ToggleTerm<CR>")
      end,
    })

    -- Run your tests at the speed of thought
    --   https://github.com/vim-test/vim-test
    use({ "vim-test/vim-test", after = "toggleterm.nvim" })

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

    -- Quickly highlight <cword> or visually selected word
    --   https://github.com/t9md/vim-quickhl
    use("t9md/vim-quickhl")

    -- Highlight insecure SSL configuration in Vim
    --   https://github.com/chr4/sslsecure.vim
    use("chr4/sslsecure.vim")

    -- Stop Unicode trolls from messing with your code.
    --   https://github.com/vim-utils/vim-troll-stopper
    use("vim-utils/vim-troll-stopper")

    -- Open URI with your favorite browser from your most favorite editor
    --   https://github.com/tyru/open-browser.vim
    use({
      "tyru/open-browser.vim",
      requires = {
        -- Open GitHub URL of current file, etc. from Vim editor
        --   https://github.com/tyru/open-browser-github.vim
        { "tyru/open-browser-github.vim", after = "open-browser.vim" },

        -- Open fileformat.info page about character on current cursor / given character
        --   https://github.com/tyru/open-browser-unicode.vim
        { "tyru/open-browser-unicode.vim", after = "open-browser.vim" },
      },
      config = function()
        vim.keymap.set({ "n", "x" }, "<Leader>o", "<Plug>(openbrowser-smart-search)", { remap = true })
      end,
    })

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
        vim.keymap.set("n", "\\1", [[<Cmd>call bannerizor#titleize("=")<CR>]], { silent = true })
        vim.keymap.set("n", "\\2", [[<Cmd>call bannerizor#titleize("-")<CR>]], { silent = true })
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
    })

    -- Fix CursorHold Performance.
    --   https://github.com/antoinemadec/FixCursorHold.nvim
    use("antoinemadec/FixCursorHold.nvim")

    -- Translating plugin for Vim/Neovim
    --   https://github.com/voldikss/vim-translator
    use({ "voldikss/vim-translator", disable = true })
  end,

  config = {
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
