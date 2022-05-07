# frozen_string_literal: true

module LocalExtensions
  module IRB
    module CoreExt
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
          #   ri "Array#pop"
          #   Array.ri
          #   Array.ri :pop
          #   arr.ri :pop
          def ri(method = nil)
            unless method && method =~ /^[A-Z]/ # if class isn't specified
              klass = is_a?(Class) ? name : self.class.name
              method = [klass, method].compact.join("#")
            end
            puts `ri "#{method}"`
          end
        end
      end
    end
  end
end
