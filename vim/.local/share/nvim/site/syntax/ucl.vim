if exists('b:current_syntax')
  finish
end

let b:current_syntax = 'ucl'

syntax match uclVariable '\$\%([\w_\-]\+\|{[\w_\-]\+}\)'

syntax match uclComment '#.*$'
syntax region uclComment matchgroup=uclComment start='/\*' end='\*/'

syntax region uclString start=/"/ skip=/\\"/ end=/"/
syntax region uclHereDocText matchgroup=uclString start="<<[-~.]*\z([A-Z]\+\)" end="^\s*\z1" contains=NONE

syntax match uclInteger '\W\<\zs\-\?\d\+[kmgdmsy]\?\>\ze\W'

syntax match uclFloat '\W\<\zs\%(\d\+\.\d*\|\d*\.\d\+\)\%([eE][+\-]\?[0-9]\+\)\?j\?\>\ze\W'
syntax match uclFloat '\W\<\zs\-\?\d\+[eE][+\-]\?[0-9]\+j\?\>\ze\W'
syntax match uclFloat '\W\<\zs\-\?\d\+\.\?\d*\>\ze\W'

syntax keyword uclBoolean true false on off yes no

syntax match uclOperator "\v\+"
syntax match uclOperator "\v-"
syntax match uclOperator "\v\*\="
syntax match uclOperator "\v/\="

syntax region uclBlock start=+^+ end=+{+ skip=+\${\|{{\|{%+ contains=uclComment,uclInteger,uclFloat,uclBoolean,uclOperator,uclString,uclOperator oneline

highlight link uclVariable Identifier
highlight link uclComment Comment
highlight link uclInteger Number
highlight link uclFloat Number
highlight link uclString String
highlight link uclBoolean Boolean
highlight link rspamdOperator Operator
highlight link uclBlock Normal
