# Finds an interpolation that runs over more than one line, which a reader takes for the end of
# the string; a value too long for one line is named before the string
module RuboCop
  module Cop
    module Hubbado
      class MultilineInterpolation < Base
        MSG = "Keep an interpolation on one line; name a longer value before the string.".freeze

        def on_dstr(node)
          node.each_child_node(:begin) do |interpolation|
            next if interpolation.first_line == interpolation.last_line

            add_offense(interpolation)
          end
        end
      end
    end
  end
end
