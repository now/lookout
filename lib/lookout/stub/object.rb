# -*- coding: utf-8 -*-

# TODO: This class should respond to #inspect.
class Lookout::Stub::Object < Lookout::Aphonic
  def to
    Lookout::Recorder.new(self)
  end

  def not
    Lookout::Not.new(self)
  end

  def respond_to?(method, include_private = false)
    true
  end

  def method_missing(method, *args)
    self
  end
end
