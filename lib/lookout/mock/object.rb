# -*- coding: utf-8 -*-

class Lookout::Mock::Object < Lookout::Aphonic
  undef extend
  undef is_a?

  def to
    Lookout::Recorder.new(self)
  end

  def not
    Lookout::Not.new(self)
  end

  def inspect
    'mock'
  end

  def method_missing(method, *args, &block)
    raise Lookout::Mock::Method::Calls::Error,
      'unexpected call to %s' % Lookout::Mock::Method.new(self, method)
  end
end
