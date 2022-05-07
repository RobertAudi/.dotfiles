# frozen_string_literal: true

module LocalExtensions
  module IRB
    module REPL
      unless respond_to?(:clear)
        def clear
          system "clear"
        end
      end

      unless defined?(::Pry)
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
    end
  end
end
