# -*- coding: utf-8 -*-

class Lookout::Stub::Methods
  def initialize
    @methods = []
  end

  def define(object, method, &body)
    @methods << Lookout::Stub::Method::Undefined.new(object, method, &body).define
    self
  end

  def undefine
    @methods.each(&:undefine)
    self
  end
end
