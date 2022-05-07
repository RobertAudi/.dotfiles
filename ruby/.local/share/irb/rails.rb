# frozen_string_literal: true

module LocalExtensions
  module IRB
    module Rails
      def self.included(*)
        unless defined?($logger_class)
          begin
            require "active_support/logger"
            $logger_class = ::ActiveSupport::Logger
          rescue LoadError
            require "logger"
            $logger_class = ::Logger
          end
        end

        ::Rails.logger = $logger_class.new(STDOUT)
        ::ActionController::Base.logger = $logger_class.new(STDOUT)
      end

      if defined?(::ActionController::Base)
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

      if defined?(::ActiveRecord::Base)
        if defined?(::PG)
          unless respond_to?(:unfuck_activerecord_transaction)
            def unfuck_activerecord_transaction
              puts "Rolling back transaction and starting a new one!"

              connection = ::ActiveRecord::Base.connection
              connection.rollback_db_transaction
              connection.begin_db_transaction
            end
          end
        end

        unless respond_to?(:redirect_active_record_log)
          def redirect_active_record_log(stream)
            ::ActiveRecord::Base.logger = $logger_class.new(stream)
            ::ActiveRecord::Base.clear_active_connections! and true
          end

          unless respond_to?(:redirect_activerecord_log)
            alias_method :redirect_activerecord_log, :redirect_active_record_log
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
    end
  end
end

