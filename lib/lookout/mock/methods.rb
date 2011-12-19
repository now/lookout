# -*- coding: utf-8 -*-

class Lookout::Mock::Methods < Lookout::Stub::Methods
  def define(object, method, calls, *args, &body)
    undefined = Lookout::Mock::Method::Undefined.
      new(object, method, calls, Lookout::Mock::Method::Arguments.new(*args), &body)
    raise RuntimeError,
      'can only mock one method per expectation: mock either %s or %s' %
        [@methods.first, undefined] unless @methods.empty?
    undefined.define.tap{ |defined| @methods << defined }
  end
end
