# frozen_string_literal: true

module Xstream
  module Producer
    class StartWith
      def initialize(stream, value)
        @upstream = stream
        @value = value
      end

      def start(stream)
        @downstream = stream
        @downstream.next(@value)
        @upstream.add_listener(@downstream)
      end

      def stop
        @upstream.remove(@downstream)
        @downstream = NO
      end
    end
  end
end
