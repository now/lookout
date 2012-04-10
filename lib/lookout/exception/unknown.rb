# -*- coding: utf-8 -*-

# Represents an Unknown exception class.
class Lookout::Exception::Unknown
  # @param [::Exception] exception The exception that was raised while trying
  #   to determine the exception’s class
  def initialize(exception)
    @exception = exception
  end

  # @raise [RuntimeError] Containing a message about why the exception’s class
  #   couldn’t be determined
  # @return [void] This method doesn’t return
  def name
    raise message
  end

  # @return [String] The message about why the exception’s class couldn’t be
  #   determined
  def inspect
    '(%s)' % message
  end

  private

  def message
    @message ||= 'cannot determine class of exception: %s' %
      Lookout::Exception.new(@exception).message
  end
end
