# -*- coding: utf-8 -*-

# Mock method collection.  Keeps track of defined mock methods so that only one
# is defined at a time and so that that method may later be undefined properly.
class Lookout::Mock::Methods < Lookout::Stub::Methods
  class << self
    # Allows the mocking of methods via _methods_ during the execution of the
    # given block, returning the result of that block.  Any defined methods
    # will be undefined before this method returns.
    # @yieldparam [Methods] methods
    # @return [Object]
    def during
      methods = new
      begin
        yield(methods)
      rescue
        begin
          methods.undefine
        rescue Lookout::Mock::Method::Calls::Error
        end
        raise
      end.tap{ methods.undefine }
    end
  end

  # Defines _method_ on _object_, expecting it to be received _calls_ times
  # with _args_ and using _body_ as the method definition.
  # @param (see Method#initialize)
  # @return [self]
  # @raise [RuntimeError] If a mock method has already been defined, as only
  #   one method may be mocked at a time to ensure proper that limited – and
  #   proper – expectations are set
  def define(object, method, calls, *args, &body)
    undefined = Lookout::Mock::Method::Undefined.new(object, method, calls, *args, &body)
    raise RuntimeError,
      'can only mock one method per expectation: mock either %s or %s' %
        [@methods.first, undefined] unless @methods.empty?
    @methods << undefined.define
    self
  end
end
