# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Undefined < Lookout::Stub::Method::Undefined
  include Lookout::Mock::Method

  def initialize(object, method, calls, *args, &body)
    super object, method, &body
    @calls, @args = calls, Arguments.new(*args)
  end

  private

  def defined(visibility, unbound)
    Defined.new(object, method, visibility, unbound, calls, *args, &body)
  end
end
