# frozen_string_literal: true

module LocalExtensions
  module IRB
    module Sidekiq
      def self.included(*)
        require "sidekiq/api"
      end

      unless respond_to?(:clear_sidekiq!)
        def clear_sidekiq!
          ::Sidekiq::RetrySet.new.clear
          puts "Cleared retry set"

          ::Sidekiq::ScheduledSet.new.clear
          puts "Cleared scheduled jobs"

          ::Sidekiq::Stats.new.reset
          puts "Cleared \"Processed\" and \"Failed\" jobs"

          ::Sidekiq::DeadSet.new.clear
          puts "Cleared \"Dead\" jobs statistics"

          ::Sidekiq::Queue.all(&:clear)
          puts "Cleard all queues"

          # Just to be sure
          ::Sidekiq.redis { |conn| conn.flushdb }
          puts "Flushed the Sidekiq Redis DB"
        end
      end
    end
  end
end
