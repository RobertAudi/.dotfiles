require "pp"
require "fileutils"
require "date"

# Gems {{{
# ---------------------------------------------------------------------
%w[hirb awesome_print did_you_mean table_flipper where_is].each do |gem|
  begin
    require gem
  rescue LoadError
  end
end
# --------------------------------------------------------------------- }}}

# Logger {{{
# ---------------------------------------------------------------------
begin
  require "active_support/logger"
  $logger_class = ActiveSupport::Logger
rescue LoadError
  require "logger"
  $logger_class = Logger
end
# --------------------------------------------------------------------- }}}

interpreter = (RUBY_DESCRIPTION rescue RUBY_VERSION)
puts "## #{interpreter}"
puts "`$logger_class' is `#{$logger_class.name}'"

# IRB-specific configuration {{{
# ---------------------------------------------------------------------
if defined?(IRB)
  require "irb/completion"
  require "irb/ext/save-history"

  IRB.conf[:PROMPT] ||= {}
  IRB.conf[:PROMPT][:MY_PROMPT] = {
    :PROMPT_I => ">> ",    # normal
    :PROMPT_N => "|  ",    # indenting
    :PROMPT_C => " > ",    # continuing a statement
    :PROMPT_S => "%l> ",   # continuing a string
    :RETURN   => "=> %s \n",
    :AUTO_INDENT => true
  }

  IRB.conf[:PROMPT_MODE]  = :MY_PROMPT
  IRB.conf[:AUTO_INDENT]  = true
  IRB.conf[:EVAL_HISTORY] = 10_000
  IRB.conf[:SAVE_HISTORY] = 10_000
  IRB.conf[:HISTORY_FILE] = File.expand_path(File.join(ENV.fetch("HOME", "~"), ".irbhistory"))

  defined?(Hirb) and Hirb.enable
  defined?(AwesomePrint) and AwesomePrint.irb!
end
# --------------------------------------------------------------------- }}}

if defined?(Rails)
  Rails.logger = $logger_class.new(STDOUT)
  ActionController::Base.logger = $logger_class.new(STDOUT)
end

# Local extensions and monkey patches {{{
# ---------------------------------------------------------------------
module LocalExtensions
  module Console
    # IRB {{{
    # ---------------------------------------------------------------------
    unless defined?(Pry)
      unless respond_to?(:clear)
        def clear
          system 'clear'
        end
      end

      unless respond_to?(:cat)
        # read file contents (also see ray for ruby source files ;) )
        def cat(path)
          File.read(path)
        end
      end

      unless respond_to?(:reset!)
        # Restart irb
        #
        # Stolen from Irbtools:
        #   https://github.com/janlelis/irbtools
        #   https://github.com/janlelis/irbtools/blob/05d50b2f3995a2ea90e5be3574668b3ca8b6897a/lib/every_day_irb.rb#L57-L68
        def reset!
          reset_irb = proc { exec $0 }
          at_exit(&reset_irb)
          exit
        end
      end
    end
    # --------------------------------------------------------------------- }}}

    # Ruby on Rails {{{
    # ---------------------------------------------------------------------
    if defined?(ActionController::Base)
      unless respond_to?(:controller_callbacks)
        def controller_callbacks(kinds: %i[before after around])
          unless respond_to?(:_process_action_callbacks)
            fail "The `_process_action_callbacks' method is not defined. Are you in the context of a Controller?"
          end

          _process_action_callbacks.each_with_object({}) do |c, obj|
            if kinds.include?(c.kind)
              obj[c.kind] ||= []
              obj[c.kind] << c.filter
            end
          end
        end

        %i[before after around].each do |kind|
          unless respond_to?("controller_#{kind}_callbacks")
            define_method("controller_#{kind}_callbacks") do
              controller_callbacks(kinds: [kind]).fetch(kind) { [] }
            end
          end
        end
      end
    end

    if defined?(ActiveRecord::Base)
      unless respond_to?(:redirect_active_record_log)
        def redirect_active_record_log(stream)
          ActiveRecord::Base.logger = $logger_class.new(stream)
          ActiveRecord::Base.clear_active_connections! and true
        end
        unless respond_to?(:redirect_activerecord_log)
          alias redirect_activerecord_log redirect_active_record_log
        end
      end

      unless respond_to?(:show_log)
        def show_log
          redirect_active_record_log(STDOUT)
        end
      end

      unless respond_to?(:hide_log)
        def hide_log
          redirect_active_record_log(nil)
        end
      end
    end
    # --------------------------------------------------------------------- }}}

    # Sidekiq {{{
    # ---------------------------------------------------------------------
    if defined?(Sidekiq)
      unless respond_to?(:clear_sidekiq!)
        def clear_sidekiq!
          require 'sidekiq/api'

          Sidekiq::RetrySet.new.clear
          puts "Cleared retry set"

          Sidekiq::ScheduledSet.new.clear
          puts "Cleared scheduled jobs"

          Sidekiq::Stats.new.reset
          puts "Cleared 'Processed' and 'Failed' jobs"


          Sidekiq::DeadSet.new.clear
          puts "Cleared 'Dead' jobs statistics"

          Sidekiq::Queue.all(&:clear)
          puts "Cleard all queues"

          # Just to be sure
          Sidekiq.redis { |conn| conn.flushdb }
          puts "Flushed the Sidekiq Redis DB"
        end
      end
    end
    # --------------------------------------------------------------------- }}}
  end

  # Object core extensions {{{
  # ---------------------------------------------------------------------
  module Object
    unless ::Object.public_method_defined?(:inheritance_chain)
      def inheritance_chain(obj = self)
        obj.class.ancestors - obj.class.included_modules
      end
    end

    unless ::Object.public_method_defined?(:modules)
      def modules(obj = self)
        obj.class.included_modules
      end
    end

    unless ::Object.public_method_defined?(:local_methods)
      # list methods which aren't in superclass
      def local_methods(obj = self)
        (obj.methods - obj.class.superclass.instance_methods).sort
      end
    end

    unless ::Object.public_method_defined?(:ri)
      # print documentation
      #
      #   ri 'Array#pop'
      #   Array.ri
      #   Array.ri :pop
      #   arr.ri :pop
      def ri(method = nil)
        unless method && method =~ /^[A-Z]/ # if class isn't specified
          klass = self.kind_of?(Class) ? name : self.class.name
          method = [klass, method].compact.join('#')
        end
        puts `ri '#{method}'`
      end
    end
  end
  # --------------------------------------------------------------------- }}}

  # String core extensions {{{
  # ---------------------------------------------------------------------
  module String
    unless ::String.public_method_defined?(:|)
      # This extension adds a UNIX-style pipe to strings
      #
      # Synopsis:
      #
      # >> puts "UtilityBelt is better than alfalfa" | "cowsay"
      #  ____________________________________
      # < UtilityBelt is better than alfalfa >
      #  ------------------------------------
      #         \   ^__^
      #          \  (oo)\_______
      #             (__)\       )\/\
      #                 ||----w |
      #                 ||     ||
      # => nil
      #
      def |(cmd)
        IO.popen(cmd, 'r+') do |pipe|
          pipe.write(self)
          pipe.close_write
          pipe.read
        end
      end
    end
  end
  # --------------------------------------------------------------------- }}}
end

include(LocalExtensions::Console)
Object.include(LocalExtensions::Object)
String.include(LocalExtensions::String)
# --------------------------------------------------------------------- }}}

# Modeline {{{
# vim: set foldmarker={{{,}}} foldlevel=0 foldmethod=marker : }}}
