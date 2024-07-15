# frozen_string_literal: true

module Xstream
  module Operator
    module Operatorable
      def start(stream)
        @down_stream = stream
        @up_stream.add_listener(self)
      end

      def stop
        @up_stream.remove(self)
        @down_stream = NO
      end

      def next(value)
        return if @down_stream == NO

        @down_stream.next(value)
      end

      def error(error)
        return if @down_stream == NO

        @down_stream.error(error)
      end

      def complete
        return if @down_stream == NO

        @down_stream.complete
      end
    end
  end
end
