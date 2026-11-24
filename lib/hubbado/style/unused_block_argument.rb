# Finds unused block arguments, except in the block given to `template_method`, whose parameter
# list is the signature of the method it declares
module RuboCop
  module Cop
    module Hubbado
      class UnusedBlockArgument < Lint::UnusedBlockArgument
        def_node_matcher :template_method?, "(block (send _ :template_method ...) ...)"

        private

        def check_argument(variable)
          return if template_method?(variable.scope.node)

          super
        end
      end
    end
  end
end
