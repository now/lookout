# -*- coding: utf-8 -*-

class Lookout::Stub::Methods
  def initialize
    @methods = []
  end

  # TODO: Should we do this here, or should this work like #undefine, below?
  def <<(method)
    @methods << method.define
  end

  def undefine
    @methods.each do |method|
      method.undefine
    end
  end
end
