" Plugin: denite.nvim
" Description: Dark powered asynchronous unite all interfaces for Neovim
" URL: https://github.com/Shougo/denite.nvim

" Interface
" ------------------------------------------------------------------------------
call denite#custom#option('default', {
      \   'auto_accel': v:true,
      \   'auto_resize': v:true,
      \   'auto_resume': v:true,
      \   'empty': v:true,
      \   'highlight_matched_char': 'Bold',
      \   'prompt': '>',
      \   'reversed': v:true,
      \   'smartcase': v:true,
      \   'source_names': '',
      \   'unique': v:true,
      \   'updatetime': 1,
      \   'vertical_preview': v:false,
      \   'winheight': 15,
      \ })

" Sources {{{
" ------------------------------------------------------------------------------

" file/rec source
" ------------------------------------------------------------------------------
if executable('fd')
  call denite#custom#var('file/rec', 'command', x2a#fuzzy#denite#commands#fd())
elseif executable('ag')
  call denite#custom#var('file/rec', 'command', x2a#fuzzy#denite#commands#ag())
elseif executable('rg')
  call denite#custom#var('file/rec', 'command', x2a#fuzzy#denite#commands#rg())
endif

call denite#custom#source('file/rec', 'matchers',
      \ ['matcher/fruzzy', 'matcher/ignore_current_buffer'])

call denite#custom#source('file/rec', 'sorters',
      \ ['sorter/sublime'])

" buffer source
" ------------------------------------------------------------------------------
call denite#custom#source('buffer', 'matchers',
      \ ['matcher/fruzzy', 'matcher/ignore_current_buffer'])

" ------------------------------------------------------------------------------ }}}

" Denite mappings {{{
" ------------------------------------------------------------------------------

call denite#custom#map(
      \   'insert',
      \   '<C-n>',
      \   '<denite:move_to_next_line>',
      \   'noremap'
      \ )

call denite#custom#map(
      \   'insert',
      \   '<C-p>',
      \   '<denite:move_to_previous_line>',
      \   'noremap'
      \ )

call denite#custom#map(
      \   'insert',
      \   '<Down>',
      \   '<denite:move_to_next_line>',
      \   'noremap'
      \ )

call denite#custom#map(
      \   'insert',
      \   '<Up>',
      \   '<denite:move_to_previous_line>',
      \   'noremap'
      \ )

call denite#custom#map(
      \   'insert',
      \   '<C-s>',
      \   '<denite:do_action:split>',
      \   'noremap'
      \ )

call denite#custom#map(
      \   'insert',
      \   '<C-x>',
      \   '<denite:do_action:split>',
      \   'noremap'
      \ )

call denite#custom#map(
      \   'insert',
      \   '<C-v>',
      \   '<denite:do_action:vsplit>',
      \   'noremap'
      \ )

call denite#custom#map(
      \   'insert',
      \   '<C-t>',
      \   '<denite:do_action:tabopen>',
      \   'noremap'
      \ )

call denite#custom#map(
      \   'insert',
      \   '<Right>',
      \   '<denite:jump_to_next_source>',
      \   'noremap'
      \ )

call denite#custom#map(
      \   'insert',
      \   '<Left>',
      \   '<denite:jump_to_previous_source>',
      \   'noremap'
      \ )

call denite#custom#map(
      \   'insert',
      \   '<C-f>',
      \   '<denite:jump_to_next_source>',
      \   'noremap'
      \ )

call denite#custom#map(
      \   'insert',
      \   '<C-b>',
      \   '<denite:jump_to_previous_source>',
      \   'noremap'
      \ )

call denite#custom#map(
      \   'insert',
      \   '<C-r>',
      \   '<denite:nop>',
      \   'noremap'
      \ )

" ------------------------------------------------------------------------------ }}}

" Denite Rails {{{
" ------------------------------------------------------------------------------

command! -nargs=0 Dmodel      Denite rails:model
command! -nargs=0 Dcontroller Denite rails:controller
command! -nargs=0 Dview       Denite rails:view
command! -nargs=0 Dhelper     Denite rails:helper
command! -nargs=0 Dtest       Denite rails:test
command! -nargs=0 Dspec       Denite rails:spec

" ------------------------------------------------------------------------------ }}}

" Maps {{{
" ------------------------------------------------------------------------------

nnoremap <C-b> <Cmd>Denite buffer<CR>

" ------------------------------------------------------------------------------ }}}

" Modeline {{{
" vim: set foldmarker={{{,}}} foldlevel=0 foldmethod=marker : }}}
