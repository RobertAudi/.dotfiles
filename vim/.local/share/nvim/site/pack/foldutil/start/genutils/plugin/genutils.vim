" genutils: Useful buffer, file and window related functions.
" Author: Hari Krishna Dara (hari_vim at yahoo dot com)
" Last Change: 15-Sep-2009 @ 19:25
" Requires: Vim-7.0
" Version: 2.5.1
" Licence: This program is free software; you can redistribute it and/or
"          modify it under the terms of the GNU General Public License.
"          See http://www.gnu.org/copyleft/gpl.txt
" Acknowledgements:
"     - The genutils#GetNextWinnrInStack() function is based on the WinStackMv()
"       function posted by Charles E. Campbell, Jr. on vim mailing list on Jul
"       14, 2004.
"     - The genutils#CommonPath() function is based on the thread,
"       "computing relative path" on Jul 29, 2002.
"     - The genutils#ShowLinesWithSyntax() function is based on a posting by
"       Gary Holloway (gary at castandcrew dot com) on Jan, 16 2002.
"     - Robert Webb for the original "quick sort" algorithm from eval.txt.
"     - Peit Delport's (pjd at 303 dot za dot net) for his original BISort()
"       algorithm on which the genutils#BinInsertSort() and
"       genutils#BinInsertSort2() functions are based on.
" Download From:
"     http://www.vim.org/script.php?script_id=197
" See Also: autoload/genutils.vim

if exists('g:loaded_genutils')
  finish
endif

if v:version < 700
  echomsg 'genutils: You need at least Vim 7.0'

  finish
endif

let g:loaded_genutils = 205
