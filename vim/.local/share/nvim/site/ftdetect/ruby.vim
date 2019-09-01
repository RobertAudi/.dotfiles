autocmd BufRead,BufNewFile Podfile   setfiletype ruby
autocmd BufRead,BufNewFile *.podspec setfiletype ruby
autocmd BufRead,BufNewFile *pryrc    setfiletype ruby
autocmd BufRead,BufNewFile *riplrc   setfiletype ruby

autocmd BufRead,BufNewFile Gemfile.local setfiletype ruby
autocmd BufRead,BufNewFile Gemfile.local.lock setfiletype gemfilelock

autocmd BufRead,BufNewFile Rakefile,*.rake set filetype=ruby.rake
autocmd BufNewFile,BufRead *_spec.rb,spec_helper.rb,rails_helper.rb set filetype=ruby.rspec
