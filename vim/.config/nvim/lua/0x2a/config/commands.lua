-- Buffers {{{
-- ------------------------------------------------------------------------------

vim.api.nvim_create_user_command("YankBuffer", "silent! call x2a#utils#Preserve('x2a#buffers#Yank')", { nargs = 0 })

vim.api.nvim_create_user_command("BufOnly", "call x2a#buffers#BufOnly(<bang>0)", { nargs = 0, bang = true })
vim.api.nvim_create_user_command(
  "BufDeleteInactive",
  "call x2a#buffers#BufDeleteInactive(<bang>0)",
  { nargs = 0, bang = true }
)
vim.api.nvim_create_user_command("BufDeleteAll", "call x2a#buffers#BufDeleteAll(<bang>0)", { nargs = 0, bang = true })

-- ------------------------------------------------------------------------------ }}}

-- Files {{{
-- ------------------------------------------------------------------------------

-- Copy (to the system clipboard) the path to current file
vim.api.nvim_create_user_command("CopyFilePath", "call x2a#file#CopyRelativePath()", { nargs = 0 })
vim.api.nvim_create_user_command("CopyFullFilePath", "call x2a#file#CopyFullPath()", { nargs = 0 })
vim.api.nvim_create_user_command("CopyRelativeFilePath", "call x2a#file#CopyRelativePath()", { nargs = 0 })
vim.api.nvim_create_user_command(
  "CopyRelativeFilePathWithLineNumber",
  "call x2a#file#CopyRelativePathWithLineNumber()",
  { nargs = 0 }
)

vim.api.nvim_create_user_command("Chmod", "call x2a#file#Chmod(<bang>0, <f-args>)", { bang = true, nargs = "+" })

vim.api.nvim_create_user_command(
  "Rename",
  "call x2a#file#Rename(<f-args>, <bang>0)",
  { bang = true, nargs = 1, complete = "custom,x2a#file#Rename#complete" }
)

vim.api.nvim_create_user_command("Delete", "call x2a#file#Delete(<q-bang>, v:false)", { bang = true, nargs = 0 })
vim.api.nvim_create_user_command("Remove", "call x2a#file#Delete(<q-bang>, v:true)", { bang = true, nargs = 0 })

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
vim.api.nvim_create_user_command(
  "SetFiletype",
  "call x2a#filetypes#SetFileType(<bang>0, <f-args>)",
  { bang = true, complete = "filetype", nargs = 1 }
)

vim.api.nvim_create_user_command("ReloadFiletype", "call x2a#filetypes#ReloadFiletype()", { nargs = 0 })

-- ------------------------------------------------------------------------------ }}}

-- macOS {{{
-- ------------------------------------------------------------------------------

if require("0x2a.utils").is_mac() then
  vim.api.nvim_create_user_command("RevealInFinder", "call x2a#macos#RevealInFinder(expand('%:p'))", { nargs = 0 })

  if require("0x2a.utils.files").is_executable("mate") then
    vim.api.nvim_create_user_command(
      "TextMate",
      "silent! call x2a#TextMate#Open(<f-args>)",
      { nargs = "?", complete = "file" }
    )
  end
end

-- ------------------------------------------------------------------------------ }}}

vim.api.nvim_create_user_command("GG", "silent !git gui", { nargs = 0 })

vim.api.nvim_create_user_command(
  "NormalizeWhitespace",
  "call x2a#utils#Preserve('x2a#utils#UnfuckWhitespace')",
  { nargs = 0 }
)

vim.api.nvim_create_user_command("WhatSyntax", "call x2a#utils#WhatSyntax()", { nargs = 0 })
vim.api.nvim_create_user_command("Scratch", "call x2a#utils#scratch()", { nargs = 0 })

-- Author: Andrew Radev
-- URL: https://github.com/AndrewRadev/Vimfiles
-- Source: https://github.com/AndrewRadev/Vimfiles/blob/b02e9ed925c9eeecc4629ac1cc8b235d432f64f6/startup/commands.vim#L152
vim.api.nvim_create_user_command("Redraw", "call x2a#utils#Redraw()", { nargs = 0 })

-- Unfuck my screen
-- Source: https://bitbucket.org/sjl/dotfiles/src/26d3b19a08938930b576cedb18bc6fca706be6c5/vim/vimrc#vimrc-443
vim.api.nvim_create_user_command("UnfuckScreen", "syntax sync fromstart | :redraw!", { nargs = 0 })

-- Clear messages
-- Source: https://github.com/koturn/vim-config/blob/b88f05f6bdf230dd3250451fc6eea4b7a6c4bd3a/.vimrc#L655
vim.api.nvim_create_user_command("ClearMessages", "messages clear", { nargs = 0, bar = true })
