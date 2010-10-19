# -*- coding: utf-8 -*-

class Lookout::Mock::Methods < Lookout::Stub::Methods
  def define(object, method, *args, &block)
    # TODO: Improve on this error class/message.
    raise RuntimeError, 'mock already established' unless @methods.empty?
    Lookout::Mock::Method.new(object, method, *args, &block).define.tap{ |m| @methods << m }
  end

  def verify
    @methods.each do |method|
      method.verify
    end
    self
  end
end
