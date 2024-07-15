# frozen_string_literal: true

require_relative "xstream/version"
require_relative "xstream/producer"

module Xstream
  class Error < StandardError; end

  NO = nil

  autoload :Stream, "xstream/stream"
  autoload :Operator, "xstream/operator"
end
