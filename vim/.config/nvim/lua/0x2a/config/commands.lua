-- Module: 0x2a.config.commands
-- Requires:
--   - 0x2a.utils
--   - 0x2a.utils.fs

-- Buffers {{{
-- ------------------------------------------------------------------------------

vim.api.nvim_create_user_command(
  "BufDeleteInactive",
  "call x2a#buffers#BufDeleteInactive(<bang>0)",
  { nargs = 0, bang = true }
)

vim.api.nvim_create_user_command("BufDeleteAll", function(args)
  require("0x2a.utils.buffer").close_all({ force = args.bang })
end, { nargs = 0, bang = true, desc = "Delete all buffers" })

vim.api.nvim_create_user_command("BufDelete", function(args)
  require("0x2a.utils.buffer").close({ buffer = args.args, force = args.bang })
end, {
  nargs = "?",
  bang = true,
  complete = "buffer",
  desc = "Delete a buffer and preserve the window layout",
})

vim.api.nvim_create_user_command("BufWipeout", function(args)
  require("0x2a.utils.buffer").close({ buffer = args.args, wipeout = true, force = args.bang })
end, {
  nargs = "?",
  bang = true,
  complete = "buffer",
  desc = "Wipeout a buffer and preserve the window layout",
})

vim.api.nvim_create_user_command("BufOnly", function(args)
  require("0x2a.utils.buffer").close_all({ except = vim.api.nvim_get_current_buf(), force = args.bang })
end, { nargs = 0, bang = true, desc = "Delete all buffers except the current one" })

-- Source: https://github.com/gametaro/dotfiles/blob/2ea8d00111ddaea1e02d25eeb28e1a57816154f5/home/dot_config/nvim/plugin/command.lua
vim.api.nvim_create_user_command("FloatWinCloseAll", function()
  local wins = vim.api.nvim_list_wins()

  for _, win in ipairs(wins) do
    if vim.api.nvim_win_get_config(win).relative ~= "" then
      vim.api.nvim_win_close(win, true)
    end
  end
end, { nargs = 0 })

-- ------------------------------------------------------------------------------ }}}

-- Files {{{
-- ------------------------------------------------------------------------------

vim.api.nvim_create_user_command(
  "CopyFullFilePath",
  function()
    require("0x2a.utils.fs").copy_absolute_file_path()
  end,
  { nargs = 0, desc = "Copy the full path to the current file" }
)

vim.api.nvim_create_user_command(
  "CopyRelativeFilePath",
  function()
    require("0x2a.utils.fs").copy_relative_file_path()
  end,
  { nargs = 0, desc = "Copy the relative path to the current file (relative to $PWD)" }
)

vim.api.nvim_create_user_command(
  "CopyRelativeFilePathWithLineNumber",
  "call x2a#file#CopyRelativePathWithLineNumber()",
  { nargs = 0, desc = "Copy the relative path to the current file with line number(s)" }
)

vim.api.nvim_create_user_command(
  "Chmod",
  "call x2a#file#Chmod(<bang>0, <f-args>)",
  { bang = true, nargs = "+", desc = "Change the permissions of the current file" }
)

vim.api.nvim_create_user_command(
  "Rename",
  "call x2a#file#Rename(<f-args>, <bang>0)",
  { bang = true, nargs = 1, complete = "custom,x2a#file#Rename#complete", desc = "Rename the current file" }
)

vim.api.nvim_create_user_command("Delete", function(args)
  require("0x2a.utils.buffer").delete_active_file({ keep_layout = false, force = args.bang })
end, { bang = true, nargs = 0, desc = "Delete a file and its buffer" })

vim.api.nvim_create_user_command("Remove", function(args)
  require("0x2a.utils.buffer").delete_active_file({ keep_layout = true, force = args.bang })
end, { bang = true, nargs = 0, desc = "Delete a file and its buffer while preserving the windows layout" })

-- ------------------------------------------------------------------------------ }}}

-- Help {{{
-- ------------------------------------------------------------------------------

vim.api.nvim_create_user_command(
  "Help",
  "call x2a#help#alternate(<bang>0, <f-args>)",
  { nargs = "?", bang = true, complete = "help" }
)

-- ------------------------------------------------------------------------------ }}}

-- Filetype {{{
-- ------------------------------------------------------------------------------

-- Change the filetype of the current buffer
vim.api.nvim_create_user_command("SetFiletype", function(args)
  require("0x2a.utils.filetype").set(args.args, args.bang)
end, { bang = true, complete = "filetype", nargs = 1 })

vim.api.nvim_create_user_command("ReloadFiletype", function()
  require("0x2a.utils.filetype").reload()
end, { nargs = 0 })

-- ------------------------------------------------------------------------------ }}}

-- macOS {{{
-- ------------------------------------------------------------------------------

if require("0x2a.utils").is_mac() then
  vim.api.nvim_create_user_command(
    "RevealInFinder",
    "silent! call system('open -R ' . shellescape(expand('%:p')) . '')",
    { nargs = 0, desc = "Reveal a file in the Finder" }
  )

  vim.api.nvim_create_user_command(
    "QuickLook",
    "silent! call system('qlmanage -p ' . shellescape(expand('%:p')) . '')",
    { nargs = 0, desc = "Preview file in QuickLook" }
  )

  if require("0x2a.utils.fs").is_executable("mate") then
    vim.api.nvim_create_user_command(
      "TextMate",
      "silent! call x2a#TextMate#Open(<f-args>)",
      { nargs = "?", complete = "file", desc = "Open a file in TextMate" }
    )
  end
end

-- ------------------------------------------------------------------------------ }}}

vim.api.nvim_create_user_command("GG", "silent !git gui", { nargs = 0, desc = "Open the Git GUI client" })

vim.api.nvim_create_user_command(
  "NormalizeWhitespace",
  "call x2a#utils#Preserve('x2a#utils#UnfuckWhitespace')",
  { nargs = 0 }
)

vim.api.nvim_create_user_command(
  "WhatSyntax",
  "call x2a#utils#WhatSyntax()",
  { nargs = 0, desc = "Show highlight groups under cursor" }
)

vim.api.nvim_create_user_command("Scratch", "call x2a#utils#scratch()", { nargs = 0, desc = "Open a scratch buffer" })

-- Author: Andrew Radev
-- URL: https://github.com/AndrewRadev/Vimfiles
-- Source: https://github.com/AndrewRadev/Vimfiles/blob/b02e9ed925c9eeecc4629ac1cc8b235d432f64f6/startup/commands.vim#L152
vim.api.nvim_create_user_command("Redraw", "call x2a#utils#Redraw()", { nargs = 0 })

-- Unfuck my screen
-- Source: https://bitbucket.org/sjl/dotfiles/src/26d3b19a08938930b576cedb18bc6fca706be6c5/vim/vimrc#vimrc-443
vim.api.nvim_create_user_command("UnfuckScreen", "syntax sync fromstart | :redraw!", { nargs = 0 })

-- Clear messages
-- Source: https://github.com/koturn/vim-config/blob/b88f05f6bdf230dd3250451fc6eea4b7a6c4bd3a/.vimrc#L655
vim.api.nvim_create_user_command("ClearMessages", "messages clear", { nargs = 0, bar = true, desc = "Clear messages" })
