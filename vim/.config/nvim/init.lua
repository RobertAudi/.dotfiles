pcall(require, "impatient")

require("0x2a.globals")

-- stylua: ignore start
vim.api.nvim_exec([[
  if exists('$FZF_HOME')
    " A command-line fuzzy finder
    "   https://github.com/junegunn/fzf
    set runtimepath+=$FZF_HOME
  elseif isdirectory(fnamemodify('~/.local/opt/fzf', ':p'))
    let s:__fzf_home__ = fnamemodify('~/.local/opt/fzf', ':p')
    set runtimepath+=s:__fzf_home__
    unlet s:__fzf_home__
  endif
]], true)
-- stylua: ignore end

vim.cmd("packadd packer.nvim")

require("0x2a.plugins")
require("0x2a.config.options")

vim.g.foldutilFoldText = "AwesomeFoldText#foldtext()"

-- Easy shebang
vim.cmd("iabbrev #! #!/usr/bin/env")

require("0x2a.colors")
require("0x2a.config.commands")
require("0x2a.config.autocommands")
require("0x2a.config.keymaps")
