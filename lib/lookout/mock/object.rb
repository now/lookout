# -*- coding: utf-8 -*-

class Lookout::Mock::Object
  def inspect
    'mock'
  end

  private

  def method_missing(method, *args, &block)
    raise Lookout::Mock::Method::Calls::Error,
      'unexpected call to %s' %
        Lookout::Mock::Method::Undefined.
          new(self,
              method,
              Lookout::Mock::Method::Calls::Exactly.new(method, 0),
              *args)
  end
end
