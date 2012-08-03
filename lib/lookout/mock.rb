# -*- coding: utf-8 -*-

# Object that doesn’t respond to anything except for what’s been explicitly
# defined on it and throws a mock error whenever it receives a method call.
class Lookout::Mock < Lookout::Stub
  def inspect; 'mock' end

  private

  # @param [Symbol] method
  # @param [Object, …] args
  # @raise [Reception::Error] When called, including the METHOD that was called
  #   and with what ARGS in the messaged and with the proper backtrace, making
  #   it easy to see where things went wrong
  def method_missing(method, *args)
    raise Lookout::Reception::Error.
      from('%p#%s(%s)%s' % [self,
                            method,
                            Lookout::Inspect::Argument.list(*args),
                            block_given? ? '{ … }' : ''],
           1,
           0..0)
  end
end
