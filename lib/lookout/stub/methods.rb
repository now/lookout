# -*- coding: utf-8 -*-

class Lookout::Stub::Methods
  def initialize
    @methods = []
  end

  def define(object, method, &body)
    Lookout::Stub::Method.new(object, method, &body).define.tap{ |m| @methods << m }
  end

  def undefine
    @methods.each do |method|
      method.undefine
    end
    self
  end
end
