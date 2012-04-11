# -*- coding: utf-8 -*-

# A delayed wrapper that will set up a stub method on an object.  This method
# will be set up as soon as a method is called on it, using #method_missing.
class Lookout::Expect::Object::Context::Stub < Lookout::Aphonic
  # @param [Stub::Methods] stubs The stub methods container to set the stub
  #   method in
  # @param [Object] object The object to stub a method upon
  def initialize(stubs, object)
    @stubs, @object = stubs, object
  end

  private

  # @param [Symbol] method
  # @param [Object, …] *args
  # @param [Proc] &body
  # @return [Object] The object with _method_ stubbed upon it, using _body_ as
  #   the method definition
  # @raise [ArgumentError] If any additional arguments are given
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
