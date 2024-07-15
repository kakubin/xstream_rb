# frozen_string_literal: true

module Xstream
  module Operator
    class Filter
      include Operatorable

      def initialize(up_stream, block)
        @up_stream = up_stream
        @block = block
      end

      def next(value)
        @down_stream.next(value) if @block.call(value)
      end
    end
  end
end
