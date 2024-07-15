# frozen_string_literal: true

module Xstream
  class Stream
    # include Listener

    class << self
      def periodic(period)
        new(Producer::Periodic.new(period))
      end
    end

    def initialize(producer)
      @producer = producer
      @listeners = []
    end

    def next(value)
      @listeners.each do |listener|
        listener.next(value)
      end
    end

    def error(value)
      @listeners.each do |listener|
        listener.error(value)
      end
    end

    def complete(value)
      @listeners.each do |listener|
        listener.complete(value)
      end
    end

    def add_listener(listener)
      @listeners << listener
      @producer.start(self)
    end

    def remove(listener)
      @listeners = @listeners.reject { _1 == listener }
    end

    def start_with(initial)
      self.class.new(Producer::StartWith.new(self, initial))
    end

    def map(&block)
      Stream.new(Operator::Map.new(self, block))
    end

    def filter(&block)
      Stream.new(Operator::Filter.new(self, block))
    end
  end
end
