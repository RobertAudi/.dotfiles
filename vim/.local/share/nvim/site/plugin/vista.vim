" Plugin: vista.vim
" Description: Viewer & Finder for LSP symbols and tags in Vim
" URL: https://github.com/liuchengxu/vista.vim

let g:vista_sidebar_width = 40
let g:vista#renderer#enable_icon = v:true
let g:vista_close_on_jump = v:false
let g:vista_stay_on_open = v:true

let g:vista_executive_for = {
  \   'javascript': 'lcn',
  \   'ruby':       'lcn',
  \   'sh':         'lcn',
  \   'html':       'lcn',
  \   'scss':       'lcn',
  \   'css':        'lcn',
  \   'json':       'lcn',
  \   'yaml':       'lcn',
  \ }

let g:vista_icon_indent = ["└─⊳ ", "├─⊳ "]

" The default icons can't be suitable for all the filetypes, you can extend it as you wish.
"    ƒ : \u0192
"    × : \u00d7
"     : \ue0a2
"    ≣ : \u2263
"    𝑥

let s:icons = {
      \   'function':       "ƒ",
      \   'variable':       "𝑥",
      \   'constant':       "\ue0a2",
      \   'method':         "",
      \   'package':        "⊞",
      \   'enum':           "≣",
      \   'module':         "{}",
      \   'type':           "⟙",
      \   'field':          "⟡",
      \   'macro':          "⦿",
      \   'map':            "⋈",
      \   'class':          "⟡",
      \   'augroup':        "⧲",
      \   'command':        "◊",
      \   'struct':         "Ξ",
      \   'union':          "⋃",
      \   'member':         "∈",
      \   'target':         "⦾",
      \   'property':       "⋅",
      \   'interface':      "⧮",
      \   'namespace':      "§",
      \   'subroutine':     "∷",
      \   'implementation': "⧯",
      \   'typeParameter':  "⋋",
      \   'default':        "➤"
      \ }

let g:vista#renderer#icons = {
      \   'func':           s:icons['function'],
      \   "function":       s:icons['function'],
      \   'functions':      s:icons['function'],
      \   'var':            s:icons['variable'],
      \   "variable":       s:icons['variable'],
      \   'variables':      s:icons['variable'],
      \   'const':          '',
      \   'constant':       '',
      \   'method':         '',
      \   'package':        s:icons['package'],
      \   'packages':       s:icons['package'],
      \   'enum':           s:icons['enum'],
      \   'enumerator':     '',
      \   'command':        s:icons['command'],
      \   'module':         s:icons['module'],
      \   'modules':        s:icons['module'],
      \   'type':           s:icons['type'],
      \   'typedef':        s:icons['type'],
      \   'types':          s:icons['type'],
      \   'field':          s:icons['field'],
      \   'fields':         s:icons['field'],
      \   'macro':          s:icons['macro'],
      \   'macros':         s:icons['macro'],
      \   'map':            s:icons['map'],
      \   'class':          s:icons['class'],
      \   'augroup':        s:icons['augroup'],
      \   'struct':         s:icons['struct'],
      \   'union':          s:icons['union'],
      \   'member':         s:icons['member'],
      \   'target':         s:icons['target'],
      \   'property':       s:icons['property'],
      \   'interface':      s:icons['interface'],
      \   'namespace':      s:icons['namespace'],
      \   'subroutine':     s:icons['subroutine'],
      \   'implementation': s:icons['implementation'],
      \   'typeParameter':  s:icons['typeParameter'],
      \   'default':        s:icons['default'],
      \ }

call x2a#abolish#commands('Vista', 'vista')

nnoremap <silent> _  <Cmd>Vista<CR>

augroup RAPluginsVista
  autocmd!

  " Make sure Vista has always the same size
  autocmd BufEnter,BufWinEnter __vista__ execute 'vertical resize ' . g:vista_sidebar_width
  autocmd BufLeave,BufWinLeave __vista__ execute 'vertical resize ' . g:vista_sidebar_width
augroup END
