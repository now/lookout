# -*- coding: utf-8 -*-

# A delayed wrapper that’ll set up a stub method on an object.  This method’ll
# be set up as soon as a method is called on it, using #method_missing.
class Lookout::Expect::Object::Context::Stub < Lookout::Aphonic
  # Prepares to define a stub method on _object_ inside the _stubs_ container.
  # @param [Stub::Methods] stubs
  # @param [::Object] object
  def initialize(stubs, object) @stubs, @object = stubs, object end

  private

  # @param (see Stub::Methods#define)
  # @param [::Object, …] args Any additional arguments
  # @return [::Object] The object with _method_ stubbed upon it, using _body_
  #   as the method definition
  # @raise [ArgumentError] If any additional arguments are given
  # @see Stub::Methods#define
  def method_missing(method, *args, &body)
    unless args.empty?
      stub = 'stub(…).%s' % method
      block = body ? '{ … }' : ''
      raise ArgumentError,
        'wrong number of arguments (%d for 0): %s(%s)%s should be %s%s' %
          [args.length,
           stub,
           Lookout::Inspect::Argument.list(*args),
           block,
           stub,
           block]
    end
    @stubs.define(@object, method, &body)
    @object
  end
end
