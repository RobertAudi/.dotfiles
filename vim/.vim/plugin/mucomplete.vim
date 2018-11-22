let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#always_use_completeopt = 1
let g:mucomplete#cycle_all = 1

let g:mucomplete#chains = {}

let g:mucomplete#chains.default  = ['path', 'omni', 'keyn']

if x2a#utils#plugins#isInstalled('ultisnips')
  let g:mucomplete#chains.default += ['ulti']
endif

let g:mucomplete#chains.default += ['dict', 'uspl']

let g:mucomplete#chains.vim = ['path', 'cmd', 'keyn']

inoremap <silent> <plug>(MUcompleteFwdKey) <Right>
imap     <Right>  <plug>(MUcompleteCycFwd)
inoremap <silent> <plug>(MUcompleteBwdKey) <Left>
imap     <Left>   <plug>(MUcompleteCycBwd)
