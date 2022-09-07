-- Module: 0x2a.symbols
--
-- --------------------
-- ⋅ • ◌ ◯  ●     ⦿ ⦾ ⧲ ∅   󰂭 
--    
--     
--    
--  
-- 卑喝
--  ⃟ ⟡ ◊
--       
-- בּ גּ דּ הּ וּ
--    
-- 炙    ﰠ
--      
--                     
--          
--    
--     辶逸     פֿ
--      
--            
--  
--      
--    
--   
--   襁   漣          
--  襤      直 睊    說     
--         
--      ﭧ
--          
--         
--    
--  
--     
--      菱
--           摒朗מּ 
--   ⨂    ✗ 𝑥 ╳
--      ‼
--        ℹ︎
--        ⁇
--  √ ✓  﫠
-- ✱ ﯂     
--     
-- ❯  ➜ ➛ ➤ » ▸ ▾ ↲   ↴
--    
--      
-- 卑喝
--     
--  
-- ⊞ ⧮ ⧯ ≣ Ξ ∷
--    
-- ƒ  ⋃ ∈ § ∞ ⟙ ⋋ ⋈ ±  
-- ║ │ ▏ ┃ ▋ ― ─ ▁ ▔ └─ ├─ ── ┼ ╭ ╮ ╰ ╯ ╭╮ ╰╯ ╱
-- ⚡     濫擄                裂
--                  ␣
--         ﯟ      שׂ
--      
--       
-- ¯_(ツ)_/¯
-- ୧( ಠ Д ಠ )୨
-- ⒈  ⒉  ⒊  ⒋  ⒌  ⒍  ⒎  ⒏  ⒐  ⒑
-- ⒒  ⒓  ⒔  ⒕  ⒖  ⒗  ⒘  ⒙  ⒚  ⒛
-- ⣾ ⣽ ⣻ ⢿ ⡿ ⣟ ⣯ ⣷

local M = {
  info = "",
  warning = "",
  error = "",
  success = "",
  bug = "",
  lock = "",
  modified = "◯",
  asterisk = "✱",
  hack = "",
  lightning = "⚡",
  flame = "",
  lightbulb = "",
  star = "",
  hourglass = "",
  trash = "",
  done = "✓",
  infinity = "∞",
  elipsis = "…",
  back = "",

  whitespace = {
    nbsp = "⦸",
    tab = "▸ ",
    trailing = "·",
  },

  word = {
    ["break"] = "↳  ",
    truncate = "…",
  },

  fold = {
    open = "▾",
    closed = "▸",
  },

  arrows = {
    up = "↑",
    down = "↓",
    right = "→",
    left = "←",
  },

  separators = {
    vertical = "│",
    vertical_left = "┤",
    vertical_right = "├",
    vertical_horizontal = "┼",
    horizontal = "─",
    horizontal_up = "┴",
    horizontal_down = "┬",
  },

  corners = {
    top_left = "┌",
    top_right = "┐",
    bottom_left = "└",
    bottom_right = "┘",
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

M.packer = {
  working = M.hourglass,
  done = M.done,
  error = "",
  removed = M.trash,
  moved = "➜",
  header = "━",
}

M.telescope = {
  prompt = "   ",
  selection = " ",
  borders = {
    M.separators.horizontal,
    M.separators.vertical,
    M.separators.horizontal,
    M.separators.vertical,
    M.corners.top_left,
    M.corners.top_right,
    M.corners.bottom_right,
    M.corners.bottom_left,
  },
}

M.tree = {
  file = "",
  symlink = "",
  symlink_arrow = " ➛ ",

  indent_markers = {
    corner = M.corners.bottom_left .. " ",
    edge = M.separators.vertical .. " ",
    item = M.separators.vertical .. " ",
    none = "  ",
  },

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
  branch = "",
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
  Class = "",
  Color = "",
  Command = "◊",
  Constant = "",
  Constructor = "",
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
  Key = "",
  Keyword = "",
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
