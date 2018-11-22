" ==============================================================================
" File: {{_expr_:expand('%:t')}}
" Location:	plugin/{{_expr_:expand('%:t')}}
" Maintainer: {{_input_:author}}
" Last Change: {{_expr_:strftime('%d/%m/%Y')}}
" ==============================================================================

" Vimscript Setup                                                            {{{
" ------------------------------------------------------------------------------
" Allow use of line continuation.
let s:save_cpo = &cpo
set cpo&vim

" load guard
if exists('g:loaded_{{_expr_:expand("%:t:r")}}')
      \ || v:version < 700
      \ || v:version == 703 && !has('patch338')
      \ || &compatible
  let &cpo = s:save_cpo
  finish
endif
let g:loaded_{{_expr_:expand("%:t:r")}} = 1

"                                                                            }}}
" ------------------------------------------------------------------------------

{{_cursor_}}

" Teardown                                                                   {{{
" ------------------------------------------------------------------------------
" reset &cpo back to users setting
let &cpo = s:save_cpo

"                                                                            }}}
" ------------------------------------------------------------------------------

" vim:set ts=2 sw=2 sts=2 et:
