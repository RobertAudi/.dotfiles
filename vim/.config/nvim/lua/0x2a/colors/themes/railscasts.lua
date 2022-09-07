local M = {}

M.scheme = { -- {{{
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
}

M.scheme.black = M.scheme["0"]
M.scheme.white = M.scheme["7"]
M.scheme.red = M.scheme["8"]
M.scheme.blue = M.scheme["D"]
M.scheme.green = M.scheme["B"]
M.scheme.yellow = M.scheme["A"]
M.scheme.orange = "#ffa500"
M.scheme.teal = M.scheme["C"]
M.scheme.pink = "#d783ff"
M.scheme.amaranth = "#d94a39"

M.scheme.error = "#d94a39"
M.scheme.warning = M.scheme.orange
M.scheme.info = "#6d9cbe"
M.scheme.hint = M.scheme.pink

M.scheme.standout = { fg = "#ff4500", bg = "#eeee00" }
-- }}}

M.options = { -- {{{
  background = "dark",
  termguicolors = true,
} -- }}}

-- FZF -- {{{
M.fzf = {
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

-- Neovim terminal colours -- {{{
M.terminal = {
  color_0 = M.scheme["0"],
  color_1 = M.scheme["8"],
  color_2 = M.scheme["B"],
  color_3 = M.scheme["A"],
  color_4 = M.scheme["D"],
  color_5 = M.scheme["E"],
  color_6 = M.scheme["C"],
  color_7 = M.scheme["5"],
  color_8 = M.scheme["3"],
  color_9 = M.scheme["8"],
  color_10 = M.scheme["B"],
  color_11 = M.scheme["A"],
  color_12 = M.scheme["D"],
  color_13 = M.scheme["E"],
  color_14 = M.scheme["C"],
  color_15 = M.scheme["7"],
}

M.terminal.color_background = M.terminal.color_0
M.terminal.color_foreground = M.terminal.color_5
-- }}}

M.colors = {}

-- Vim editor colors {{{
M.colors["Normal"] = { fg = M.scheme["5"], bg = M.scheme["0"] }
M.colors["NormalNC"] = { link = "Normal" }
M.colors["NormalSB"] = { link = "Normal" }
M.colors["Variable"] = { link = "Normal" }
M.colors["Bold"] = { bold = true }
M.colors["Italic"] = { italic = true }
M.colors["Underlined"] = { fg = M.scheme["8"] }
M.colors["Debug"] = { fg = M.scheme["8"] }
M.colors["Directory"] = { fg = M.scheme["D"] }
M.colors["Error"] = { fg = "NONE", bg = "NONE", sp = "NONE" }
M.colors["ErrorMsg"] = { fg = M.scheme["error"], bg = M.scheme["0"] }
M.colors["Exception"] = { fg = M.scheme["error"] }
M.colors["NvimInternalError"] = { fg = M.scheme["0"], bg = M.scheme["8"] }
M.colors["FoldColumn"] = { fg = M.scheme["C"], bg = M.scheme["1"] }
M.colors["Folded"] = { fg = M.scheme["3"], bg = M.scheme["1"] }
M.colors["Search"] = { fg = M.scheme["1"], bg = M.scheme["A"] }
M.colors["CurSearch"] = { link = "Search" }
M.colors["IncSearch"] = { fg = M.scheme["1"], bg = M.scheme["9"] }
M.colors["Macro"] = { fg = M.scheme["8"] }
M.colors["MatchParen"] = { bg = M.scheme["8"], underline = true }
M.colors["ModeMsg"] = { fg = M.scheme["B"] }
M.colors["MoreMsg"] = { fg = M.scheme["B"] }
M.colors["Question"] = { fg = M.scheme["D"] }
M.colors["Substitute"] = { fg = M.scheme["1"], bg = M.scheme["A"] }
M.colors["NonText"] = { fg = M.scheme["3"] }
M.colors["SpecialKey"] = { link = "NonText" }
M.colors["Ignore"] = { link = "NonText" }
M.colors["TooLong"] = { fg = M.scheme["8"] }
M.colors["Visual"] = { bg = M.scheme["2"] }
M.colors["VisualNOS"] = { fg = M.scheme["8"] }
M.colors["WarningMsg"] = { fg = M.scheme["8"] }
M.colors["WildMenu"] = { fg = M.scheme["8"], bg = M.scheme["A"] }
M.colors["Title"] = { fg = M.scheme["D"] }
M.colors["Conceal"] = { fg = M.scheme["D"], bg = M.scheme["0"] }
M.colors["LineNr"] = { fg = M.scheme["3"], bg = M.scheme["1"] }
M.colors["SignColumn"] = { bg = M.scheme["1"] }
M.colors["SignColumnSB"] = { link = "SignColumn" }
M.colors["StatusLine"] = { fg = M.scheme["4"], bg = M.scheme["2"] }
M.colors["StatusLineNC"] = { fg = M.scheme["3"], bg = M.scheme["1"] }
M.colors["TabLine"] = { fg = M.scheme["3"], bg = M.scheme["1"] }
M.colors["TabLineFill"] = { fg = M.scheme["3"], bg = M.scheme["1"] }
M.colors["TabLineSel"] = { fg = M.scheme["B"], bg = M.scheme["1"] }
M.colors["VertSplit"] = { fg = M.scheme["2"], bg = "NONE" } -- deprecated
M.colors["WinSeparator"] = { fg = M.scheme["2"], bg = "NONE" }
M.colors["Cursor"] = { fg = M.scheme["0"], bg = M.scheme["5"] }
M.colors["lCursor"] = { link = "Cursor" }
M.colors["CursorIM"] = { link = "Cursor" }
M.colors["CursorLine"] = { bg = M.scheme["1"] }
M.colors["CursorLineNr"] = { fg = M.scheme["4"], bg = M.scheme["1"] }
M.colors["CursorColumn"] = { bg = M.scheme["1"] }
M.colors["ColorColumn"] = { link = "CursorLine" }
M.colors["QuickFixLine"] = { bg = M.scheme["1"] }
M.colors["PMenu"] = { fg = M.scheme["5"], bg = M.scheme["1"] }
M.colors["PMenuSel"] = { fg = M.scheme["1"], bg = M.scheme["5"] }
M.colors["PmenuSbar"] = { link = "Pmenu" }
M.colors["NvimInternalError"] = { fg = M.scheme["0"], bg = M.scheme["8"] }
M.colors["NormalFloat"] = { fg = M.scheme["5"], bg = M.scheme["0"] }
M.colors["FloatBorder"] = { fg = M.scheme["5"], bg = M.scheme["0"] }
M.colors["TermCursor"] = { fg = M.scheme["0"], bg = M.scheme["5"] }
M.colors["TermCursorNC"] = { fg = M.scheme["0"], bg = M.scheme["5"] }
-- }}}

-- Standard syntax highlighting {{{
M.colors["Boolean"] = { fg = M.scheme["9"] }
M.colors["Character"] = { fg = M.scheme["8"] }
M.colors["Comment"] = { fg = M.scheme["3"], italic = true }
M.colors["Conditional"] = { fg = M.scheme["E"] }
M.colors["Constant"] = { fg = M.scheme["9"] }
M.colors["Define"] = { fg = M.scheme["E"] }
M.colors["Delimiter"] = { fg = M.scheme["F"] }
M.colors["Float"] = { fg = M.scheme["9"] }
M.colors["Function"] = { fg = M.scheme["D"] }
M.colors["Identifier"] = { fg = M.scheme["8"] }
M.colors["Include"] = { fg = M.scheme["D"] }
M.colors["Keyword"] = { fg = M.scheme["E"] }
M.colors["Label"] = { fg = M.scheme["A"] }
M.colors["Number"] = { fg = M.scheme["9"] }
M.colors["Operator"] = { fg = M.scheme["5"] }
M.colors["PreCondit"] = { link = "Conditional" }
M.colors["PreProc"] = { fg = M.scheme["A"] }
M.colors["Repeat"] = { fg = M.scheme["A"] }
M.colors["Special"] = { fg = M.scheme["C"] }
M.colors["SpecialChar"] = { fg = M.scheme["F"] }
M.colors["Statement"] = { fg = M.scheme["8"] }
M.colors["StorageClass"] = { fg = M.scheme["A"] }
M.colors["String"] = { fg = M.scheme["B"] }
M.colors["Structure"] = { fg = M.scheme["E"] }
M.colors["Tag"] = { fg = M.scheme["A"] }
M.colors["Todo"] = M.scheme.standout
M.colors["Type"] = { fg = M.scheme["A"] }
M.colors["Typedef"] = { fg = M.scheme["A"] }
-- }}}

-- Diagnostics highlighting {{{
M.colors["DiagnosticError"] = { fg = M.scheme["error"] }
M.colors["DiagnosticWarn"] = { fg = M.scheme["warning"] }
M.colors["DiagnosticInfo"] = { fg = M.scheme["info"] }
M.colors["DiagnosticHint"] = { fg = M.scheme["hint"] }

M.colors["DiagnosticSignError"] = { fg = M.scheme["error"], bg = M.scheme["1"] }
M.colors["DiagnosticSignWarn"] = { fg = M.scheme["warning"], bg = M.scheme["1"] }
M.colors["DiagnosticSignInfo"] = { fg = M.scheme["info"], bg = M.scheme["1"] }
M.colors["DiagnosticSignHint"] = { fg = M.scheme["hint"], bg = M.scheme["1"] }

M.colors["DiagnosticUnderlineError"] = { undercurl = true, sp = M.scheme["error"] }
M.colors["DiagnosticUnderlineWarning"] = { undercurl = true, sp = M.scheme["warning"] }
M.colors["DiagnosticUnderlineWarn"] = { undercurl = true, sp = M.scheme["warning"] }
M.colors["DiagnosticUnderlineInformation"] = { undercurl = true, sp = M.scheme["info"] }
M.colors["DiagnosticUnderlineHint"] = { undercurl = true, sp = M.scheme["hint"] }
-- }}}

-- LSP highlighting {{{
M.colors["LspReferenceText"] = { underline = true, sp = M.scheme["4"] }
M.colors["LspReferenceRead"] = { underline = true, sp = M.scheme["4"] }
M.colors["LspReferenceWrite"] = { underline = true, sp = M.scheme["4"] }

M.colors["LspDiagnosticsDefaultError"] = { link = "DiagnosticError" }
M.colors["LspDiagnosticsDefaultWarning"] = { link = "DiagnosticWarn" }
M.colors["LspDiagnosticsDefaultInformation"] = { link = "DiagnosticInfo" }
M.colors["LspDiagnosticsDefaultHint"] = { link = "DiagnosticHint" }
M.colors["LspDiagnosticsUnderlineError"] = { link = "DiagnosticUnderlineError" }
M.colors["LspDiagnosticsUnderlineWarning"] = { link = "DiagnosticUnderlineWarning" }
M.colors["LspDiagnosticsUnderlineInformation"] = { link = "DiagnosticUnderlineInformation" }
M.colors["LspDiagnosticsUnderlineHint"] = { link = "DiagnosticUnderlineHint" }
-- }}}

-- Treesitter highlighting {{{
M.colors["TSAnnotation"] = { fg = M.scheme["F"] }
M.colors["TSAttribute"] = { fg = M.scheme["A"] }
M.colors["TSBoolean"] = { link = "Boolean" }
M.colors["TSCharacter"] = { link = "Character" }
M.colors["TSCharacterSpecial"] = { link = "SpecialChar" }
M.colors["TSComment"] = { link = "Comment" }
M.colors["TSConditional"] = { link = "Conditional" }
M.colors["TSConstBuiltin"] = { fg = M.colors["Constant"].fg, italic = true }
M.colors["TSConstMacro"] = { fg = M.scheme["8"] }
M.colors["TSConstant"] = { link = "Constant" }
M.colors["TSConstructor"] = { fg = M.scheme["D"] }
M.colors["TSCurrentScope"] = { bold = true }
M.colors["TSDanger"] = { link = "Error" }
M.colors["TSDebug"] = { link = "Debug" }
M.colors["TSDefine"] = { link = "Define" }
M.colors["TSEmphasis"] = { link = "Italic" }
M.colors["TSEnvironment"] = { link = "Keyword" }
M.colors["TSEnvironmentName"] = { link = "Typedef" }
M.colors["TSError"] = { fg = M.scheme["error"] }
M.colors["TSException"] = { link = "Exception" }
M.colors["TSField"] = { fg = M.scheme["5"] }
M.colors["TSFloat"] = { link = "Float" }
M.colors["TSFuncBuiltin"] = { fg = M.colors["Float"].fg, italic = true }
M.colors["TSFuncMacro"] = { link = "Function" }
M.colors["TSFunction"] = { link = "Function" }
M.colors["TSInclude"] = { link = "Include" }
M.colors["TSKeyword"] = { link = "Keyword" }
M.colors["TSKeywordFunction"] = { link = "Keyword" }
M.colors["TSKeywordOperator"] = { link = "Keyword" }
M.colors["TSLabel"] = { link = "Label" }
M.colors["TSLiteral"] = { fg = M.scheme["9"] }
M.colors["TSMath"] = { fg = M.scheme["A"] }
M.colors["TSMethod"] = { link = "Function" }
M.colors["TSNamespace"] = { fg = M.scheme["8"] }
M.colors["TSNone"] = { fg = M.scheme["5"] }
M.colors["TSNote"] = { fg = M.scheme["info"] }
M.colors["TSNumber"] = { link = "Number" }
M.colors["TSOperator"] = { link = "Operator" }
M.colors["TSParameter"] = { fg = M.scheme["5"] }
M.colors["TSParameterReference"] = { fg = M.scheme["5"] }
M.colors["TSPreProc"] = { link = "PreProc" }
M.colors["TSProperty"] = { fg = M.scheme["5"] }
M.colors["TSPunctBracket"] = { link = "Delimiter" }
M.colors["TSPunctDelimiter"] = { link = "Delimiter" }
M.colors["TSPunctSpecial"] = { link = "Delimiter" }
M.colors["TSRepeat"] = { link = "Repeat" }
M.colors["TSStorageClass"] = { link = "StorageClass" }
M.colors["TSStrike"] = { strikethrough = true }
M.colors["TSString"] = { link = "String" }
M.colors["TSStringEscape"] = { link = "String" }
M.colors["TSStringRegex"] = { link = "String" }
M.colors["TSStringSpecial"] = { link = "SpecialChar" }
M.colors["TSStrong"] = { link = "Bold" }
M.colors["TSSymbol"] = { link = "String" }
M.colors["TSTag"] = { link = "Tag" }
M.colors["TSTagAttribute"] = { fg = M.scheme["A"] }
M.colors["TSTagDelimiter"] = { fg = M.scheme["F"] }
M.colors["TSText"] = { link = "Normal" }
M.colors["TSTextReference"] = { fg = M.scheme["8"] }
M.colors["TSTitle"] = { link = "Title" }
M.colors["TSTodo"] = { fg = M.scheme["hint"] }
M.colors["TSType"] = { link = "Type" }
M.colors["TSTypeBuiltin"] = { fg = M.colors["Type"].fg, italic = true }
M.colors["TSTypeDefinition"] = { link = "Typedef" }
M.colors["TSTypeQualifier"] = { fg = M.scheme["A"] }
M.colors["TSURI"] = { fg = M.scheme["9"], underline = true }
M.colors["TSUnderline"] = { link = "Underlined" }
M.colors["TSVariable"] = { link = "Variable" }
M.colors["TSVariableBuiltin"] = { fg = M.colors["Variable"].fg, italic = true }
M.colors["TSWarning"] = { fg = M.scheme["warning"] }
-- }}}

-- User highlights {{{
M.colors["User1"] = { fg = M.scheme["8"], bg = M.scheme["2"] }
M.colors["User2"] = { fg = M.scheme["E"], bg = M.scheme["2"] }
M.colors["User3"] = { fg = M.scheme["5"], bg = M.scheme["2"] }
M.colors["User4"] = { fg = M.scheme["C"], bg = M.scheme["2"] }
M.colors["User5"] = { fg = M.scheme["1"], bg = M.scheme["2"] }
M.colors["User6"] = { fg = M.scheme["5"], bg = M.scheme["2"] }
M.colors["User7"] = { fg = M.scheme["5"], bg = M.scheme["2"] }
M.colors["User8"] = { fg = M.scheme["0"], bg = M.scheme["2"] }
M.colors["User9"] = { fg = M.scheme["0"], bg = M.scheme["2"] }
-- }}}

-- Diff highlighting {{{
M.colors["DiffAdd"] = { fg = M.scheme["B"], bg = M.scheme["1"] }
M.colors["DiffChange"] = { fg = M.scheme["3"], bg = M.scheme["1"] }
M.colors["DiffChange"] = { fg = M.scheme["D"], bg = M.scheme["1"] }
M.colors["DiffChangeDelete"] = { fg = M.scheme["E"], bg = M.scheme["1"] }
M.colors["DiffDelete"] = { fg = M.scheme["8"], bg = M.scheme["1"] }
M.colors["DiffText"] = { fg = M.scheme["D"], bg = M.scheme["1"] }
M.colors["DiffAdded"] = { fg = M.scheme["B"], bg = M.scheme["0"] }
M.colors["DiffFile"] = { fg = M.scheme["8"], bg = M.scheme["0"] }
M.colors["DiffNewFile"] = { fg = M.scheme["B"], bg = M.scheme["0"] }
M.colors["DiffLine"] = { fg = M.scheme["D"], bg = M.scheme["0"] }
M.colors["DiffRemoved"] = { fg = M.scheme["8"], bg = M.scheme["0"] }
-- }}}

-- Git highlighting {{{
M.colors["gitcommitOverflow"] = { fg = M.scheme["8"] }
M.colors["gitcommitSummary"] = { fg = M.scheme["B"] }
M.colors["gitcommitComment"] = { fg = M.scheme["3"] }
M.colors["gitcommitUntracked"] = { fg = M.scheme["3"] }
M.colors["gitcommitDiscarded"] = { fg = M.scheme["3"] }
M.colors["gitcommitSelected"] = { fg = M.scheme["3"] }
M.colors["gitcommitHeader"] = { fg = M.scheme["E"] }
M.colors["gitcommitSelectedType"] = { fg = M.scheme["D"] }
M.colors["gitcommitUnmergedType"] = { fg = M.scheme["D"] }
M.colors["gitcommitDiscardedType"] = { fg = M.scheme["D"] }
M.colors["gitcommitBranch"] = { fg = M.scheme["9"], bold = true }
M.colors["gitcommitUntrackedFile"] = { fg = M.scheme["A"] }
M.colors["gitcommitUnmergedFile"] = { fg = M.scheme["8"], bold = true }
M.colors["gitcommitDiscardedFile"] = { fg = M.scheme["8"], bold = true }
M.colors["gitcommitSelectedFile"] = { fg = M.scheme["B"], bold = true }
-- }}}

-- C highlighting {{{
M.colors["cOperator"] = { fg = M.scheme["C"] }
M.colors["cPreCondit"] = { fg = M.scheme["E"] }
-- }}}

-- C# highlighting {{{
M.colors["csClass"] = { fg = M.scheme["A"] }
M.colors["csAttribute"] = { fg = M.scheme["A"] }
M.colors["csModifier"] = { fg = M.scheme["E"] }
M.colors["csType"] = { fg = M.scheme["8"] }
M.colors["csUnspecifiedStatement"] = { fg = M.scheme["D"] }
M.colors["csContextualStatement"] = { fg = M.scheme["E"] }
M.colors["csNewDecleration"] = { fg = M.scheme["8"] }
-- }}}

-- CSS highlighting {{{
M.colors["cssBraces"] = { fg = M.scheme["5"] }
M.colors["cssClassName"] = { fg = M.scheme["E"] }
M.colors["cssColor"] = { fg = M.scheme["C"] }
-- }}}

-- HTML highlighting {{{
M.colors["htmlBold"] = { fg = M.scheme["A"] }
M.colors["htmlItalic"] = { fg = M.scheme["E"] }
M.colors["htmlEndTag"] = { fg = M.scheme["5"] }
M.colors["htmlTag"] = { fg = M.scheme["5"] }
-- }}}

-- JavaScript highlighting {{{
M.colors["javaScript"] = { fg = M.scheme["5"] }
M.colors["javaScriptBraces"] = { fg = M.scheme["5"] }
M.colors["javaScriptNumber"] = { fg = M.scheme["9"] }
-- }}}

-- pangloss/vim-javascript highlighting {{{
M.colors["jsOperator"] = { fg = M.scheme["D"] }
M.colors["jsStatement"] = { fg = M.scheme["E"] }
M.colors["jsReturn"] = { fg = M.scheme["E"] }
M.colors["jsThis"] = { fg = M.scheme["8"] }
M.colors["jsClassDefinition"] = { fg = M.scheme["A"] }
M.colors["jsFunction"] = { fg = M.scheme["E"] }
M.colors["jsFuncName"] = { fg = M.scheme["D"] }
M.colors["jsFuncCall"] = { fg = M.scheme["D"] }
M.colors["jsClassFuncName"] = { fg = M.scheme["D"] }
M.colors["jsClassMethodType"] = { fg = M.scheme["E"] }
M.colors["jsRegexpString"] = { fg = M.scheme["C"] }
M.colors["jsGlobalObjects"] = { fg = M.scheme["A"] }
M.colors["jsGlobalNodeObjects"] = { fg = M.scheme["A"] }
M.colors["jsExceptions"] = { fg = M.scheme["A"] }
M.colors["jsBuiltins"] = { fg = M.scheme["A"] }
-- }}}

-- Mail highlighting {{{
M.colors["mailQuoted1"] = { fg = M.scheme["A"] }
M.colors["mailQuoted2"] = { fg = M.scheme["B"] }
M.colors["mailQuoted3"] = { fg = M.scheme["E"] }
M.colors["mailQuoted4"] = { fg = M.scheme["C"] }
M.colors["mailQuoted5"] = { fg = M.scheme["D"] }
M.colors["mailQuoted6"] = { fg = M.scheme["A"] }
M.colors["mailURL"] = { fg = M.scheme["D"] }
M.colors["mailEmail"] = { fg = M.scheme["D"] }
-- }}}

-- Markdown highlighting {{{
M.colors["markdownCode"] = { fg = M.scheme["B"] }
M.colors["markdownError"] = { fg = M.scheme["5"], bg = M.scheme["0"] }
M.colors["markdownCodeBlock"] = { fg = M.scheme["B"] }
M.colors["markdownHeadingDelimiter"] = { fg = M.scheme["D"] }
-- }}}

-- PHP highlighting {{{
M.colors["phpMemberSelector"] = { fg = M.scheme["5"] }
M.colors["phpComparison"] = { fg = M.scheme["5"] }
M.colors["phpParent"] = { fg = M.scheme["5"] }
M.colors["phpMethodsVar"] = { fg = M.scheme["C"] }
-- }}}

-- Python highlighting {{{
M.colors["pythonOperator"] = { fg = M.scheme["E"] }
M.colors["pythonRepeat"] = { fg = M.scheme["E"] }
M.colors["pythonInclude"] = { fg = M.scheme["E"] }
M.colors["pythonStatement"] = { fg = M.scheme["E"] }
-- }}}

-- Ruby highlighting {{{
M.colors["rubyAttribute"] = { fg = M.scheme["D"] }
M.colors["rubyConstant"] = { fg = M.scheme["A"] }
M.colors["rubyInterpolationDelimiter"] = { fg = M.scheme["F"] }
M.colors["rubyRegexp"] = { fg = M.scheme["C"] }
M.colors["rubySymbol"] = { fg = M.scheme["B"] }
M.colors["rubyStringDelimiter"] = { fg = M.scheme["B"] }
-- }}}

-- SASS highlighting {{{
M.colors["sassidChar"] = { fg = M.scheme["8"] }
M.colors["sassClassChar"] = { fg = M.scheme["9"] }
M.colors["sassInclude"] = { fg = M.scheme["E"] }
M.colors["sassMixing"] = { fg = M.scheme["E"] }
M.colors["sassMixinName"] = { fg = M.scheme["D"] }
-- }}}

-- Spelling highlighting {{{
M.colors["SpellBad"] = { undercurl = true, sp = M.scheme["8"] }
M.colors["SpellLocal"] = { undercurl = true, sp = M.scheme["C"] }
M.colors["SpellCap"] = { undercurl = true, sp = M.scheme["D"] }
M.colors["SpellRare"] = { undercurl = true, sp = M.scheme["E"] }
-- }}}

-- Java highlighting {{{
M.colors["javaOperator"] = { fg = M.scheme["D"] }
-- }}}

M.colors["HighlightedyankRegion"] = { fg = M.scheme["0"], bg = M.scheme["A"] }

-- Git conflict markers {{{
M.colors["ConflictMarkerBegin"] = { fg = M.scheme["7"], bg = M.scheme["error"] }
M.colors["ConflictMarkerEnd"] = { fg = M.scheme["7"], bg = M.scheme["error"] }
M.colors["ConflictMarkerSeparator"] = { fg = M.scheme["7"], bg = M.scheme["error"] }
-- }}}

-- Hydra {{{
M.colors["HydraRed"] = { fg = M.scheme.red }
M.colors["HydraBlue"] = { fg = M.scheme.blue }
M.colors["HydraAmaranth"] = { fg = M.scheme.amaranth }
M.colors["HydraTeal"] = { fg = M.scheme.teal }
M.colors["HydraPink"] = { fg = M.scheme.pink }
-- }}}

-- FIXME: FIX THAT SHIT
-- -- Tasks comments {{{
-- M.colors["TasksFixme"] = { fg = M.scheme["7"], bg = M.scheme["error"], gui = "NONE" }
-- M.colors["TasksTodo"] = { fg = M.scheme["7"], bg = M.scheme["hint"], gui = "NONE" }
-- M.colors["TasksHack"] = { fg = M.scheme["7"], bg = M.scheme["hint"], gui = "NONE" }
-- M.colors["TasksWarn"] = { fg = M.scheme["7"], bg = M.scheme["warning"], gui = "NONE" }
-- M.colors["TasksPerf"] = { fg = M.scheme["7"], bg = M.scheme["warning"], gui = "NONE" }
-- M.colors["TasksNote"] = { fg = M.scheme["7"], bg = M.scheme["info"], gui = "NONE" }
-- -- }}}

return M
