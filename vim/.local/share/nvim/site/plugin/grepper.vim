" Plugin: vim-grepper
" Description: Helps you win at grep.
" URL: https://github.com/mhinz/vim-grepper

let g:grepper = {}
let g:grepper.operator = {}

let g:grepper.quickfix =  v:true
let g:grepper.open =      v:true
let g:grepper.switch =    v:true
let g:grepper.jump =      v:false
let g:grepper.highlight = v:true
let g:grepper.stop = 5000

let g:grepper.prompt = v:true
let g:grepper.prompt_quote =  v:true
let g:grepper.operator.prompt = v:true
let g:grepper.prompt_text = '$t> '
let g:grepper.prompt_mapping_tool = '<Tab>'

let g:grepper.repo = ['.git']
let g:grepper.tools = ['rg', 'git']
