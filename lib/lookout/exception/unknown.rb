# -*- coding: utf-8 -*-

# Wraps an exception that was raised while trying to determine an exception’s
# class to make it behave like an exception class.
class Lookout::Exception::Unknown
  # Wraps the _exception_ that was raised while trying to determine an
  # exception’s class.
  # @param [::Exception] exception
  def initialize(exception)
    @exception = exception
  end

  # @raise [RuntimeError] Containing a message explaining that the exception’s
  #   class couldn’t be determined and why that is so
  def name
    raise message
  end

  # @return [String] The message explaining that the exception’s class couldn’t
  #   be determined and why that is so
  def inspect
    '(%s)' % message
  end

  # @param [Unknown] other
  # @return [Boolean] True if the receiver’s class and exception `#==` those of
  #   _other_
  def ==(other)
    self.class == other.class and exception == other.exception
  end

  alias eql? ==

  def hash
    exception.hash
  end

  protected

  attr_reader :exception

  private

  def message
    @message ||= 'cannot determine class of exception: %s' %
      Lookout::Exception.new(exception).message
  end
end
