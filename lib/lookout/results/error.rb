# -*- coding: utf-8 -*-

# An error result used when the evalution of an {Expect expect block} failed.
class Lookout::Results::Error
  include Lookout::Result

  # (see Result#initialize)
  # An additional _message_ may also be associated with the result, which was
  # caused by _exception_.
  # @param (see Result#initialize)
  # @param [String, nil] message Any additional message associated with this
  #   error
  # @param [Exception] exception The raised exception
  Value(:file, :line, :message, :exception, :comparable => [:file, :line])
  public :message, :exception
  def initialize(file, line, message, exception)
    super file, line, message, Lookout::Exception.new(exception)
  end

  def to_s
    [super, message, exception].compact.join(': ')
  end
end
