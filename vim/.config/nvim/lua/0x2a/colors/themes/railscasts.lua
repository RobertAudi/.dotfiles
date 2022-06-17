local highlight = require("0x2a.colors.utils").highlight

local colors = { -- {{{
  ["0"] = "#2b2b2b",
  ["1"] = "#333435",
  ["2"] = "#3a4055",
  ["3"] = "#5a647e",
  ["4"] = "#d4cfc9",
  ["5"] = "#e6e1dc",
  ["6"] = "#f4f1ed",
  ["7"] = "#f9f7f3",
  ["8"] = "#da4939",
  ["9"] = "#cc7833",
  ["A"] = "#ffc66d",
  ["B"] = "#a5c261",
  ["C"] = "#519f50",
  ["D"] = "#6d9cbe",
  ["E"] = "#b6b3eb",
  ["F"] = "#bc9458",

  error = "#d94a39",
  warning = "#ffa500",
  info = "#6d9cbe",
  hint = "#d783ff",
} -- }}}

-- Neovim terminal colours {{{
vim.g.terminal_color_0 = colors["0"]
vim.g.terminal_color_1 = colors["8"]
vim.g.terminal_color_2 = colors["B"]
vim.g.terminal_color_3 = colors["A"]
vim.g.terminal_color_4 = colors["D"]
vim.g.terminal_color_5 = colors["E"]
vim.g.terminal_color_6 = colors["C"]
vim.g.terminal_color_7 = colors["5"]
vim.g.terminal_color_8 = colors["3"]
vim.g.terminal_color_9 = colors["8"]
vim.g.terminal_color_10 = colors["B"]
vim.g.terminal_color_11 = colors["A"]
vim.g.terminal_color_12 = colors["D"]
vim.g.terminal_color_13 = colors["E"]
vim.g.terminal_color_14 = colors["C"]
vim.g.terminal_color_15 = colors["7"]
vim.g.terminal_color_background = vim.g.terminal_color_0
vim.g.terminal_color_foreground = vim.g.terminal_color_5
-- }}}

vim.o.background = "dark"
vim.o.termguicolors = true

vim.g.fzf_colors = { -- {{{
  ["fg"] = { "fg", "Normal" },
  ["bg"] = { "bg", "Normal" },
  ["hl"] = { "fg", "Comment" },
  ["fg+"] = { "fg", "CursorLine", "CursorColumn", "Normal" },
  ["bg+"] = { "bg", "CursorLine", "CursorColumn" },
  ["hl+"] = { "fg", "Statement" },
  ["info"] = { "fg", "PreProc" },
  ["border"] = { "fg", "Ignore" },
  ["prompt"] = { "fg", "Conditional" },
  ["pointer"] = { "fg", "Exception" },
  ["marker"] = { "fg", "Keyword" },
  ["spinner"] = { "fg", "Label" },
  ["header"] = { "fg", "Comment" },
} -- }}}

-- Vim editor colors {{{
highlight("Normal", { fg = colors["5"], bg = colors["0"] })
highlight("Bold", { bold = true })
highlight("Debug", { fg = colors["8"] })
highlight("Directory", { fg = colors["D"] })
highlight("Error", { fg = "NONE", bg = "NONE", sp = "NONE" })
highlight("ErrorMsg", { fg = colors["8"], bg = colors["0"] })
highlight("Exception", { fg = colors["8"] })
highlight("FoldColumn", { fg = colors["C"], bg = colors["1"] })
highlight("Folded", { fg = colors["3"], bg = colors["1"] })
highlight("IncSearch", { fg = colors["1"], bg = colors["9"] })
highlight("Italic", { italic = true })
highlight("Macro", { fg = colors["8"] })
highlight("MatchParen", { bg = colors["3"] })
highlight("ModeMsg", { fg = colors["B"] })
highlight("MoreMsg", { fg = colors["B"] })
highlight("Question", { fg = colors["D"] })
highlight("Search", { fg = colors["1"], bg = colors["A"] })
highlight("Substitute", { fg = colors["1"], bg = colors["A"] })
highlight("SpecialKey", { fg = colors["3"] })
highlight("TooLong", { fg = colors["8"] })
highlight("Underlined", { fg = colors["8"] })
highlight("Visual", { bg = colors["2"] })
highlight("VisualNOS", { fg = colors["8"] })
highlight("WarningMsg", { fg = colors["8"] })
highlight("WildMenu", { fg = colors["8"], bg = colors["A"] })
highlight("Title", { fg = colors["D"] })
highlight("Conceal", { fg = colors["D"], bg = colors["0"] })
highlight("Cursor", { fg = colors["0"], bg = colors["5"] })
highlight("NonText", { fg = colors["3"] })
highlight("LineNr", { fg = colors["3"], bg = colors["1"] })
highlight("SignColumn", { bg = colors["1"] })
highlight("StatusLine", { fg = colors["4"], bg = colors["2"] })
highlight("StatusLineNC", { fg = colors["3"], bg = colors["1"] })
highlight("VertSplit", { fg = colors["2"], bg = "NONE" }) -- deprecated
highlight("WinSeparator", { fg = colors["2"], bg = "NONE" })
highlight("ColorColumn", { bg = colors["1"] })
highlight("CursorColumn", { bg = colors["1"] })
highlight("CursorLine", { bg = colors["1"] })
highlight("CursorLineNr", { fg = colors["4"], bg = colors["1"] })
highlight("QuickFixLine", { bg = colors["1"] })
highlight("PMenu", { fg = colors["5"], bg = colors["1"] })
highlight("PMenuSel", { fg = colors["1"], bg = colors["5"] })
highlight("TabLine", { fg = colors["3"], bg = colors["1"] })
highlight("TabLineFill", { fg = colors["3"], bg = colors["1"] })
highlight("TabLineSel", { fg = colors["B"], bg = colors["1"] })
highlight("NvimInternalError", { fg = colors["0"], bg = colors["8"] })
highlight("NormalFloat", { fg = colors["5"], bg = colors["0"] })
highlight("FloatBorder", { fg = colors["5"], bg = colors["0"] })
highlight("NormalNC", { fg = colors["5"], bg = colors["0"] })
highlight("TermCursor", { fg = colors["0"], bg = colors["5"] })
highlight("TermCursorNC", { fg = colors["0"], bg = colors["5"] })
-- }}}

-- Standard syntax highlighting {{{
highlight("Boolean", { fg = colors["9"] })
highlight("Character", { fg = colors["8"] })
highlight("Comment", { fg = colors["3"], italic = true })
highlight("Conditional", { fg = colors["E"] })
highlight("Constant", { fg = colors["9"] })
highlight("Define", { fg = colors["E"] })
highlight("Delimiter", { fg = colors["F"] })
highlight("Float", { fg = colors["9"] })
highlight("Function", { fg = colors["D"] })
highlight("Identifier", { fg = colors["8"] })
highlight("Include", { fg = colors["D"] })
highlight("Keyword", { fg = colors["E"] })
highlight("Label", { fg = colors["A"] })
highlight("Number", { fg = colors["9"] })
highlight("Operator", { fg = colors["5"] })
highlight("PreProc", { fg = colors["A"] })
highlight("Repeat", { fg = colors["A"] })
highlight("Special", { fg = colors["C"] })
highlight("SpecialChar", { fg = colors["F"] })
highlight("Statement", { fg = colors["8"] })
highlight("StorageClass", { fg = colors["A"] })
highlight("String", { fg = colors["B"] })
highlight("Structure", { fg = colors["E"] })
highlight("Tag", { fg = colors["A"] })
highlight("Todo", { fg = colors["A"], bg = colors["1"] })
highlight("Type", { fg = colors["A"] })
highlight("Typedef", { fg = colors["A"] })
-- }}}

-- Diagnostics highlighting {{{
highlight("DiagnosticError", { fg = colors["error"] })
highlight("DiagnosticWarn", { fg = colors["warning"] })
highlight("DiagnosticInfo", { fg = colors["info"] })
highlight("DiagnosticHint", { fg = colors["hint"] })

highlight("DiagnosticSignError", { fg = colors["error"], bg = colors["1"] })
highlight("DiagnosticSignWarn", { fg = colors["warning"], bg = colors["1"] })
highlight("DiagnosticSignInfo", { fg = colors["info"], bg = colors["1"] })
highlight("DiagnosticSignHint", { fg = colors["hint"], bg = colors["1"] })

highlight("DiagnosticUnderlineError", { undercurl = true, sp = colors["error"] })
highlight("DiagnosticUnderlineWarning", { undercurl = true, sp = colors["warning"] })
highlight("DiagnosticUnderlineWarn", { undercurl = true, sp = colors["warning"] })
highlight("DiagnosticUnderlineInformation", { undercurl = true, sp = colors["info"] })
highlight("DiagnosticUnderlineHint", { undercurl = true, sp = colors["hint"] })
-- }}}

-- LSP highlighting {{{
highlight("LspReferenceText", { underline = true, sp = colors["4"] })
highlight("LspReferenceRead", { underline = true, sp = colors["4"] })
highlight("LspReferenceWrite", { underline = true, sp = colors["4"] })

highlight("LspDiagnosticsDefaultError", { link = "DiagnosticError" })
highlight("LspDiagnosticsDefaultWarning", { link = "DiagnosticWarn" })
highlight("LspDiagnosticsDefaultInformation", { link = "DiagnosticInfo" })
highlight("LspDiagnosticsDefaultHint", { link = "DiagnosticHint" })
highlight("LspDiagnosticsUnderlineError", { link = "DiagnosticUnderlineError" })
highlight("LspDiagnosticsUnderlineWarning", { link = "DiagnosticUnderlineWarning" })
highlight("LspDiagnosticsUnderlineInformation", { link = "DiagnosticUnderlineInformation" })
highlight("LspDiagnosticsUnderlineHint", { link = "DiagnosticUnderlineHint" })
-- }}}

-- Treesitter highlighting {{{
highlight("TSAnnotation", { fg = colors["F"] })
highlight("TSAttribute", { fg = colors["A"] })
highlight("TSBoolean", { fg = colors["9"] })
highlight("TSCharacter", { fg = colors["8"] })
highlight("TSComment", { fg = colors["3"], italic = true })
highlight("TSConstructor", { fg = colors["D"] })
highlight("TSConditional", { fg = colors["E"] })
highlight("TSConstant", { fg = colors["9"] })
highlight("TSConstBuiltin", { fg = colors["9"], italic = true })
highlight("TSConstMacro", { fg = colors["8"] })
highlight("TSError", { fg = colors["8"] })
highlight("TSException", { fg = colors["8"] })
highlight("TSField", { fg = colors["5"] })
highlight("TSFloat", { fg = colors["9"] })
highlight("TSFunction", { fg = colors["D"] })
highlight("TSFuncBuiltin", { fg = colors["D"], italic = true })
highlight("TSFuncMacro", { fg = colors["8"] })
highlight("TSInclude", { fg = colors["D"] })
highlight("TSKeyword", { fg = colors["E"] })
highlight("TSKeywordFunction", { fg = colors["E"] })
highlight("TSKeywordOperator", { fg = colors["E"] })
highlight("TSLabel", { fg = colors["A"] })
highlight("TSMethod", { fg = colors["D"] })
highlight("TSNamespace", { fg = colors["8"] })
highlight("TSNONE", { fg = colors["5"] })
highlight("TSNumber", { fg = colors["9"] })
highlight("TSOperator", { fg = colors["5"] })
highlight("TSParameter", { fg = colors["5"] })
highlight("TSParameterReference", { fg = colors["5"] })
highlight("TSProperty", { fg = colors["5"] })
highlight("TSPunctDelimiter", { fg = colors["F"] })
highlight("TSPunctBracket", { fg = colors["5"] })
highlight("TSPunctSpecial", { fg = colors["5"] })
highlight("TSRepeat", { fg = colors["A"] })
highlight("TSString", { fg = colors["B"] })
highlight("TSStringRegex", { fg = colors["C"] })
highlight("TSStringEscape", { fg = colors["C"] })
highlight("TSSymbol", { fg = colors["B"] })
highlight("TSTag", { fg = colors["A"] })
highlight("TSTagDelimiter", { fg = colors["F"] })
highlight("TSText", { fg = colors["5"] })
highlight("TSStrong", { bold = true })
highlight("TSEmphasis", { fg = colors["9"], italic = true })
highlight("TSUnderline", { fg = colors["0"], underline = true })
highlight("TSStrike", { fg = colors["0"], strikethrough = true })
highlight("TSTitle", { fg = colors["D"] })
highlight("TSLiteral", { fg = colors["9"] })
highlight("TSURI", { fg = colors["9"], underline = true })
highlight("TSType", { fg = colors["A"] })
highlight("TSTypeBuiltin", { fg = colors["A"], italic = true })
highlight("TSVariable", { fg = colors["8"] })
highlight("TSVariableBuiltin", { fg = colors["8"], italic = true })
highlight("TSDefinition", { underline = true, sp = colors["4"] })
highlight("TSDefinitionUsage", { underline = true, sp = colors["4"] })
highlight("TSCurrentScope", { bold = true })
highlight("TreesitterContext", { bg = colors["1"], italic = true })
-- }}}

-- User highlights {{{
highlight("User1", { fg = colors["8"], bg = colors["2"] })
highlight("User2", { fg = colors["E"], bg = colors["2"] })
highlight("User3", { fg = colors["5"], bg = colors["2"] })
highlight("User4", { fg = colors["C"], bg = colors["2"] })
highlight("User5", { fg = colors["1"], bg = colors["2"] })
highlight("User6", { fg = colors["5"], bg = colors["2"] })
highlight("User7", { fg = colors["5"], bg = colors["2"] })
highlight("User8", { fg = colors["0"], bg = colors["2"] })
highlight("User9", { fg = colors["0"], bg = colors["2"] })
-- }}}

-- Diff highlighting {{{
highlight("DiffAdd", { fg = colors["B"], bg = colors["1"] })
highlight("DiffChange", { fg = colors["3"], bg = colors["1"] })
highlight("DiffChange", { fg = colors["D"], bg = colors["1"] })
highlight("DiffChangeDelete", { fg = colors["E"], bg = colors["1"] })
highlight("DiffDelete", { fg = colors["8"], bg = colors["1"] })
highlight("DiffText", { fg = colors["D"], bg = colors["1"] })
highlight("DiffAdded", { fg = colors["B"], bg = colors["0"] })
highlight("DiffFile", { fg = colors["8"], bg = colors["0"] })
highlight("DiffNewFile", { fg = colors["B"], bg = colors["0"] })
highlight("DiffLine", { fg = colors["D"], bg = colors["0"] })
highlight("DiffRemoved", { fg = colors["8"], bg = colors["0"] })
-- }}}

-- Git highlighting {{{
highlight("gitcommitOverflow", { fg = colors["8"] })
highlight("gitcommitSummary", { fg = colors["B"] })
highlight("gitcommitComment", { fg = colors["3"] })
highlight("gitcommitUntracked", { fg = colors["3"] })
highlight("gitcommitDiscarded", { fg = colors["3"] })
highlight("gitcommitSelected", { fg = colors["3"] })
highlight("gitcommitHeader", { fg = colors["E"] })
highlight("gitcommitSelectedType", { fg = colors["D"] })
highlight("gitcommitUnmergedType", { fg = colors["D"] })
highlight("gitcommitDiscardedType", { fg = colors["D"] })
highlight("gitcommitBranch", { fg = colors["9"], bold = true })
highlight("gitcommitUntrackedFile", { fg = colors["A"] })
highlight("gitcommitUnmergedFile", { fg = colors["8"], bold = true })
highlight("gitcommitDiscardedFile", { fg = colors["8"], bold = true })
highlight("gitcommitSelectedFile", { fg = colors["B"], bold = true })
-- }}}

-- C highlighting {{{
highlight("cOperator", { fg = colors["C"] })
highlight("cPreCondit", { fg = colors["E"] })
-- }}}

-- C# highlighting {{{
highlight("csClass", { fg = colors["A"] })
highlight("csAttribute", { fg = colors["A"] })
highlight("csModifier", { fg = colors["E"] })
highlight("csType", { fg = colors["8"] })
highlight("csUnspecifiedStatement", { fg = colors["D"] })
highlight("csContextualStatement", { fg = colors["E"] })
highlight("csNewDecleration", { fg = colors["8"] })
-- }}}

-- CSS highlighting {{{
highlight("cssBraces", { fg = colors["5"] })
highlight("cssClassName", { fg = colors["E"] })
highlight("cssColor", { fg = colors["C"] })
-- }}}

-- HTML highlighting {{{
highlight("htmlBold", { fg = colors["A"] })
highlight("htmlItalic", { fg = colors["E"] })
highlight("htmlEndTag", { fg = colors["5"] })
highlight("htmlTag", { fg = colors["5"] })
-- }}}

-- JavaScript highlighting {{{
highlight("javaScript", { fg = colors["5"] })
highlight("javaScriptBraces", { fg = colors["5"] })
highlight("javaScriptNumber", { fg = colors["9"] })
-- }}}

-- pangloss/vim-javascript highlighting {{{
highlight("jsOperator", { fg = colors["D"] })
highlight("jsStatement", { fg = colors["E"] })
highlight("jsReturn", { fg = colors["E"] })
highlight("jsThis", { fg = colors["8"] })
highlight("jsClassDefinition", { fg = colors["A"] })
highlight("jsFunction", { fg = colors["E"] })
highlight("jsFuncName", { fg = colors["D"] })
highlight("jsFuncCall", { fg = colors["D"] })
highlight("jsClassFuncName", { fg = colors["D"] })
highlight("jsClassMethodType", { fg = colors["E"] })
highlight("jsRegexpString", { fg = colors["C"] })
highlight("jsGlobalObjects", { fg = colors["A"] })
highlight("jsGlobalNodeObjects", { fg = colors["A"] })
highlight("jsExceptions", { fg = colors["A"] })
highlight("jsBuiltins", { fg = colors["A"] })
-- }}}

-- Mail highlighting {{{
highlight("mailQuoted1", { fg = colors["A"] })
highlight("mailQuoted2", { fg = colors["B"] })
highlight("mailQuoted3", { fg = colors["E"] })
highlight("mailQuoted4", { fg = colors["C"] })
highlight("mailQuoted5", { fg = colors["D"] })
highlight("mailQuoted6", { fg = colors["A"] })
highlight("mailURL", { fg = colors["D"] })
highlight("mailEmail", { fg = colors["D"] })
-- }}}

-- Markdown highlighting {{{
highlight("markdownCode", { fg = colors["B"] })
highlight("markdownError", { fg = colors["5"], bg = colors["0"] })
highlight("markdownCodeBlock", { fg = colors["B"] })
highlight("markdownHeadingDelimiter", { fg = colors["D"] })
-- }}}

-- PHP highlighting {{{
highlight("phpMemberSelector", { fg = colors["5"] })
highlight("phpComparison", { fg = colors["5"] })
highlight("phpParent", { fg = colors["5"] })
highlight("phpMethodsVar", { fg = colors["C"] })
-- }}}

-- Python highlighting {{{
highlight("pythonOperator", { fg = colors["E"] })
highlight("pythonRepeat", { fg = colors["E"] })
highlight("pythonInclude", { fg = colors["E"] })
highlight("pythonStatement", { fg = colors["E"] })
-- }}}

-- Ruby highlighting {{{
highlight("rubyAttribute", { fg = colors["D"] })
highlight("rubyConstant", { fg = colors["A"] })
highlight("rubyInterpolationDelimiter", { fg = colors["F"] })
highlight("rubyRegexp", { fg = colors["C"] })
highlight("rubySymbol", { fg = colors["B"] })
highlight("rubyStringDelimiter", { fg = colors["B"] })
-- }}}

-- SASS highlighting {{{
highlight("sassidChar", { fg = colors["8"] })
highlight("sassClassChar", { fg = colors["9"] })
highlight("sassInclude", { fg = colors["E"] })
highlight("sassMixing", { fg = colors["E"] })
highlight("sassMixinName", { fg = colors["D"] })
-- }}}

-- Spelling highlighting {{{
highlight("SpellBad", { undercurl = true, sp = colors["8"] })
highlight("SpellLocal", { undercurl = true, sp = colors["C"] })
highlight("SpellCap", { undercurl = true, sp = colors["D"] })
highlight("SpellRare", { undercurl = true, sp = colors["E"] })
-- }}}

-- Java highlighting {{{
highlight("javaOperator", { fg = colors["D"] })
-- }}}

highlight("HighlightedyankRegion", { fg = colors["0"], bg = colors["A"] })

-- Git conflict markers {{{
highlight("ConflictMarkerBegin", { fg = colors["7"], bg = colors["error"] })
highlight("ConflictMarkerEnd", { fg = colors["7"], bg = colors["error"] })
highlight("ConflictMarkerSeparator", { fg = colors["7"], bg = colors["error"] })
-- }}}

-- FIXME: FIX THAT SHIT
-- -- Tasks comments {{{
-- highlight("TasksFixme", { fg = colors["7"], bg = colors["error"],  gui = "NONE" })
-- highlight("TasksTodo", { fg = colors["7"], bg = colors["hint"],  gui = "NONE" })
-- highlight("TasksHack", { fg = colors["7"], bg = colors["hint"],  gui = "NONE" })
-- highlight("TasksWarn", { fg = colors["7"], bg = colors["warning"],  gui = "NONE" })
-- highlight("TasksPerf", { fg = colors["7"], bg = colors["warning"],  gui = "NONE" })
-- highlight("TasksNote", { fg = colors["7"], bg = colors["info"],  gui = "NONE" })
-- }}}

-- Modeline {{{
-- vim: set foldmarker={{{,}}} foldlevel=0 foldmethod=marker : }}}
