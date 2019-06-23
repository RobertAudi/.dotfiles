autocmd BufRead,BufNewFile Podfile   setfiletype ruby
autocmd BufRead,BufNewFile *.podspec setfiletype ruby
autocmd BufRead,BufNewFile *pryrc    setfiletype ruby
autocmd BufRead,BufNewFile *riplrc   setfiletype ruby

autocmd BufRead,BufNewFile Gemfile.local setfiletype ruby
autocmd BufRead,BufNewFile Gemfile.local.lock setfiletype gemfilelock
