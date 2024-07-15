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

    def map(&block)
      Stream.new(Operator::Map.new(self, block))
    end

    def filter(&block)
      Stream.new(Operator::Filter.new(self, block))
    end
  end
end
