# -*- coding: utf-8 -*-

# Object that doesn’t respond to anything and throws a mock error whenever it
# receives a method call.
class Lookout::Mock::Object < Lookout::Stub::Object
  def inspect; 'mock' end

  private

  # @param [Symbol] method
  # @param [Object, …] args
  # @raise [Method::Calls::TooManyError] When called, including the _method_
  #   that was called and with what _args_ in the messaged and with the proper
  #    backtrace, making it easy to see where things went wrong
  def method_missing(method, *args)
    Lookout::Mock::Method::Calls.new(0..0).call
  rescue Lookout::Mock::Method::Calls::TooManyError => e
    raise e, '%p#%s(%s)%s: %s' % [self,
                                  method,
                                  Lookout::Inspect::Argument.list(*args),
                                  block_given? ? '{ … }' : '',
                                  e]
  end
end
