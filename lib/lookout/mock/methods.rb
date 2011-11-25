# -*- coding: utf-8 -*-

class Lookout::Mock::Methods < Lookout::Stub::Methods
  def define(object, method, *args, &block)
    method = Lookout::Mock::Method.new(object, method, *args, &block)
    raise RuntimeError,
      'can only mock one method per expectation: mock either %s or %s' %
        [@methods.first, method] unless @methods.empty?
    @methods << method
    method.define
  end
end
