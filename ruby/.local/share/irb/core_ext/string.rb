# frozen_string_literal: true

module LocalExtensions
  module IRB
    module CoreExt
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
          def |(other)
            IO.popen(other, "r+") do |pipe|
              pipe.write(self)
              pipe.close_write
              pipe.read
            end
          end
        end
      end
    end
  end
end
