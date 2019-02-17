" Originally taken from https://github.com/ap4y/dotfiles/blob/master/vim/after/syntax/objc.vim

" Type modifiers
syntax keyword objcTypeModifier
      \ __autoreleasing
      \ __block
      \ __bridge
      \ __bridge_retained
      \ __bridge_transfer
      \ __strong
      \ __typeof
      \ __unsafe_unretained
      \ __weak

" Property keywords - these are only highlighted inside '@property (...)'
syntax keyword objcPropertyAttribute contained
      \ assign
      \ copy
      \ getter
      \ nonatomic
      \ readonly
      \ readwrite
      \ retain
      \ setter
      \ strong
      \ weak

syntax match objcProperty display "^\s*@property\>\s*([^)]*)" contains=objcPropertyAttribute

" The @property directive must be defined after objcProperty or it won't be
" highlighted
syntax match objcDirective "@property\|@synthesize\|@dynamic\|@package"

syntax match objcPointerClass "\v\h+(\s*[*])@="
syntax match objcDotProperty "\v(\.)@<=\h+"
syntax match objcInstanceVariable "\(*\|\[\| \)\@<=_\h\+"

syntax match objcCFunction "\v\w+[(]@="
syntax match objcPrimitives "NSInteger\|NSUInteger\|CGFloat\|NSTimeInterval"

syntax region objc2Hash transparent matchgroup=objc2HashBraces start="@{" end="}"
syntax region objc2Array transparent matchgroup=objc2ArrayBraces start="@\[" end="]"
syntax region objc2Number transparent matchgroup=objc2NumberBraces start="@(" end=")"
syntax region objc2Block transparent matchgroup=objc2BlockBraces start="\(\^.*\)\@<={" end="}"

syntax match objcMessageName "\s\@<=\w*\(]\|:\)\@=" contained
syntax match objcMessageClass "\(\[\s*\)\@<=\u\w*" contained
syntax region objcCorrectMessage transparent matchgroup=objCorrectMessage start="\[" end="\]"
      \ contains=objc.*,cConditional,cStatement

syntax keyword objcWrappedConstant
      \ nil
      \ NO
      \ NULL
      \ YES

syntax keyword objcIBRWords
      \ IBAction
      \ IBOutlet

" link to the standard
highlight def link objcTypeModifier      Statement
highlight def link objcProperty          Statement
highlight def link objcDirective         Statement
highlight def link objcPropertyAttribute Statement
highlight def link objcPointerClass      objcPointer
highlight def link objcMessageClass      objcPointer
highlight def link objcDotProperty       Identifier
highlight def link objcInstanceVariable  Identifier
highlight def link objc2HashBraces       Constant
highlight def link objc2ArrayBraces      Constant
highlight def link objc2NumberBraces     Constant
highlight def link objcMessageName       Function
highlight def link objcCFunction         Operator
highlight def link objcSpecial           String
highlight def link objcWrappedConstant   Statement
highlight def link objcIBRWords          Statement
highlight def link objcPointer           Type
highlight def link objcPrimitives        cType
