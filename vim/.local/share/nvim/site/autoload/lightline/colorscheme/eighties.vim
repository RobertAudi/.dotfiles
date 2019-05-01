" Plugin: lightline.vim
" Description: Base16 Eighties lightline colorscheme
" Author: Robert Audi
" URL: https://github.com/itchyny/lightline.vim

" Color definitions {{{
" ------------------------------------------------------------------------------

" GUI color definitions
let s:gui00 = '#2d2d2d'
let s:gui01 = '#393939'
let s:gui02 = '#515151'
let s:gui03 = '#747369'
let s:gui04 = '#a09f93'
let s:gui05 = '#d3d0c8'
let s:gui06 = '#e8e6df'
let s:gui07 = '#f2f0ec'
let s:gui08 = '#f2777a'
let s:gui09 = '#f99157'
let s:gui0A = '#ffcc66'
let s:gui0B = '#99cc99'
let s:gui0C = '#66cccc'
let s:gui0D = '#6699cc'
let s:gui0E = '#cc99cc'
let s:gui0F = '#d27b53'

" Terminal color definitions
let s:cterm00 = '00'
let s:cterm03 = '08'
let s:cterm05 = '07'
let s:cterm07 = '15'
let s:cterm08 = '01'
let s:cterm0A = '03'
let s:cterm0B = '02'
let s:cterm0C = '06'
let s:cterm0D = '04'
let s:cterm0E = '05'
if exists('base16colorspace') && base16colorspace ==# '256'
  let s:cterm01 = '18'
  let s:cterm02 = '19'
  let s:cterm04 = '20'
  let s:cterm06 = '21'
  let s:cterm09 = '16'
  let s:cterm0F = '17'
else
  let s:cterm01 = '10'
  let s:cterm02 = '11'
  let s:cterm04 = '12'
  let s:cterm06 = '13'
  let s:cterm09 = '09'
  let s:cterm0F = '14'
endif

let s:base03  = [s:gui00, s:cterm00]
let s:base02  = [s:gui01, s:cterm01]
let s:base01  = [s:gui02, s:cterm02]
let s:base00  = [s:gui03, s:cterm03]
let s:base0   = [s:gui04, s:cterm04]
let s:base1   = [s:gui05, s:cterm05]
let s:base2   = [s:gui06, s:cterm06]
let s:base3   = [s:gui07, s:cterm07]
let s:red     = [s:gui08, s:cterm08]
let s:orange  = [s:gui09, s:cterm09]
let s:yellow  = [s:gui0A, s:cterm0A]
let s:green   = [s:gui0B, s:cterm0B]
let s:cyan    = [s:gui0C, s:cterm0C]
let s:blue    = [s:gui0D, s:cterm0D]
let s:magenta = [s:gui0E, s:cterm0E]

" ------------------------------------------------------------------------------ }}}

" Components {{{
" ------------------------------------------------------------------------------

let s:p = { 'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

"   s:p.{mode}.{where}  = [ [ {fg},      {bg}      ],    ...                     ]
let s:p.normal.left     = [ [ s:base02,  s:blue    ],    [ s:base3,   s:base01 ] ]
let s:p.normal.middle   = [ [ s:base0,   s:base02  ]                             ]
let s:p.normal.right    = [ [ s:base02,  s:base0   ],    [ s:base2,   s:base01 ] ]
let s:p.normal.warning  = [ [ s:yellow,  s:base01  ]                             ]
let s:p.normal.error    = [ [ s:red,     s:base02  ]                             ]

let s:p.insert.left     = [ [ s:base02,  s:green   ],    [ s:base3,   s:base01 ] ]
let s:p.visual.left     = [ [ s:base02,  s:magenta ],    [ s:base3,   s:base01 ] ]
let s:p.replace.left    = [ [ s:base02,  s:red     ],    [ s:base3,   s:base01 ] ]

let s:p.inactive.left   = [ [ s:base0,   s:base02  ],    [ s:base00,  s:base02 ] ]
let s:p.inactive.middle = [ [ s:base00,  s:base02  ]                             ]
let s:p.inactive.right  = [ [ s:base02,  s:base00  ],    [ s:base0,   s:base02 ] ]

let s:p.tabline.left    = [ [ s:base3,   s:base00  ]                             ]
let s:p.tabline.middle  = [ [ s:base01,  s:base0   ]                             ]
let s:p.tabline.right   = [ [ s:base02,  s:base0   ],    [ s:base2,   s:base01 ] ]
let s:p.tabline.tabsel  = [ [ s:base3,   s:base02  ]                             ]

" ------------------------------------------------------------------------------ }}}

let g:lightline#colorscheme#eighties#palette = lightline#colorscheme#flatten(s:p)

" Modeline {{{
" vim: set foldmarker={{{,}}} foldlevel=0 foldmethod=marker : }}}
