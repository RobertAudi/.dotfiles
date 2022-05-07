pcall(require, "impatient")

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

vim.cmd("packadd packer.nvim")

require("0x2a.plugins")
require("0x2a.config.options")
require("0x2a.config.gui")

vim.g.foldutilFoldText = "AwesomeFoldText#foldtext()"

-- Easy shebang
vim.cmd("iabbrev #! #!/usr/bin/env")
vim.cmd("colorscheme railscasts")

vim.api.nvim_exec([[
  augroup RAVimSyntaxAutocommands
    autocmd!

    autocmd Syntax *
          \   call matchadd('Todo',  '\W\zs\<\(FIXME\|BUG\)\>:\ze')
          \ | call matchadd('Todo',  '\W\zs\<TODO\>:\ze')
          \ | call matchadd('Todo',  '\W\zs\<\(HACK\|DEBUG|???\)\>:\ze')
          \ | call matchadd('Todo',  '\W\zs\<\(WARN\(ING\)\?\|XXX\|\!\!\!\)\>:\ze')
          \ | call matchadd('Todo',  '\W\zs\<\(PERF\|OPTIMIZE\)\>:\ze')
          \ | call matchadd('Todo',  '\W\zs\<\(NOTE\|INFO\)\>:\ze')
  augroup END


  highlight VertSplit    ctermfg=237 guifg=#393939
  highlight CursorLine   ctermbg=237 guibg=#323232
  highlight CursorColumn ctermbg=237 guibg=#303030
  highlight ColorColumn  ctermbg=237 guibg=#303030
  highlight SignColumn   ctermbg=237
  highlight FoldColumn   ctermbg=237 guibg=#333435
  highlight IncSearch    ctermbg=154 guibg=#c0cd38

  highlight! link txtBold Identifier
]], false)

require("0x2a.config.commands")
require("0x2a.config.autocommands")
require("0x2a.config.maps")
