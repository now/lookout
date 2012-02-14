# -*- coding: utf-8 -*-

class Lookout::Expect::Object::Context::Stub < Lookout::Aphonic
  def initialize(stubs, object)
    @stubs, @object = stubs, object
  end

  private

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
