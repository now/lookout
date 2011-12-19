# -*- coding: utf-8 -*-

class Lookout::Stub::Methods
  def initialize
    @methods = []
  end

  def define(object, method, &body)
    Lookout::Stub::Method::Undefined.new(object, method, &body).define.tap{ |defined| @methods << defined }
  end

  def undefine
    @methods.each(&:undefine)
    self
  end
end
