# -*- coding: utf-8 -*-

class Lookout::Stub::Methods
  def initialize
    @methods = []
  end

  def define(object, method, &body)
    method = Lookout::Stub::Method.new(object, method, &body)
    @methods << method
    method.define
  end

  def undefine
    @methods.each do |method|
      method.undefine
    end
    self
  end
end
