# -*- coding: utf-8 -*-

class Lookout::Mock::Object
  def inspect
    'mock'
  end

  private

  def method_missing(method, *args, &block)
    Lookout::Mock::Method::Defined.
      new(self,
          method,
          Lookout::Mock::Method::Calls::Exactly.new(0)).call
  end
end
