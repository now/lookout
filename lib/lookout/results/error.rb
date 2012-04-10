# -*- coding: utf-8 -*-

# Represents an error result.  It’s used when the evalution of an expect block
# failed.
class Lookout::Results::Error
  include Lookout::Result

  def initialize(file, line, message, exception)
    super file, line
    @message, @exception = message, Lookout::Exception.new(exception)
  end

  def ==(other)
    super and message == other.message and exception == other.exception
  end

  def hash
    @hash ||= super ^ message.hash ^ exception.hash
  end

  def to_s
    [super, message, exception].compact.join(': ')
  end

  attr_reader :message, :exception
end
