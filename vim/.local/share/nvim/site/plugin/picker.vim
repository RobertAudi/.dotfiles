" Plugin: vim-picker
" Description: A fuzzy picker for Neovim and Vim
" URL: https://github.com/srstevenson/vim-picker

if executable('fd')
  let g:picker_custom_find_executable = 'fd'
  let g:picker_custom_find_flags = x2a#fuzzy#picker#find#flags('fd')
elseif executable('ag')
  let g:picker_custom_find_executable = 'ag'
  let g:picker_custom_find_flags = x2a#fuzzy#picker#find#flags('ag')
elseif executable('rg')
  let g:picker_custom_find_executable = 'rg'
  let g:picker_custom_find_flags = x2a#fuzzy#picker#find#flags('rg')
endif

nmap <silent> <C-p> <Cmd>call x2a#utils#echo#Warning('Use one of e, s, x, v or t.')<CR>
nmap <silent> <C-p><C-p> <Cmd>call x2a#utils#echo#Warning('Use one of e, s, x, v or t.')<CR>

nmap <silent> <C-p>e <Plug>(PickerEdit)
nmap <silent> <C-p>s <Plug>(PickerSplit)
nmap <silent> <C-p>x <Plug>(PickerSplit)
nmap <silent> <C-p>v <Plug>(PickerVsplit)
nmap <silent> <C-p>t <Plug>(PickerTabedit)

nmap <silent> <C-p><C-e> <Plug>(PickerEdit)
nmap <silent> <C-p><C-s> <Plug>(PickerSplit)
nmap <silent> <C-p><C-x> <Plug>(PickerSplit)
nmap <silent> <C-p><C-v> <Plug>(PickerVsplit)
nmap <silent> <C-p><C-t> <Plug>(PickerTabedit)

nmap <silent> <C-b> <Plug>(PickerBuffer)
