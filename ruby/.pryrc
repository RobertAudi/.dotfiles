load File.expand_path("~/.irbrc")

Pry.config.editor = "vim"
Pry.config.hooks.add_hook(:after_session, :say_bye) do
  puts "bye-bye"
end

Pry.config.prompt = [
  proc { |obj, nest_level, pry| "#{RUBY_VERSION} (#{obj}):#{nest_level} > " },
  proc { |obj, nest_level, pry| "#{RUBY_VERSION} (#{obj}):#{nest_level} * " }
]

Pry.config.print = proc do |output, value|
  if defined?(Hirb)
    Hirb::View.view_or_page_output(value) || Pry::DEFAULT_PRINT.call(output, value)
  end

  if defined?(AwesomePrint)
    # Stolen from https://github.com/sheerun/dotfiles
    #   https://github.com/sheerun/dotfiles/blob/2b6a49718048f772f6ab80211e1072caac5c31dc/pryrc#L20-L22
    #
    # The following line enables awesome_print for all pry output,
    # and it also enables paging
    Pry::Helpers::BaseHelpers.stagger_output("=> #{value.ai}", output)
  end
end

if defined?(Hirb)
  Hirb.enable
end

if defined?(AwesomePrint)
  AwesomePrint.pry!
end

Pry.config.exception_handler = proc do |output, exception, _pry_|
  output.puts "#{exception.class}: #{exception.message}"
  output.puts exception.backtrace.first

  if exception.instance_of?(ActiveRecord::StatementInvalid) && exception.original_exception.is_a?(PG::Error)
    output.puts 'Rolling back transaction and starting a new one!'
    connection = ActiveRecord::Base.connection
    connection.rollback_db_transaction
    connection.begin_db_transaction
  end
end

Pry.commands.alias_command('w', 'whereami')
