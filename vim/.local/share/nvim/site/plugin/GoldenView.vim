" Plugin: GoldenView.vim
" Description: Always have a nice view for vim split windows!
" URL: https://github.com/RobertAudi/GoldenView.vim

let g:goldenview__enable_at_startup = 1

let g:goldenview__ignore_urule = get(g:, 'goldenview__ignore_urule', {})
let g:goldenview__ignore_urule['bufname'] = get(g:goldenview__ignore_urule, 'bufname', [])
let g:goldenview__ignore_urule['buftype'] = get(g:goldenview__ignore_urule, 'buftype', [])
let g:goldenview__ignore_urule['filetype'] = get(g:goldenview__ignore_urule, 'filetype', [])

let g:goldenview__ignore_urule['bufname'] = extend(g:goldenview__ignore_urule['bufname'], ['__vista__'])
let g:goldenview__ignore_urule['filetype'] = extend(g:goldenview__ignore_urule['filetype'], ['vista'])
