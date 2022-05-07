function! x2a#vim#plugins#OpenPluginRepoInBrowser() abort
  let l:line = getline('.')
  let l:pattern = '\v[[:blank:]]*<(Plug(in)?|NeoBundle(Fetch|Lazy)?)>[[:blank:]]'
  let l:match_position = match(l:line, l:pattern)

  if l:match_position >= 0
    let l:repo = substitute(substitute(l:line, l:pattern . "'", '', 'g'), "'.*", '', 'g')
    execute 'silent! !open -g https://github.com/' . l:repo
  endif
endfunction

function! x2a#vim#plugins#OpenPluginGitHubRepoInBrowser() abort
  let l:line = getline('.')
  let l:sha  = matchstr(l:line, '^  \zs[0-9a-f]\{7}\ze ')
  let l:name = empty(l:sha) ? matchstr(l:line, '^[-x+] \zs[^:]\+\ze:')
        \ : getline(search('^- .*:$', 'bn'))[2:-2]
  let l:uri  = get(get(g:plugs, l:name, {}), 'uri', '')

  if l:uri !~# 'github.com'
    return
  endif

  let l:repo = matchstr(l:uri, '[^:/]*/' . l:name)
  let l:url  = empty(l:sha) ? 'https://github.com/' . l:repo
        \ : printf('https://github.com/%s/commit/%s', l:repo, l:sha)

  call netrw#NetrwBrowseX(l:url, 0)
endfunction

" Description: Check if a Vim plugin is installed using vim-plug
" Credits: deris
" URL: https://github.com/deris/dotfiles
" Source: https://github.com/deris/dotfiles/blob/cb6b957b1ca449536e175195b4f1c0dfcdd066de/.vimrc#L29-L32
function! x2a#vim#plugins#isInstalled(name) abort
  let l:plugs = get(g:, 'plugs', {})
  return has_key(l:plugs, a:name) ? isdirectory(l:plugs[a:name].dir) : 0
endfunction

" function! x2a#vim#plugins#Install(...) abort
"   if len(a:000) == 0
"     let l:line = getline('.')
"     let l:pattern = '\v[[:blank:]]*<Plug>[[:blank:]]'
"     "                                          \v^[[:blank:]]*(<Plug>[[:blank:]]'[^']+'%(,[[:blank:]]*\{.*\}|\|<Plug>[[:blank:]]'[^']+')?)$
"     let l:matches = matchlist(l:line, "\v^[[:blank:]]*<Plug>[[:blank:]]'%([^/]+/)?([^']+)'$")
"     let l:plug_declaration = get(l:matches, 1, "")

"     if empty(l:plug_declaration)
"       " TODO: echo error
"       return
"     endif

"     let l:plug_name = get(l:matches, 2, "")

"     if empty(l:plug_name)
"       " TODO: echo error
"       return
"     endif


"   elseif get(a:000, 1) =~# ''

"   endif
" endfunction
