# -*- coding: utf-8 -*-

class Lookout::Stub::Object
  def inspect
    'stub'
  end

  def to_ary
    [self]
  end

  def respond_to?(method, include_private = false)
    true
  end

  def method_missing(method, *args)
    self
  end
end
