# -*- coding: utf-8 -*-

class Lookout::Mock::Method::Undefined < Lookout::Stub::Method::Undefined
  include Lookout::Mock::Method

  def define
    Defined.new(object, method, calls, *args, &body)
  end
end
