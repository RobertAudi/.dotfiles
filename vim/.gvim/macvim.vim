if !has('gui_running') && !has('gui_macvim')
  finish
endif

set guifont=Input:h14
set antialias

" " Enable <M- mappings (?)
" set macmeta

" Command-Return for fullscreen
macmenu Window.Toggle\ Full\ Screen\ Mode key=<D-CR>

" Next and previous tab
macmenu Window.Select\ Next\ Tab Key=<D-}>
macmenu Window.Select\ Previous\ Tab key=<D-{>

" Disable ALL MacVim menu keybindings
macmenu File.New\ Window                       key=<Nop>
macmenu File.Open\.\.\.                        key=<Nop>
macmenu File.Open\ Tab\.\.\.                   key=<Nop>
macmenu File.Close\ Window                     key=<Nop>
macmenu File.Close                             key=<Nop>
macmenu File.Save                              key=<Nop>
macmenu File.Save\ All                         key=<Nop>
macmenu File.Save\ As\.\.\.                    key=<Nop>
macmenu File.Print                             key=<Nop>
macmenu Edit.Undo                              key=<Nop>
macmenu Edit.Redo                              key=<Nop>
macmenu Edit.Cut                               key=<Nop>
macmenu Edit.Select\ All                       key=<Nop>
macmenu Edit.Find.Find\.\.\.                   key=<Nop>
macmenu Edit.Find.Find\ Next                   key=<Nop>
macmenu Edit.Find.Find\ Previous               key=<Nop>
macmenu Edit.Find.Use\ Selection\ for\ Find    key=<Nop>
macmenu Edit.Emoji\ &\ Symbols                 key=<Nop>
macmenu Tools.Spelling.To\ Next\ Error         key=<Nop>
macmenu Tools.Spelling.Suggest\ Corrections    key=<Nop>
macmenu Tools.Make                             key=<Nop>
macmenu Tools.List\ Errors                     key=<Nop>
macmenu Tools.Next\ Error                      key=<Nop>
macmenu Tools.Previous\ Error                  key=<Nop>
macmenu Tools.Older\ List                      key=<Nop>
macmenu Tools.Newer\ List                      key=<Nop>
macmenu Window.Minimize                        key=<Nop>
macmenu Window.Minimize\ All                   key=<Nop>
macmenu Window.Zoom                            key=<Nop>
macmenu Window.Zoom\ All                       key=<Nop>
macmenu Help.MacVim\ Help                      key=<Nop>

" Do not exit visual mode when shifting
vnoremap <silent> <D-]> >gv
vnoremap <silent> <D-[> <gv

nnoremap <silent> <D-]> >>
nnoremap <silent> <D-[> <<

" Map Command-# to switch tabs.
nnoremap <D-0> 0gt
nnoremap <D-1> 1gt
nnoremap <D-2> 2gt
nnoremap <D-3> 3gt
nnoremap <D-4> 4gt
nnoremap <D-5> 5gt
nnoremap <D-6> 6gt
nnoremap <D-7> 7gt
nnoremap <D-8> 8gt
nnoremap <D-9> 9gt

" Map Command-Shift-] and Command-Shift-[
" to switch to the next/previous tab.
nnoremap <D-}> gt
nnoremap <D-{> gT
