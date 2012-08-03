# -*- coding: utf-8 -*-

# Wraps an exception that was raised while trying to determine an exception’s
# class to make it behave like an exception class.
class Lookout::Exception::Unknown
  # Wraps the EXCEPTION that was raised while trying to determine an
  # exception’s class.
  # @param [::Exception] exception
  Value(:exception)

  # @raise [RuntimeError] Containing a message explaining that the exception’s
  #   class couldn’t be determined and why that is so
  def name; raise message end

  # @return The message explaining that the exception’s class couldn’t be
  #   determined and why that is so
  def inspect; '(%s)' % message end

  private

  def message
    @message ||= 'cannot determine class of exception: %s' %
      Lookout::Exception.new(exception)
  end
end
