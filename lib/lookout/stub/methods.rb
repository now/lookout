# -*- coding: utf-8 -*-

class Lookout::Stub::Methods
  def initialize
    @methods = []
  end

  def define(object, method, &body)
    @methods << Lookout::Stub::Method.new(object, method, &body).define
    self
  end

  def undefine
    @methods.each do |method|
      method.undefine
    end
    self
  end
end
