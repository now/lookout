# -*- coding: utf-8 -*-

class Lookout::Stub::Method::Undefined
  include Lookout::Stub::Method

  def define
    Defined.new(object, method, &body)
  end
end
