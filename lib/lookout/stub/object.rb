# -*- coding: utf-8 -*-

class Lookout::Stub::Object < Lookout::Aphonic
  def respond_to?(method, include_private = false)
    true
  end

  def method_missing(method)
    self
  end
end
