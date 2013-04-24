# -*- coding: utf-8 -*-

# Error raised when a method is received too many times.
class Lookout::Reception::Error < StandardError
  class << self
    # @param [Reception] reception
    # @param [Integer] calls
    # @return [Error] A new error with a suitable error message for the
    #   RECEPTION of a method, where CALLS is outside the RANGE of expected
    #   calls.
    def from(reception, calls, range)
      new('%s: unexpected number of invocations (%d for %s)' %
          [reception,
           calls,
           if range.begin == range.end
             range.begin
           elsif range.end == 1.0/0
             '%d..' % range.begin
           else
             range
           end])
    end
  end
end
