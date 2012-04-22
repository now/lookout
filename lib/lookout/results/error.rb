# -*- coding: utf-8 -*-

# An error result used when the evalution of an {Expect expect block} failed.
class Lookout::Results::Error
  include Lookout::Result

  # (see Result#initialize)
  # An additional _message_ may also be associated with the result, which was
  # caused by _exception_.
  # @param (see Result#initialize)
  # @param [String, nil] message
  # @param [Exception] exception
  def initialize(file, line, message, exception)
    super file, line
    @message, @exception = message, Lookout::Exception.new(exception)
  end

  # @param [Error] other
  # @return [Boolean] True if super passes and the receiver’s message and
  #   exception `#==` those of _other_
  def ==(other)
    super and message == other.message and exception == other.exception
  end

  alias eql? ==

  def hash
    @hash ||= super ^ [message, exception].hash
  end

  def to_s
    [super, message, exception].compact.join(': ')
  end

  # @return [String, nil] Any additional message associated with this error
  attr_reader :message

  # @return [Exception] The raised expection
  attr_reader :exception
end
