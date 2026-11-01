# Finds unused method arguments, except in a `record def`, where a substitute keeps
# parameters it does not use because `record` reads their names
module RuboCop
  module Cop
    module Hubbado
      class UnusedMethodArgument < Lint::UnusedMethodArgument
        def_node_matcher :record?, "(send nil? :record def)"

        private

        def check_argument(variable)
          return if record?(variable.scope.node.parent)

          super
        end
      end
    end
  end
end
