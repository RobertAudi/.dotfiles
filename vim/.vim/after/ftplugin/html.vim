let b:match_words='<:>,<\@<=\([^/][^ \t>]*\)[^>]*\%(>\|$\):<\@<=/\1>'

setlocal omnifunc=htmlcomplete#CompleteTags
setlocal define=\\sid\\=
setlocal indentkeys-=*<Return>
setlocal foldmethod=manual

" jump from one block-level element to the next
nnoremap <silent> <buffer> ]] :call jump#Jump('/<\(html\\|body\\|head\\|address\\|article\\|aside\\|audio\\|blockquote\\|canvas\\|dd\\|div\\|dl\\|fieldset\\|figcaption\\|figure\\|footer\\|form\\|h1\\|header\\|hgroup\\|hr\\|noscript\\|ol\\|output\\|p\\|pre\\|section\\|table\\|tfoot\\|ul\\|video\)')<cr>
nnoremap <silent> <buffer> [[ :call jump#Jump('?<\(html\\|body\\|head\\|address\\|article\\|aside\\|audio\\|blockquote\\|canvas\\|dd\\|div\\|dl\\|fieldset\\|figcaption\\|figure\\|footer\\|form\\|h1\\|header\\|hgroup\\|hr\\|noscript\\|ol\\|output\\|p\\|pre\\|section\\|table\\|tfoot\\|ul\\|video\)')<cr>

let g:html_indent_script1 = 'inc'
let g:html_indent_style1  = 'inc'
let g:html_indent_inctags = 'html,body,head,tbody,p,li,dd,dt,h1,h2,h3,h4,h5,h6,blockquote,section'
