# frozen_string_literal: true

module LocalExtensions
  module IRB
    module Stream
      def self.included(*)
        require "tempfile"
      end

      unless respond_to?(:silence_stream)
        def silence_stream(stream)
          old_stream = stream.dup
          stream.reopen(IO::NULL)
          stream.sync = true
          yield
        ensure
          stream.reopen(old_stream)
          old_stream.close
        end
      end

      unless respond_to?(:quietly)
        def quietly(&block)
          silence_stream(STDOUT) do
            silence_stream(STDERR, &block)
          end
        end
      end

      unless respond_to?(:capture)
        def capture(stream)
          stream = stream.to_s
          captured_stream = Tempfile.new(stream)
          stream_io = eval("$#{stream}")
          origin_stream = stream_io.dup
          stream_io.reopen(captured_stream)

          yield

          stream_io.rewind
          captured_stream.read
        ensure
          captured_stream.close
          captured_stream.unlink
          stream_io.reopen(origin_stream)
        end
      end
    end
  end
end
