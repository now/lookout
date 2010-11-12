# -*- coding: utf-8 -*-

class Lookout::Stub::Object
  def inspect
    'stub'
  end

  def method_missing(method, *args)
    self
  end
end
