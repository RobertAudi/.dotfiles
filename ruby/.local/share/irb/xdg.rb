# frozen_string_literal: true

begin
  require "xdg"
rescue LoadError
end

module LocalExtensions
  module IRB
    module XDG
      if defined?(::XDG::Environment)
        unless method_defined?(:xdg)
          def xdg
            @xdg ||= ::XDG::Environment.new
          end
        end
      else
        class Environment
          %w[cache config data].each do |dir|
            define_method "#{dir}_home" do
              if instance_variable_defined?("@#{dir}_home")
                instance_variable_get("@#{dir}_home")
              else
                instance_variable_set("@#{dir}_home", ENV["XDG_#{dir.upcase}_HOME"])
              end
            end

            define_method "#{dir}_dirs" do
              if instance_variable_defined?("@#{dir}_dirs")
                instance_variable_get("@#{dir}_dirs")
              else
                instance_variable_set("@#{dir}_dirs", ENV["XDG_#{dir.upcase}_DIRS"].to_s.split(":").compact)
              end
            end
          end
        end

        unless method_defined?(:xdg)
          def xdg
            @xdg ||= Environment.new
          end
        end
      end
    end
  end
end
