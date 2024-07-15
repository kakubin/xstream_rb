# frozen_string_literal: true

module Xstream
  module Producer
    module ArrayProducable
      def start(stream)
        each { stream.next(_1) }
      end

      def stop; end

      ::Array.include self
    end
  end
end
