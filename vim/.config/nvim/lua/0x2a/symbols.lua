-- Module: 0x2a.symbols
--
-- --------------------
-- ⋅ • ◌ ◯  ●     ⦿ ⦾ ⧲ ∅ 﫠⨂   󰂭
--      
--    
--  
-- 卑喝
--  ⃟ ⟡ ◊
--        ✗ 𝑥 ╳
--      ‼
--        ℹ︎
--        ⁇
--  √ ✓ 
-- ✱ ✱ ﯂ 
--    
-- ❯  ➜ ➛ ➤ » ▸ ▾ ↲  
--    
--      
-- ⊞ ⧮ ⧯ ≣ Ξ ∷
--  
-- ƒ  ⋃ ∈ § ∞ ⟙ ⋋ ⋈ ±
-- ║ │ ▏ ┃ ▋ ― ─ ▁ ▔ └─ ├─ ── ┼ ╭ ╮ ╰ ╯ ╭╮ ╰╯
--   ⚡     
-- ¯_(ツ)_/¯
-- ୧( ಠ Д ಠ )୨
-- ⒈  ⒉  ⒊  ⒋  ⒌  ⒍  ⒎  ⒏  ⒐  ⒑
-- ⒒  ⒓  ⒔  ⒕  ⒖  ⒗  ⒘  ⒙  ⒚  ⒛

local M = {
  info = "",
  warning = "",
  error = "⨂",
  success = "﫠",
  bug = "¤",
  lock = "",
  modified = "◯",
  asterisk = "✱",
  hack = "",
  lightning = "⚡",
  flame = "",
  lightbulb = "",
  star = "✶",
  hourglass = "",
  trash = "",
  done = "✓",

  fold = {
    open = "▾",
    closed = "▸",
  },
}

M.codicon = {
  HINT = "",
  INFO = "",
  SUCCESS = "",
  ERROR = "",
  WARNING = "",
  BUG = "",
  DEBUG = "",
  Module = "",
  Tag = "",
  Array = "",
  Map = "",
  Object = "",
  lock = "",
  Breakpoint = "",
  pin = "",
  filter = "",
  Package = "",
  Enum = "",
  Field = "",
  Number = "",
  Struct = "",
  Diff = "",
  Interface = "",
  Event = "",
}

M.separators = {
  vertical = "│",
  horizontal = "―",
}

M.packer = {
  working = M.hourglass,
  done = M.done,
  error = "",
  removed = M.trash,
  moved = "➜",
  header = "━",
}

M.tree = {
  file = "",
  symlink = "",

  folder = {
    arrow_open = "",
    arrow_closed = "",
    default = "",
    open = "",
    empty = "",
    empty_open = "",
    symlink = "",
    symlink_open = "",
  },
}

M.notifications = {
  ERROR = M.error,
  WARNING = M.warning,
  INFO = M.info,
  DEBUG = M.bug,
  TRACE = "Ξ",
}

M.git = {
  repo = "±",
  unstaged = M.modified,
  staged = "●",
  unmerged = "",
  conflict = "",
  added = "✚",
  renamed = "",
  untracked = "",
  deleted = "",
  ignored = "",
}

M.gitsigns = {
  add = "▏",
  change = "▏",
  delete = "▁",
  topdelete = "▔",
  changedelete = "▔",
}

M.diagnostics = {
  error = M.codicon.ERROR,
  warning = M.codicon.WARNING,
  hint = M.lightbulb,
  info = M.info,
  success = M.codicon.SUCCESS,
}

M.tasks = {
  FIXME = M.bug,
  TODO = M.asterisk,
  HACK = M.hack,
  WARN = M.warning,
  PERF = "",
  NOTE = "",
}

M.lsp = {
  Array = "",
  Augroup = "⧲",
  Boolean = "?",
  Class = "ﴯ",
  Color = "",
  Command = "◊",
  Constant = "",
  Constructor = "",
  Dictionnary = M.codicon.Object,
  Enum = "練",
  EnumMember = M.codicon.Enum,
  Event = M.codicon.Event,
  Field = M.codicon.Field,
  File = "",
  Float = "",
  Folder = "",
  Function = "ƒ",
  Implementation = "⧯",
  Interface = M.codicon.Interface,
  Keyword = "",
  Loop = "∞",
  Macro = "⦿",
  Map = "⋈",
  Member = "∈",
  Method = "ƒ",
  Module = M.codicon.Module,
  Namespace = "§",
  Null = "ﳠ",
  Number = M.codicon.Number,
  Object = M.codicon.Object,
  Operator = "璉",
  Package = M.codicon.Package,
  Property = "",
  Reference = "",
  Snippet = "",
  String = "",
  Struct = M.codicon.Struct,
  Subroutine = "∷",
  Tag = M.codicon.Tag,
  Target = "⦾",
  Text = "",
  TypeParameter = "",
  Union = "⋃",
  Unit = "ﰩ",
  Value = "",
  Variable = "𝑥",
}

M.codicon.notifications = {
  ERROR = M.codicon.ERROR,
  WARNING = M.codicon.WARNING,
  INFO = M.codicon.INFO,
  DEBUG = M.codicon.DEBUG,
  TRACE = "",
}

return M
