# -*- coding: utf-8 -*-

# Represents an error result.  Used when the evalution of an expect block
# failed.
class Lookout::Results::Error
  include Lookout::Result

  # @param (see Result#initialize)
  # @param [String, nil] message Any additional message associated with this
  #   error
  # @param [Exception] exception The raised expection
  def initialize(file, line, message, exception)
    super file, line
    @message, @exception = message, Lookout::Exception.new(exception)
  end

  # @param [Error] other
  # @return [Boolean] True if super passes and the receiver’s message and
  #   exception `#==` those of _other_
  # @extension
  def ==(other)
    super and message == other.message and exception == other.exception
  end

  def hash
    @hash ||= super ^ message.hash ^ exception.hash
  end

  def to_s
    [super, message, exception].compact.join(': ')
  end

  # @return [String, nil] Any additional message associated with this error
  attr_reader :message

  # @return [Exception] The raised expection
  attr_reader :exception
end
