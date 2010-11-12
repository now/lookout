# -*- coding: utf-8 -*-

class Lookout::Mock::Object
  def inspect
    'mock'
  end

  def method_missing(method, *args, &block)
    raise Lookout::Mock::Method::Calls::Error,
      'unexpected call to %s' % Lookout::Mock::Method.new(self, method)
  end
end
