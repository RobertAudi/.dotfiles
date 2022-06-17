-- Module: 0x2a.plugins.crates.nvim
-- Plugin: Saecki/crates.nvim
-- Description: A neovim plugin that helps managing crates.io dependencies
-- URL: https://github.com/Saecki/crates.nvim

local M = {}

M.config = function()
  require("crates").setup({
    smart_insert = true,
    insert_closing_quote = true,
    avoid_prerelease = true,
    autoload = true,
    autoupdate = true,
    loading_indicator = true,
    date_format = "%Y-%m-%d",
    notification_title = "Crates",
    disable_invalid_feature_diagnostic = false,

    text = {
      loading = "   Loading",
      version = "   %s",
      prerelease = "   %s",
      yanked = "   %s",
      nomatch = "   No match",
      upgrade = "   %s",
      error = "   Error fetching crate",
    },

    highlight = {
      loading = "CratesNvimLoading",
      version = "CratesNvimVersion",
      prerelease = "CratesNvimPreRelease",
      yanked = "CratesNvimYanked",
      nomatch = "CratesNvimNoMatch",
      upgrade = "CratesNvimUpgrade",
      error = "CratesNvimError",
    },

    popup = {
      autofocus = false,
      copy_register = "\"",
      style = "minimal",
      border = "none",
      show_version_date = false,
      show_dependency_version = true,
      max_height = 30,
      min_width = 20,
      padding = 1,

      text = {
        title = " %s",
        pill_left = "",
        pill_right = "",
        description = "%s",
        created_label = " created        ",
        created = "%s",
        updated_label = " updated        ",
        updated = "%s",
        downloads_label = " downloads      ",
        downloads = "%s",
        homepage_label = " homepage       ",
        homepage = "%s",
        repository_label = " repository     ",
        repository = "%s",
        documentation_label = " documentation  ",
        documentation = "%s",
        crates_io_label = " crates.io      ",
        crates_io = "%s",
        categories_label = " categories     ",
        keywords_label = " keywords       ",
        version = "  %s",
        prerelease = " %s",
        yanked = " %s",
        version_date = "  %s",
        feature = "  %s",
        enabled = " %s",
        transitive = " %s",
        dependency = "  %s",
        optional = " %s",
        dependency_version = "  %s",
        loading = " ",
      },

      highlight = {
        title = "CratesNvimPopupTitle",
        pill_text = "CratesNvimPopupPillText",
        pill_border = "CratesNvimPopupPillBorder",
        description = "CratesNvimPopupDescription",
        created_label = "CratesNvimPopupLabel",
        created = "CratesNvimPopupValue",
        updated_label = "CratesNvimPopupLabel",
        updated = "CratesNvimPopupValue",
        downloads_label = "CratesNvimPopupLabel",
        downloads = "CratesNvimPopupValue",
        homepage_label = "CratesNvimPopupLabel",
        homepage = "CratesNvimPopupUrl",
        repository_label = "CratesNvimPopupLabel",
        repository = "CratesNvimPopupUrl",
        documentation_label = "CratesNvimPopupLabel",
        documentation = "CratesNvimPopupUrl",
        crates_io_label = "CratesNvimPopupLabel",
        crates_io = "CratesNvimPopupUrl",
        categories_label = "CratesNvimPopupLabel",
        keywords_label = "CratesNvimPopupLabel",
        version = "CratesNvimPopupVersion",
        prerelease = "CratesNvimPopupPreRelease",
        yanked = "CratesNvimPopupYanked",
        version_date = "CratesNvimPopupVersionDate",
        feature = "CratesNvimPopupFeature",
        enabled = "CratesNvimPopupEnabled",
        transitive = "CratesNvimPopupTransitive",
        dependency = "CratesNvimPopupDependency",
        optional = "CratesNvimPopupOptional",
        dependency_version = "CratesNvimPopupDependencyVersion",
        loading = "CratesNvimPopupLoading",
      },

      keys = {
        hide = { "q", "<Esc>" },
        open_url = { "<CR>" },
        select = { "<CR>" },
        select_alt = { "s" },
        toggle_feature = { "<CR>" },
        copy_value = { "yy" },
        goto_item = { "gd", "K", "<C-LeftMouse>" },
        jump_forward = { "<C-i>" },
        jump_back = { "<C-o>", "<C-RightMouse>" },
      },
    },

    src = {
      insert_closing_quote = true,

      text = {
        prerelease = "  pre-release ",
        yanked = "  yanked ",
      },
    },
  })
end

return M
