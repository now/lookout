# -*- coding: utf-8 -*-

# Mock method that has been defined on its object.  May be {#call}ed and
# {#undefine}d.
class Lookout::Mock::Method::Defined < Lookout::Stub::Method::Defined
  include Lookout::Mock::Method

  # @return [Undefined] The undefined version of this mock method after
  #   undefining it and checking that it was called the appropriate number of
  #   times
  # @raise (see Calls#verify)
  def undefine
    definition.undefine
    calls.verify
    Undefined.new(object, method, calls, *args, &body)
  rescue Lookout::Mock::Error => e
    raise e, '%s: %s' % [self, e]
  end

  private

  # @param [Object, …] args
  # @return [Object] The result of {super} after increasing the call count and
  #   checking for {Lookout::Difference differences} between the passed
  #   _args_ and the expected ones
  # @raise (see Calls#call)
  # @raise (see Arguments#verify)
  def call(*args, &block)
    calls.call
    self.args.verify(*args)
    super
  rescue Lookout::Mock::Error => e
    raise e, '%s: %s' % [self, e]
  end
end
