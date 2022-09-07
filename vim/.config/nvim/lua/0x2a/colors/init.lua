-- Module: 0x2a.theme

vim.g.default_colorscheme = "railscasts"

local utils = require("0x2a.colors.utils")

utils.highlight("VertSplit", { ctermfg = 237, fg = "#393939" }) -- deprecated
utils.highlight("WinSeparator", { ctermfg = 237, fg = "#393939" })
utils.highlight("CursorLine", { ctermbg = 237, bg = "#323232" })
utils.highlight("CursorColumn", { ctermbg = 237, bg = "#303030" })
utils.highlight("ColorColumn", { ctermbg = 237, bg = "#303030" })
utils.highlight("SignColumn", { ctermbg = 237 })
utils.highlight("FoldColumn", { ctermbg = 237, bg = "#333435" })
utils.highlight("IncSearch", { ctermbg = 154, bg = "#c0cd38" })

utils.highlight("txtBold", { link = "Identifier" })

-- stylua: ignore start
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
]], false)
-- stylua: ignore end

