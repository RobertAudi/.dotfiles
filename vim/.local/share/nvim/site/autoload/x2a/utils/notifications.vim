" Credits: https://github.com/wsdjeg/notifications.vim

let s:messages = []
let s:shown = []
let s:buffer_id = nvim_create_buf(v:false, v:false)
let s:timer_id = -1
let s:win_is_open = v:false

function! s:close(...) abort
  if len(s:shown) == 1
    noautocmd call nvim_win_close(s:notification_winid, v:true)

    let s:win_is_open = v:false
  endif

  if !empty(s:shown)
    call add(s:messages, remove(s:shown, 0))
  endif
endfunction

function! s:notification(msg, color) abort
  call add(s:shown, a:msg)

  if s:win_is_open
    call nvim_win_set_config(s:notification_winid,
          \ {
          \   'relative': 'editor',
          \   'width': strwidth(a:msg),
          \   'height': len(s:shown),
          \   'row': 2,
          \   'col': &columns - strwidth(a:msg) - 3
          \ })
  else
    let s:notification_winid =  nvim_open_win(s:buffer_id, v:false,
          \ {
          \   'relative': 'editor',
          \   'width': strwidth(a:msg),
          \   'height': len(s:shown),
          \   'row': 2,
          \   'col': &columns - strwidth(a:msg) - 3
          \ })

    let s:win_is_open = v:true
  endif


  call nvim_buf_set_lines(s:buffer_id, 0 , -1, 0, s:shown)

  call setbufvar(s:buffer_id, '&winhighlight', 'Normal:' . a:color . ',EndOfBuffer:Conceal')
  call setbufvar(s:buffer_id, '&number', 0)
  call setbufvar(s:buffer_id, '&relativenumber', 0)
  call setbufvar(s:buffer_id, '&buftype', 'nofile')

  let s:timer_id = timer_start(2000, function('s:close'), {'repeat' : 1})
endfunction

" Display a regular message.
function! x2a#utils#notifications#Message(message) abort
  call s:notification(a:message, 'MoreMsg')
endfunction

" Display a warning message.
function! x2a#utils#notifications#Warning(message) abort
  call s:notification(a:message, 'WarningMsg')
endfunction

" Display an error message.
function! x2a#utils#notifications#Error(message) abort
  call s:notification(a:message, 'ErrorMsg')
  let v:errmsg = a:message
endfunction
