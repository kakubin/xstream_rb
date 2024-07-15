# frozen_string_literal: true

module Xstream
  module Producer
    class Periodic
      class Timer
        def initialize(period)
          @period = period
        end

        def start
          @thread = Thread.new do
            loop do
              yield
              sleep @period
            end
          end
        end

        def stop
          @thread.exit
        end
      end

      def initialize(period = 1)
        @count = 0
        @period = period
      end

      def start(stream)
        @timer = new_timer
        @timer.start do
          stream.next @count
          @count += 1
        end
      end

      def stop
        return unless @timer.nil?

        @timer.stop
        @timer = nil
      end

      private

      def new_timer
        Timer.new(@period)
      end
    end
  end
end
