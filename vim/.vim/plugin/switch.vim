" Definitions {{{
" ==============================================================================

let g:switch_no_builtins = 1

" TODO: Customize 'ruby_array_shorthand' to work with other delimiters (eg: `%w[]`)
let s:switch_builtins =
      \ {
      \   'ampersands': ['&&', '||'],
      \   'ruby_hash_style': {
      \     ':\(\k\+\)\s*=>\s*': '\1: ',
      \     '\<\(\k\+\): ':      ':\1 => ',
      \   },
      \   'ruby_lambda': {
      \     'lambda\s*{\s*|\([^|]\+\)|': '->(\1) {',
      \     '->\s*(\([^)]\+\))\s*{': 'lambda { |\1|',
      \     'lambda\s*{': '-> {',
      \     '->\s*{': 'lambda {'
      \   },
      \   'ruby_string': {
      \     '"\(\k\+\%([?!]\)\=\)"':                '''\1''',
      \     '''\(\k\+\%([?!]\)\=\)''':              ':\1',
      \     ':\(\k\+\%([?!]\)\=\)\@>\%(\s*=>\)\@!': '"\1"\2',
      \   },
      \   'ruby_array_shorthand': {
      \     '\[\%(\k\|[''", ]\)\+\]': {
      \       '\[':                    '%w(',
      \       '[''"]\(\k\+\)[''"],\=': '\1',
      \       ']':                     ')',
      \     },
      \     '%w(\%(\k\|\s\)\+)': {
      \       '%w(':      '[',
      \       '\(\k\+\) ': '''\1'', ',
      \       '\(\k\+\))': '''\1'']',
      \     },
      \     '\[\%(\k\|[:, ]\)\+\]': {
      \       '\[':           '%i(',
      \       ':\(\k\+\),\=': '\1',
      \       ']':            ')',
      \     },
      \     '%i(\%(\k\|\s\)\+)': {
      \       '%i(':      '[',
      \       '\(\k\+\) ': ':\1, ',
      \       '\(\k\+\))': ':\1]',
      \     },
      \   },
      \   'ruby_fetch': {
      \     '\(\k\+\)\[\(.\{-}\)\]': '\1.fetch(\2)',
      \     '\(\k\+\)\.fetch(\(.\{-}\))': '\1[\2]',
      \   },
      \ }

let g:switch_custom_definitions =
      \ [
      \   s:switch_builtins.ampersands,
      \   switch#NormalizedCase(['true', 'false']),
      \   ['Yes', 'No'],
      \   ['YES', 'NO'],
      \   ['left', 'right'],
      \   ['signed', 'unsigned'],
      \   ['!=', '=='],
      \   ['show', 'hide'],
      \   ['top', 'bottom'],
      \   ['min', 'max']
      \ ]

let s:switch_filetype_definitions = {}

" CSS definitions {{{
" ------------------------------------------------------------------------------

let s:switch_filetype_definitions.css =
      \ [
      \    ['padding', 'margin']
      \ ]

" ------------------------------------------------------------------------------ }}}

" Ruby definitions {{{
" ------------------------------------------------------------------------------

let s:switch_filetype_definitions.ruby = []

let s:switch_filetype_definitions.ruby +=
      \ [
      \   s:switch_builtins.ruby_hash_style,
      \   s:switch_builtins.ruby_string,
      \   s:switch_builtins.ruby_array_shorthand,
      \   s:switch_builtins.ruby_fetch,
      \   ['raise', 'fail'],
      \   ['be_truthy', 'be_falsey'],
      \   {
      \     '\.to ': '.to_not ',
      \     '\.not_to ': '.to ',
      \     '\.to_not ': '.to ',
      \   },
      \   {
      \     '\(expect(.*)\)\.to ':     '\1.to_not ',
      \     '\(expect(.*)\)\.to_not ': '\1.to ',
      \     '\(expect(.*)\)\.not_to ': '\1.to ',
      \   },
      \   ['if', 'unless'],
      \   ['while', 'until'],
      \   ['blank?', 'present?'],
      \   ['new_record?', 'persisted?']
      \ ]

let s:switch_filetype_definitions.ruby +=
      \ [
      \   [100, ':continue', ':information'],
      \   [101, ':switching_protocols'],
      \   [102, ':processing'],
      \   [200, ':ok', ':success'],
      \   [201, ':created'],
      \   [202, ':accepted'],
      \   [203, ':non_authoritative_information'],
      \   [204, ':no_content'],
      \   [205, ':reset_content'],
      \   [206, ':partial_content'],
      \   [207, ':multi_status'],
      \   [208, ':already_reported'],
      \   [226, ':im_used'],
      \   [300, ':multiple_choices'],
      \   [301, ':moved_permanently'],
      \   [302, ':found'],
      \   [303, ':see_other'],
      \   [304, ':not_modified'],
      \   [305, ':use_proxy'],
      \   [306, ':reserved'],
      \   [307, ':temporary_redirect'],
      \   [308, ':permanent_redirect'],
      \   [400, ':bad_request'],
      \   [401, ':unauthorized'],
      \   [402, ':payment_required'],
      \   [403, ':forbidden'],
      \   [404, ':not_found'],
      \   [405, ':method_not_allowed'],
      \   [406, ':not_acceptable'],
      \   [407, ':proxy_authentication_required'],
      \   [408, ':request_timeout'],
      \   [409, ':conflict'],
      \   [410, ':gone'],
      \   [411, ':length_required'],
      \   [412, ':precondition_failed'],
      \   [413, ':request_entity_too_large'],
      \   [414, ':request_uri_too_long'],
      \   [415, ':unsupported_media_type'],
      \   [416, ':requested_range_not_satisfiable'],
      \   [417, ':expectation_failed'],
      \   [422, ':unprocessable_entity'],
      \   [423, ':precondition_required'],
      \   [424, ':too_many_requests'],
      \   [426, ':request_header_fields_too_large'],
      \   [500, ':internal_server_error'],
      \   [501, ':not_implemented'],
      \   [502, ':bad_gateway'],
      \   [503, ':service_unavailable'],
      \   [504, ':gateway_timeout'],
      \   [505, ':http_version_not_supported'],
      \   [506, ':variant_also_negotiates'],
      \   [507, ':insufficient_storage'],
      \   [508, ':loop_detected'],
      \   [510, ':not_extended'],
      \   [511, ':network_authentication_required'],
      \ ]

" ------------------------------------------------------------------------------ }}}

" Eruby definitions {{{
" ------------------------------------------------------------------------------

let s:switch_filetype_definitions.eruby =
      \ [
      \   {
      \     '<%= \(.*\) %>':   '<% \1 %>',
      \     '<% \(.*\) -\?%>': '<%# \1 %>',
      \     '<%# \(.*\) %>':   '<%= \1 %>',
      \   },
      \   s:switch_builtins.ruby_hash_style,
      \   s:switch_builtins.ruby_string,
      \ ]

" ------------------------------------------------------------------------------ }}}

" HAML definitions {{{
" ------------------------------------------------------------------------------

let s:switch_filetype_definitions.haml =
      \ [
      \   s:switch_builtins.ruby_hash_style,
      \ ]

" ------------------------------------------------------------------------------ }}}

" Slim definitions {{{
" ------------------------------------------------------------------------------

let s:switch_filetype_definitions.slim =
      \ [
      \   s:switch_builtins.ruby_hash_style,
      \ ]

" ------------------------------------------------------------------------------ }}}

" JavaScript definitions {{{
" ------------------------------------------------------------------------------

let s:switch_filetype_definitions.javascript =
      \ [
      \   ['addClass', 'removeClass']
      \ ]

" ------------------------------------------------------------------------------ }}}

" Vim definitions {{{
" ------------------------------------------------------------------------------

let s:switch_filetype_definitions.vim =
      \ [
      \   ['g:', 'b:', 'l:', 's:'],
      \   ['map', 'nmap', 'imap', 'vmap', 'smap', 'xmap', 'cmap', 'omap'],
      \   ['noremap', 'nnoremap', 'inoremap', 'vnoremap', 'snoremap', 'xnoremap', 'cnoremap', 'onoremap'],
      \   ['unmap', 'nunmap', 'iunmap', 'vunmap', 'sunmap', 'xunmap', 'cunmap', 'ounmap'],
      \   ['<special>', '<silent>', '<buffer>', '<expr>'],
      \ ]

" ------------------------------------------------------------------------------ }}}

" git-rebase definitions {{{
" ------------------------------------------------------------------------------

let s:switch_filetype_definitions.gitrebase =
      \ [
      \   ['pick', 'reword', 'edit', 'squash', 'fixup', 'exec', 'drop', 'label', 'reset', 'merge'],
      \   { '^p ': 'reword ' },
      \   { '^r ':   'edit ' },
      \   { '^e ': 'squash ' },
      \   { '^s ':  'fixup ' },
      \   { '^f ':   'exec ' },
      \   { '^e ':   'drop ' },
      \   { '^d ':  'label ' },
      \   { '^l ':  'reset ' },
      \   { '^r ':  'merge ' },
      \   { '^m ':   'pick ' },
      \ ]

" ------------------------------------------------------------------------------ }}}

augroup RAPluginsSwitch
  autocmd!

  autocmd FileType css,scss   let b:switch_custom_definitions = s:switch_filetype_definitions.css
  autocmd FileType gitrebase  let b:switch_custom_definitions = s:switch_filetype_definitions.gitrebase
  autocmd FileType javascript let b:switch_custom_definitions = s:switch_filetype_definitions.javascript
  autocmd FileType ruby       let b:switch_custom_definitions = s:switch_filetype_definitions.ruby
  autocmd FileType eruby      let b:switch_custom_definitions = s:switch_filetype_definitions.eruby
  autocmd FileType haml       let b:switch_custom_definitions = s:switch_filetype_definitions.haml
  autocmd FileType slim       let b:switch_custom_definitions = s:switch_filetype_definitions.slim
  autocmd FileType vim        let b:switch_custom_definitions = s:switch_filetype_definitions.vim
augroup END

" ============================================================================== }}}

" Modeline {{{
" vim: set foldmarker={{{,}}} foldlevel=1 foldmethod=marker : }}}
