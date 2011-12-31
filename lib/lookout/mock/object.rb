# -*- coding: utf-8 -*-

class Lookout::Mock::Object
  def inspect
    'mock'
  end

  private

  def method_missing(method, *args, &block)
    Lookout::Mock::Method::Calls::Exactly.new(0).call
  rescue Lookout::Mock::Method::Calls::TooManyError => e
    raise e, '%p#%s(%s): %s' % [self, method, Lookout::Inspect::Argument.list(args), e]
  end
end
