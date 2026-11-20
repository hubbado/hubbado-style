# Puts each argument of a multi-line call on its own line, counting each keyword argument as one,
# also where a block argument such as `&stream` follows the keywords
module RuboCop
  module Cop
    module Hubbado
      class MultilineMethodArgumentLineBreaks < Layout::MultilineMethodArgumentLineBreaks
        def on_send(node)
          return if node.method?(:[]=)

          arguments = node.arguments.flat_map do |argument|
            argument.hash_type? && !argument.braces? ? argument.children : [argument]
          end

          check_line_breaks(node, arguments, ignore_last: ignore_last_element?)
        end
        alias on_csend on_send
      end
    end
  end
end
