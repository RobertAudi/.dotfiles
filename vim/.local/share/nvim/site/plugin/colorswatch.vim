" Plugin: colorswatch.vim
" Description: Generate a beautiful color swatch for the current buffer
" URL: https://github.com/cocopon/colorswatch.vim

" Variables {{{
" ------------------------------------------------------------------------------

let g:x2a#colorswatch#source_name = 'original'
let g:x2a#colorswatch#formatter_name = 'minimal'
let g:x2a#colorswatch#exclusion_patterns =
      \   [
      \     'LightLine',
      \     'Neomake',
      \     'NERDTree',
      \     'GitGutter',
      \     'Startify',
      \     'colorSwatch',
      \     'ctrlsf',
      \     'denite',
      \   ]

let g:colorswatch_exclusion_pattern = '\%(' . join(g:x2a#colorswatch#exclusion_patterns, '\|') . '\).\+'

" ------------------------------------------------------------------------------ }}}

command! -nargs=0 ColorSwatch call x2a#colorswatch#generate()
command! -nargs=* ColorSwatchGenerate call x2a#colorswatch#generate(<f-args>)

" Modeline {{{
" vim: set foldmarker={{{,}}} foldlevel=0 foldmethod=marker : }}}
