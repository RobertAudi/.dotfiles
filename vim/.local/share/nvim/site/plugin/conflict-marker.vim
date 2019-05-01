" Plugin: conflict-marker.vim
" Description: Weapon to fight against conflicts in Vim.
" URL: https://github.com/rhysd/conflict-marker.vim

let g:conflict_marker_enable_mappings = 0

nmap <buffer>]x <Plug>(conflict-marker-next-hunk)
nmap <buffer>[x <Plug>(conflict-marker-prev-hunk)
