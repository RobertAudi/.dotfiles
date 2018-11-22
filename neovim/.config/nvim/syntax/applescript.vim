"==============================================================================
"      FileName: applescript.vim
"      Language: AppleScript
"          Desc: Vim syntax file for applescript
"        Author: Zhao Cai
"         Email: caizhaoff@gmail.com
"      HomePage:
"       Version: 1.2
"  Date Created: Thu Nov 03, 2011  03:23AM
" Last Modified: Thu Nov 03, 2011  03:29AM
"    Maintainer: Jim Eberle <jim.eberle@fastnlight.com>
"           URL: http://www.fastnlight.com/syntax/applescript.vim
"
"       History: 1.1 Fork
"		 1.2 Syntax: Continue
"==============================================================================

scriptencoding utf8

if exists('b:current_syntax')
  finish
endif

" Allow use of line continuation.
let s:save_cpo = &cpo
set cpo&vim

" --- Statement ---
syntax keyword scptStmt get set count copy global local prop property
syntax keyword scptStmt close put delete duplicate exists
syntax keyword scptStmt launch open print quit make move reopen save
syntax keyword scptStmt saving into
highlight def link scptStmt Statement

" --- Type ---
syntax keyword scptType text string number integer real color date
highlight def link scptType Type

" --- Operator ---
syntax keyword scptOp div mod not and or as
syntax match   scptOp "[-+*/^&]"
" MacRoman single char :- (divide)
execute 'syntax match scptOp "' . nr2char(214) . '"'
syntax match scptOp "\<\(a \)\?\(ref\( to\)\?\|reference to\)\>"
highlight def link scptOp Operator

" Containment
syntax match   scptIN "\<starts\? with\>"
syntax match   scptIN "\<begins\? with\>"
syntax match   scptIN "\<ends\? with\>"
syntax match   scptIN "\<contains\>"
syntax match   scptIN "\<does not contain\>"
syntax match   scptIN "\<doesn't contain\>"
syntax match   scptIN "\<is in\>"
syntax match   scptIN "\<is contained by\>"
syntax match   scptIN "\<is not in\>"
syntax match   scptIN "\<is not contained by\>"
syntax match   scptIN "\<isn't contained by\>"
highlight def link scptIN scptOp

" Equals
syntax match   scptEQ "="
syntax match   scptEQ "\<equal\>"
syntax match   scptEQ "\<equals\>"
syntax match   scptEQ "\<equal to\>"
syntax match   scptEQ "\<is\>"
syntax match   scptEQ "\<is equal to\>"
highlight def link scptEQ scptOp

" Not Equals
syntax match   scptNE "\<does not equal\>"
syntax match   scptNE "\<doesn't equal\>"
syntax match   scptNE "\<is not\>"
syntax match   scptNE "\<is not equal\( to\)\?\>"
syntax match   scptNE "\<isn't\>"
syntax match   scptNE "\<isn't equal\( to\)\?\>"
highlight def link scptNE scptOp
" MacRoman single char /=
execute 'syntax match scptNE "' . nr2char(173) . '"'

" Less Than
syntax match   scptLT "<"
syntax match   scptLT "\<comes before\>"
syntax match   scptLT "\(is \)\?less than"
syntax match   scptLT "\<is not greater than or equal\( to\)\?\>"
syntax match   scptLT "\<isn't greater than or equal\( to\)\?\>"
highlight def link scptLT scptOp

" Greater Than
syntax match   scptGT ">"
syntax match   scptGT "\<comes after\>"
syntax match   scptGT "\(is \)\?greater than"
syntax match   scptGT "\<is not less than or equal\( to\)\?\>"
syntax match   scptGT "\<isn't less than or equal\( to\)\?\>"
highlight def link scptGT scptOp

" Less Than or Equals
syntax match   scptLE "<="
syntax match   scptLE "\<does not come after\>"
syntax match   scptLE "\<doesn't come after\>"
syntax match   scptLE "\(is \)\?less than or equal\( to\)\?"
syntax match   scptLE "\<is not greater than\>"
syntax match   scptLE "\<isn't greater than\>"
highlight def link scptLE scptOp
" MacRoman single char <=
execute 'syntax match scptLE "'.nr2char(178).'"'

" Greater Than or Equals
syntax match   scptGE ">="
syntax match   scptGE "\<does not come before\>"
syntax match   scptGE "\<doesn't come before\>"
syntax match   scptGE "\(is \)\?greater than or equal\( to\)\?"
syntax match   scptGE "\<is not less than\>"
syntax match   scptGE "\<isn't less than\>"
highlight def link scptGE scptOp
" MacRoman single char >=
execute 'syntax match scptGE "'.nr2char(179).'"'

" --- Constant String ---
syntax region  scptString start=+"+ skip=+\\\\\|\\"+ end=+"+
highlight def link scptString String

" --- Constant Number ---
syntax match   scptNumber "\<-\?\d\+\>"
highlight def link scptNumber Number

" --- Constant Float ---
syntax match   scptFloat display contained "\d\+\.\d*\(e[-+]\=\d\+\)\="
syntax match   scptFloat display contained "\.\d\+\(e[-+]\=\d\+\)\=\>"
syntax match   scptFloat display contained "\d\+e[-+]\>"
highlight def link scptFloat Float

" --- Constant Boolean ---
syntax keyword scptBoolean true false yes no ask
highlight def link scptBoolean Boolean

" --- Other Constants ---
syntax keyword scptConst it me version pi result space tab anything
syntax match   scptConst "\<missing value\>"

" Considering and Ignoring
syntax match   scptConst "\<application responses\>"
syntax match   scptConst "\<current application\>"
syntax match   scptConst "\<white space\>"
syntax keyword scptConst case diacriticals expansion hyphens punctuation
highlight def link scptConst Constant

" Style
syntax match   scptStyle "\<all caps\>"
syntax match   scptStyle "\<all lowercase\>"
syntax match   scptStyle "\<small caps\>"
syntax keyword scptStyle bold condensed expanded hidden italic outline plain
syntax keyword scptStyle shadow strikethrough subscript superscript underline
highlight def link scptStyle scptConst

" Day
syntax keyword scptDay Mon Tue Wed Thu Fri Sat Sun
syntax keyword scptDay Monday Tuesday Wednesday Thursday Friday Saturday Sunday
syntax keyword scptDay weekday
highlight def link scptDay scptConst

" Month
syntax keyword scptMonth Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec
syntax keyword scptMonth January February March
syntax keyword scptMonth April May June
syntax keyword scptMonth July August September
syntax keyword scptMonth October November December
syntax keyword scptMonth month
highlight def link scptMonth scptConst

" Time
syntax keyword scptTime minutes hours days weeks
highlight def link scptTime scptConstant
"

" --- function ---
syntax region  scptFunctionBlock  matchgroup=scptFunction start="^\(on\|to\) \z([a-zA-Z0-9_]\+\)\ze(.*)" end="^end \z1$" transparent fold
highlight def link scptFunction Function

" --- handler ---
syntax region  scptHandler  matchgroup=scptHandler start="^\<on \z(run\|open\|reopen\|activate\|idle\)\>" end="^end \z1$" transparent fold skipwhite
highlight def link scptHandler Method

" --- Conditional ---
syntax keyword scptCond if then else
syntax match   scptCond "\<end if\>"
highlight def link scptCond Conditional
"
" --- Tell ---
syntax region  scptTell  matchgroup=scptTell start="<\tell\>" end="\<end tell\>" transparent skipwhite
syntax match   scptTell "\<end tell\>"
highlight def link scptTell SpecialStatement

" --- Repeat ---
syntax keyword scptRepeat repeat with from to by continue
syntax match   scptRepeat "\<repeat while\>"
syntax match   scptRepeat "\<repeat until\>"
syntax match   scptRepeat "\<repeat with\>"
syntax match   scptRepeat "\<end repeat\>"
highlight def link scptRepeat Repeat

" --- Exception ---
syntax keyword scptException try error
syntax match   scptException "\<on error\>"
syntax match   scptException "\<end try\>"
syntax match   scptException "\<end error\>"
highlight def link scptException Exception

" --- Keyword ---
syntax keyword scptKeyword run times exit
syntax keyword scptKeyword application file alias activate
syntax keyword scptKeyword script return without given
syntax keyword scptKeyword considering ignoring items delimiters
syntax keyword scptKeyword some each every whose where id index item its
syntax keyword scptKeyword first second third fourth fifth sixth seventh
syntax keyword scptKeyword eighth ninth tenth container
syntax match   scptKeyword "\d\+\(st\|nd\|rd\|th\)"
syntax keyword scptKeyword last front back middle named thru through
syntax keyword scptKeyword before after in of the
syntax match   scptKeyword "\<text \>"
syntax match   scptKeyword "\<partial result\>"
syntax match   scptKeyword "\<but ignoring\>"
syntax match   scptKeyword "\<but considering\>"
syntax match   scptKeyword "\<with timeout\>"
syntax match   scptKeyword "\<with transaction\>"
syntax match   scptKeyword "\<do script\>"
syntax match   scptKeyword "\<POSIX path\>"
syntax match   scptKeyword "\<quoted form\>"
syntax match   scptKeyword "'s"
highlight def link scptKeyword Keyword

" US Units
syntax keyword scptUnitUS quarts gallons ounces pounds inches feet yards miles
syntax match   scptUnitUS "\<square feet\>"
syntax match   scptUnitUS "\<square yards\>"
syntax match   scptUnitUS "\<square miles\>"
syntax match   scptUnitUS "\<cubic inches\>"
syntax match   scptUnitUS "\<cubic feet\>"
syntax match   scptUnitUS "\<cubic yards\>"
syntax match   scptUnitUS "\<degrees Fahrenheit\>"
highlight def link scptUnitUS scptKey

" British Units
syntax keyword scptUnitBT litres centimetres metres kilometres
syntax match   scptUnitBT "\<square metres\>"
syntax match   scptUnitBT "\<square kilometres\>"
syntax match   scptUnitBT "\<cubic centimetres\>"
syntax match   scptUnitBT "\<cubic metres\>"
highlight def link scptUnitBT scptKey

" Metric Units
syntax keyword scptUnitMT liters centimeters meters kilometers grams kilograms
syntax match   scptUnitMT "\<square meters\>"
syntax match   scptUnitMT "\<square kilometers\>"
syntax match   scptUnitMT "\<cubic centimeters\>"
syntax match   scptUnitMT "\<cubic meters\>"
syntax match   scptUnitMT "\<degrees Celsius\>"
syntax match   scptUnitMT "\<degrees Kelvin\>"
highlight def link scptUnitMT scptKey

" --- Comment ---
syntax region  scptComment	start="--" skip="--$" end="$" keepend contains=scptTodo
syntax region  scptComment	start="#" skip="#$" end="$" keepend contains=scptTodo
syntax region  scptComment start="(\*" end="\*)" contains=scptTodo fold
highlight def link scptComment Comment

" --- Todo ---
syntax keyword scptTodo containedin=scptComment contained TODO FIXME XXX
highlight def link scptTodo Todo

" --- Continue ---
syntax match   scptContinue "¬"
highlight def link scptContinue SpecialChar

syntax sync fromstart

let b:current_syntax = 'applescript'

let &cpo = s:save_cpo
unlet s:save_cpo
