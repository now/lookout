# -*- coding: utf-8 -*-

# An error result used when the evalution of an {Expect expect block} failed.
class Lookout::Results::Error
  include Lookout::Result

  # (see Result#initialize)
  # An additional MESSAGE may also be associated with the result, which was
  # caused by EXCEPTION.
  # @param (see Result#initialize)
  # @param [String, nil] message Any additional message associated with this
  #   error
  # @param [Exception] exception The raised exception
  Value(:file, :line, :message, :exception, :comparable => [:file, :line])
  public :message, :exception

  def to_s; [super, message, exception.format].compact.join(': ') end
end
