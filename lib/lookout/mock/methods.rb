# -*- coding: utf-8 -*-

class Lookout::Mock::Methods < Lookout::Stub::Methods
  def define(object, method, *args, &block)
    method = Lookout::Mock::Method.new(object, method, *args, &block)
    raise RuntimeError,
      '%s: cannot create mock as a mock has already been created: %s' %
        [method, @methods.first] unless @methods.empty?
    @methods << method.define
    method
  end

  def verify
    @methods.each do |method|
      method.verify
    end
    self
  end
end
